//
//  FLMessageViewController.m
//  Footloose
//
//  Created by kevin on 5/17/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import "FLMessageViewController.h"

#import "FLContactViewController.h"
#import "FLAddContactViewController.h"

#import "FLTitleView.h"
#import "FLContactInfoMainView.h"

#import "JSQMessage+Footloose.h"

#import <JSQMessagesViewController/JSQMessages.h>
#import <SlideNavigationController.h>
#import <Firebase/Firebase.h>
#import <AFNetworking/AFNetworking.h>
#import <FXBlurView/FXBlurView.h>

@interface FLMessageViewController () <SlideNavigationControllerDelegate, FLContactViewDelegate, FLAddContactDelegate, UIAlertViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) FLUser *user;
@property (nonatomic, strong) FLUser *recipient;

@property (strong, nonatomic) NSMutableArray *messages;
@property (copy, nonatomic) NSDictionary *avatars;

@property (strong, nonatomic) UIImageView *outgoingBubbleImageView;
@property (strong, nonatomic) UIImageView *incomingBubbleImageView;

@property (nonatomic, strong) UIAlertView *addContactAlertView;
@property (nonatomic, strong) NSString *selectedPhoneNumber;

@property (nonatomic, strong) Firebase *firebase;
@property (nonatomic, assign) FirebaseHandle *firebaseHandle;
@property (nonatomic, assign) BOOL doneFetchingFlag;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) FLTitleView *titleView;
@property (nonatomic, strong) FLContactInfoMainView *contactInfoView;
@end

NSString *const kFirebaseBaseURL = @"https://footloose.firebaseio.com/";
NSString *const kPreambleBaseURL = @"http://preamble.herokuapp.com/";


@implementation FLMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.user = [[FLUser alloc] initWithName:@"Kevin Nguy"
                                   phoneNumber:@"9009001111"
                                  profileImage:[UIImage imageNamed:@"kevin"]];
    self.sender = self.user.phoneNumber;
    
    FLContactViewController *contactTableViewController = (FLContactViewController *)[SlideNavigationController sharedInstance].leftMenu;
    contactTableViewController.delegate = self;
    contactTableViewController.userNameLabel.text = @"Kevin Nguy";
    contactTableViewController.userProfileView.image = [UIImage imageNamed:@"kevin"];
    
    FLAddContactViewController *addContactViewController = (FLAddContactViewController *)[SlideNavigationController sharedInstance].rightMenu;
    addContactViewController.delegate = self;
    
    [SlideNavigationController sharedInstance].leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"contact"] style:UIBarButtonItemStyleBordered target:nil action:nil];
    [SlideNavigationController sharedInstance].rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    
    self.recipient = contactTableViewController.contactArray.firstObject;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss ZZZ";
    /**
     *  Remove camera button since media messages are not yet implemented
     *
     *   self.inputToolbar.contentView.leftBarButtonItem = nil;
     *
     *  Or, you can set a custom `leftBarButtonItem` and a custom `rightBarButtonItem`
     */
    
    self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeMake(5, 0);
    self.collectionView.collectionViewLayout.outgoingAvatarViewSize = self.collectionView.collectionViewLayout.incomingAvatarViewSize;
    self.outgoingBubbleImageView = [JSQMessagesBubbleImageFactory
                                    outgoingMessageBubbleImageViewWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
    
    self.incomingBubbleImageView = [JSQMessagesBubbleImageFactory
                                    incomingMessageBubbleImageViewWithColor:[UIColor footlooseLightPrimaryColor]];
    
    self.addContactAlertView = [[UIAlertView alloc] initWithTitle:@"Add name to this contact?" message:nil delegate:nil cancelButtonTitle:@"No" otherButtonTitles:@"Okay", nil];
    self.addContactAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    self.addContactAlertView.delegate = self;
    UITextField *textField = [self.addContactAlertView textFieldAtIndex:0];
    textField.placeholder = @"John Doe";
    textField.keyboardType = UIKeyboardTypeAlphabet;
    textField.autocapitalizationType = UITextAutocapitalizationTypeWords;

    [self setupMessages];
    
}

- (void)titleButtonPressed:(id)sender
{
    self.contactInfoView.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.contactInfoView = [[FLContactInfoMainView alloc] initWithFrame:self.view.frame delegate:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    self.collectionView.collectionViewLayout.springinessEnabled = NO;
}

- (void)setupMessages
{
    self.firebase = [[Firebase alloc] initWithUrl:kFirebaseBaseURL];
    self.firebase = [self.firebase childByAppendingPath:self.user.phoneNumber];
    self.firebase = [self.firebase childByAppendingPath:self.recipient.phoneNumber];
    
    self.navigationItem.titleView = nil;
    if (self.recipient.name.length) {
        self.title = self.recipient.name;
    } else {
        self.title = [NSString stringWithFormat:@"(%@) %@-%@",
                      [self.recipient.phoneNumber substringWithRange:NSMakeRange(0, 3)],
                      [self.recipient.phoneNumber substringWithRange:NSMakeRange(3, 3)],
                      [self.recipient.phoneNumber substringWithRange:NSMakeRange(6, 4)]];
    }
    
    self.titleView = [[FLTitleView alloc] initWithFrame:CGRectZero
                                                  title:self.title
                                           profileImage:self.recipient.profileImage
                                                 target:self
                                               selector:@selector(titleButtonPressed:)];
    
    self.navigationItem.titleView = self.titleView;

    self.messages = [NSMutableArray new];

    [self.firebase observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        JSQMessage *message = [[JSQMessage alloc] initWithText:[snapshot.value objectForKey:@"text"]
                                                        sender:[snapshot.value objectForKey:@"sender"]
                                                          date:[self.dateFormatter dateFromString:[snapshot.value objectForKey:@"timestamp"]]];
        
        if ([message.sender isEqualToString:self.user.phoneNumber] || [message.sender isEqualToString:self.recipient.phoneNumber]) {
            [self.messages addObject:message];

            if (self.doneFetchingFlag) {
                [self.collectionView reloadData];
                [self scrollToBottomAnimated:YES];
            }
        }
        else {
            // Got a message from someone else
//            [[SlideNavigationController sharedInstance] bounceMenu:MenuLeft withCompletion:nil];
        }
        

    }];
    
    [self.firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        [self.collectionView reloadData];
        [self scrollToBottomAnimated:YES];
        self.doneFetchingFlag = YES;
    }];
}



#pragma mark - JSQMessagesViewController method overrides

- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                    sender:(NSString *)sender
                      date:(NSDate *)date
{
    [JSQSystemSoundPlayer jsq_playMessageSentSound];
    
    JSQMessage *message = [[JSQMessage alloc] initWithText:text sender:sender date:date];
    [self.firebase.childByAutoId setValue:[message JSONFormatWithDateFormatter:self.dateFormatter]];
    
    [self finishSendingMessage];
}

- (void)didPressAccessoryButton:(UIButton *)sender
{
    NSLog(@"Camera pressed!");

    self.showTypingIndicator = !self.showTypingIndicator;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        JSQMessage *message = [[JSQMessage alloc] initWithText:[NSString stringWithFormat:@"I like number %d", arc4random() % 100]
                                                        sender:self.recipient.phoneNumber
                                                          date:[NSDate date]];

        [self.firebase.childByAutoId setValue:[message JSONFormatWithDateFormatter:self.dateFormatter]];
        
        [JSQSystemSoundPlayer jsq_playMessageReceivedSound];
        [self finishReceivingMessage];
    });
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.contactInfoView.contactInfoScrollView) {
        float fractionalPage = scrollView.contentOffset.y / CGRectGetHeight(scrollView.frame);
        NSInteger page = lround(fractionalPage);
        
        if (page == 0 || page == 2) {
            self.contactInfoView.hidden = YES;
        }
    }
}


#pragma mark - JSQMessages CollectionView DataSource

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.messages objectAtIndex:indexPath.item];
}

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView bubbleImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  You may return nil here if you do not want bubbles.
     *  In this case, you should set the background color of your collection view cell's textView.
     */
    
    /**
     *  Reuse created bubble images, but create new imageView to add to each cell
     *  Otherwise, each cell would be referencing the same imageView and bubbles would disappear from cells
     */
    
    JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
    
    if ([message.sender isEqualToString:self.user.phoneNumber]) {
        return [[UIImageView alloc] initWithImage:self.outgoingBubbleImageView.image
                                 highlightedImage:self.outgoingBubbleImageView.highlightedImage];
    }
    
    return [[UIImageView alloc] initWithImage:self.incomingBubbleImageView.image
                             highlightedImage:self.incomingBubbleImageView.highlightedImage];
}

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.collectionView.collectionViewLayout.outgoingAvatarViewSize.width, 0)];
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  This logic should be consistent with what you return from `heightForCellTopLabelAtIndexPath:`
     *  The other label text delegate methods should follow a similar pattern.
     *
     *  Show a timestamp for every 3rd message
     */
    if (indexPath.item % 3 == 0) {
        JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
        return [[JSQMessagesTimestampFormatter sharedFormatter] attributedTimestampForDate:message.date];
    }
    
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
//    JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
//    
//    /**
//     *  iOS7-style sender name labels
//     */
//    if ([message.sender isEqualToString:self.user.phoneNumber]) {
//        return nil;
//    }
//    
//    if (indexPath.item - 1 > 0) {
//        JSQMessage *previousMessage = [self.messages objectAtIndex:indexPath.item - 1];
//        if ([[previousMessage sender] isEqualToString:message.sender]) {
//            return nil;
//        }
//    }
//    
//    /**
//     *  Don't specify attributes to use the defaults.
//     */
//    return [[NSAttributedString alloc] initWithString:message.sender];
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.messages count];
}

- (UICollectionViewCell *)collectionView:(JSQMessagesCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Override point for customizing cells
     */
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    /**
     *  Configure almost *anything* on the cell
     *
     *  Text colors, label text, label colors, etc.
     *
     *
     *  DO NOT set `cell.textView.font` !
     *  Instead, you need to set `self.collectionView.collectionViewLayout.messageBubbleFont` to the font you want in `viewDidLoad`
     *
     *
     *  DO NOT manipulate cell layout information!
     *  Instead, override the properties you want on `self.collectionView.collectionViewLayout` from `viewDidLoad`
     */
    
    JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
    
    if ([message.sender isEqualToString:self.user.phoneNumber]) {
        cell.textView.textColor = [UIColor blackColor];
    }
    else {
        cell.textView.textColor = [UIColor whiteColor];
    }
    
    cell.textView.linkTextAttributes = @{ NSForegroundColorAttributeName : cell.textView.textColor,
                                          NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid) };
    
    return cell;
}


#pragma mark - JSQMessages collection view flow layout delegate

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Each label in a cell has a `height` delegate method that corresponds to its text dataSource method
     */
    
    /**
     *  This logic should be consistent with what you return from `attributedTextForCellTopLabelAtIndexPath:`
     *  The other label height delegate methods should follow similarly
     *
     *  Show a timestamp for every 3rd message
     */
    if (indexPath.item % 3 == 0) {
        return kJSQMessagesCollectionViewCellLabelHeightDefault;
    }
    
    return 10.0f;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  iOS7-style sender name labels
     */
    JSQMessage *currentMessage = [self.messages objectAtIndex:indexPath.item];
    if ([[currentMessage sender] isEqualToString:self.user.phoneNumber]) {
        return 0.0f;
    }
    
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [self.messages objectAtIndex:indexPath.item - 1];
        if ([[previousMessage sender] isEqualToString:[currentMessage sender]]) {
            return 0.0f;
        }
    }
    
    return kJSQMessagesCollectionViewCellLabelHeightDefault;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 0.0f;
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView
                header:(JSQMessagesLoadEarlierHeaderView *)headerView didTapLoadEarlierMessagesButton:(UIButton *)sender
{
    NSLog(@"Load earlier messages!");
}

#pragma mark - SlideNavigationControllerDelegate
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
	return YES;
}

#pragma mark - FLContactTableViewDelegate
- (void)didSelectUser:(FLUser *)user
{
    self.recipient = user;
    [self setupMessages];

    [[SlideNavigationController sharedInstance] closeMenuWithCompletion:nil];
}

#pragma mark - FLAddContactDelegate
- (void)didConnectWithPhoneNumber:(NSString *)phoneNumber
{
    self.selectedPhoneNumber = phoneNumber;
    
    if (self.selectedPhoneNumber.length == 11) {
        self.selectedPhoneNumber = [phoneNumber substringFromIndex:1];
    }
    
    [self.addContactAlertView show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.addContactAlertView) {
        NSString *name = [self.addContactAlertView textFieldAtIndex:0].text;
        [self.addContactAlertView textFieldAtIndex:0].text = nil;
        
        self.recipient = [[FLUser alloc] initWithName:name
                                          phoneNumber:self.selectedPhoneNumber
                                         profileImage:[UIImage imageNamed:@"avatar"]];
        

        [self setupMessages];
        
        [self didPressSendButton:nil
                 withMessageText:@"Take a look at my resume!"
                          sender:self.user.phoneNumber
                            date:[NSDate date]];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kPreambleBaseURL]];
        NSDictionary *parameters = @{@"message" : @"Take a look at my resume! google.com",
                                     @"number" : [@"+1" stringByAppendingString:self.selectedPhoneNumber]};
        
        [manager POST:@"/message"
           parameters:parameters
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  
              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                  
              }];
    }
}

@end
