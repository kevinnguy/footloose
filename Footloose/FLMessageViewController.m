//
//  FLMessageViewController.m
//  Footloose
//
//  Created by kevin on 5/17/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import "FLMessageViewController.h"

#import "FLContactTableViewController.h"
#import "FLAddContactViewController.h"

#import <JSQMessagesViewController/JSQMessages.h>
#import <SlideNavigationController.h>
#import <Firebase/Firebase.h>

@interface FLMessageViewController () <SlideNavigationControllerDelegate, FLContactTableViewDelegate, FLAddContactDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) FLUser *user;
@property (nonatomic, strong) FLUser *recipient;

@property (strong, nonatomic) NSMutableArray *messages;
@property (copy, nonatomic) NSDictionary *avatars;

@property (strong, nonatomic) UIImageView *outgoingBubbleImageView;
@property (strong, nonatomic) UIImageView *incomingBubbleImageView;

@property (nonatomic, strong) UIAlertView *addContactAlertView;
@property (nonatomic, strong) NSString *selectedPhoneNumber;

@property (nonatomic, strong) Firebase *firebase;
@end

NSString *const kFirebaseURL = @"https://footloose.firebaseio.com/";

@implementation FLMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.user = [[FLUser alloc] initWithName:@"Kevin Nguy"
                                   phoneNumber:@"4153956852"
                                  profileImage:[UIImage imageNamed:@"kevin"]];
    self.sender = self.user.phoneNumber;
    
    FLContactTableViewController *contactTableViewController = (FLContactTableViewController *)[SlideNavigationController sharedInstance].leftMenu;
    contactTableViewController.delegate = self;
    
    FLAddContactViewController *addContactViewController = (FLAddContactViewController *)[SlideNavigationController sharedInstance].rightMenu;
    addContactViewController.delegate = self;
    
    self.recipient = contactTableViewController.contactArray.firstObject;
    
    
    [self setupMessages];
    
    /**
     *  Remove camera button since media messages are not yet implemented
     *
     *   self.inputToolbar.contentView.leftBarButtonItem = nil;
     *
     *  Or, you can set a custom `leftBarButtonItem` and a custom `rightBarButtonItem`
     */
    

    self.outgoingBubbleImageView = [JSQMessagesBubbleImageFactory
                                    outgoingMessageBubbleImageViewWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
    
    self.incomingBubbleImageView = [JSQMessagesBubbleImageFactory
                                    incomingMessageBubbleImageViewWithColor:[UIColor jsq_messageBubbleGreenColor]];
    
    self.addContactAlertView = [[UIAlertView alloc] initWithTitle:@"Add name to this contact?" message:nil delegate:nil cancelButtonTitle:@"No" otherButtonTitles:@"Okay", nil];
    self.addContactAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    self.addContactAlertView.delegate = self;
    UITextField *textField = [self.addContactAlertView textFieldAtIndex:0];
    textField.placeholder = @"John Doe";
    textField.keyboardType = UIKeyboardTypeAlphabet;
    textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    self.collectionView.collectionViewLayout.springinessEnabled = NO;
}

- (void)setupMessages
{
//    self.firebase = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@/%@", kFirebaseURL, self.user.phoneNumber, self.recipient.phoneNumber]];
    
    if (self.recipient.name.length) {
        self.title = self.recipient.name;
    } else {
        self.title = [NSString stringWithFormat:@"(%@) %@-%@",
                      [self.recipient.phoneNumber substringWithRange:NSMakeRange(0, 3)],
                      [self.recipient.phoneNumber substringWithRange:NSMakeRange(3, 3)],
                      [self.recipient.phoneNumber substringWithRange:NSMakeRange(6, 4)]];
    }
    
//    NSDictionary *message = @{
//                              @"sender" : self.user.phoneNumber,
//                              @"message" : @"Hey there testing",
//                              @"timestamp" : [NSDate date]
//                              };
//    
//    [[self.firebase childByAutoId] setValue:message];
//    
//    message = @{
//                @"sender" : self.recipient.phoneNumber,
//                @"message" : @"What's up",
//                @"timestamp" : [NSDate date]
//                };
//    
//    [[self.firebase childByAutoId] setValue:message];
    
    
    
    
    
    
    
    CGFloat outgoingDiameter = self.collectionView.collectionViewLayout.outgoingAvatarViewSize.width;
    UIImage *senderImage = [JSQMessagesAvatarFactory avatarWithImage:[UIImage imageNamed:@"kevin"]
                                                            diameter:outgoingDiameter];
    
    CGFloat incomingDiameter = self.collectionView.collectionViewLayout.incomingAvatarViewSize.width;
    UIImage *recipientImage = [JSQMessagesAvatarFactory avatarWithImage:self.recipient.profileImage
                                                               diameter:incomingDiameter];
    
    self.avatars = @{ self.user.phoneNumber : senderImage,
                      self.recipient.phoneNumber : recipientImage };
    
    self.messages = [[NSMutableArray alloc] initWithObjects:
                     [[JSQMessage alloc] initWithText:@"Welcome to JSQMessages: A messaging UI framework for iOS." sender:self.sender date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"It is simple, elegant, and easy to use. There are super sweet default settings, but you can customize like crazy." sender:self.recipient.phoneNumber date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"It even has data detectors. You can call me tonight. My cell number is 123-456-7890. My website is www.hexedbits.com." sender:self.sender date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"JSQMessagesViewController is nearly an exact replica of the iOS Messages App. And perhaps, better." sender:self.recipient.phoneNumber date:[NSDate date]],
                     [[JSQMessage alloc] initWithText:@"It is unit-tested, free, and open-source." sender:self.recipient.phoneNumber date:[NSDate date]],
                     [[JSQMessage alloc] initWithText:@"Oh, and there's sweet documentation." sender:self.sender date:[NSDate date]],
                     [[JSQMessage alloc] initWithText:@"Welcome to JSQMessages: A messaging UI framework for iOS." sender:self.sender date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"It is simple, elegant, and easy to use. There are super sweet default settings, but you can customize like crazy." sender:self.recipient.phoneNumber date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"It even has data detectors. You can call me tonight. My cell number is 123-456-7890. My website is www.hexedbits.com." sender:self.sender date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"JSQMessagesViewController is nearly an exact replica of the iOS Messages App. And perhaps, better." sender:self.recipient.phoneNumber date:[NSDate date]],
                     [[JSQMessage alloc] initWithText:@"It is unit-tested, free, and open-source." sender:self.recipient.phoneNumber date:[NSDate date]],
                     [[JSQMessage alloc] initWithText:@"Oh, and there's sweet documentation." sender:self.sender date:[NSDate date]],
                     [[JSQMessage alloc] initWithText:@"Welcome to JSQMessages: A messaging UI framework for iOS." sender:self.sender date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"It is simple, elegant, and easy to use. There are super sweet default settings, but you can customize like crazy." sender:self.recipient.phoneNumber date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"It even has data detectors. You can call me tonight. My cell number is 123-456-7890. My website is www.hexedbits.com." sender:self.sender date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"JSQMessagesViewController is nearly an exact replica of the iOS Messages App. And perhaps, better." sender:self.recipient.phoneNumber date:[NSDate date]],
                     [[JSQMessage alloc] initWithText:@"It is unit-tested, free, and open-source." sender:self.recipient.phoneNumber date:[NSDate date]],
                     [[JSQMessage alloc] initWithText:@"Oh, and there's sweet documentation." sender:self.sender date:[NSDate date]],
                     nil];
    
    [self.collectionView reloadData];
    [self scrollToBottomAnimated:YES];
}

#pragma mark - JSQMessagesViewController method overrides

- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                    sender:(NSString *)sender
                      date:(NSDate *)date
{
    /**
     *  Sending a message. Your implementation of this method should do *at least* the following:
     *
     *  1. Play sound (optional)
     *  2. Add new id<JSQMessageData> object to your data source
     *  3. Call `finishSendingMessage`
     */
    [JSQSystemSoundPlayer jsq_playMessageSentSound];
    
    JSQMessage *message = [[JSQMessage alloc] initWithText:text sender:sender date:date];
    [self.messages addObject:message];
    
    [self finishSendingMessage];
}

- (void)didPressAccessoryButton:(UIButton *)sender
{
    NSLog(@"Camera pressed!");

    self.showTypingIndicator = !self.showTypingIndicator;
    
    JSQMessage *copyMessage = [[self.messages lastObject] copy];
    
    if (!copyMessage) {
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSMutableArray *copyAvatars = [[self.avatars allKeys] mutableCopy];
        [copyAvatars removeObject:self.sender];
        copyMessage.sender = [copyAvatars objectAtIndex:arc4random_uniform((int)[copyAvatars count])];
        
        /**
         *  This you should do upon receiving a message:
         *
         *  1. Play sound (optional)
         *  2. Add new id<JSQMessageData> object to your data source
         *  3. Call `finishReceivingMessage`
         */
        [JSQSystemSoundPlayer jsq_playMessageReceivedSound];
        [self.messages addObject:copyMessage];
        [self finishReceivingMessage];
    });
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
    
    if ([message.sender isEqualToString:self.sender]) {
        return [[UIImageView alloc] initWithImage:self.outgoingBubbleImageView.image
                                 highlightedImage:self.outgoingBubbleImageView.highlightedImage];
    }
    
    return [[UIImageView alloc] initWithImage:self.incomingBubbleImageView.image
                             highlightedImage:self.incomingBubbleImageView.highlightedImage];
}

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Return `nil` here if you do not want avatars.
     *  If you do return `nil`, be sure to do the following in `viewDidLoad`:
     *
     *  self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero;
     *  self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
     *
     *  It is possible to have only outgoing avatars or only incoming avatars, too.
     */
    
    /**
     *  Reuse created avatar images, but create new imageView to add to each cell
     *  Otherwise, each cell would be referencing the same imageView and avatars would disappear from cells
     *
     *  Note: these images will be sized according to these values:
     *
     *  self.collectionView.collectionViewLayout.incomingAvatarViewSize
     *  self.collectionView.collectionViewLayout.outgoingAvatarViewSize
     *
     *  Override the defaults in `viewDidLoad`
     */
    JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
    
    UIImage *avatarImage = [self.avatars objectForKey:message.sender];
    return [[UIImageView alloc] initWithImage:avatarImage];
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
//    if ([message.sender isEqualToString:self.sender]) {
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
    
    JSQMessage *msg = [self.messages objectAtIndex:indexPath.item];
    
    if ([msg.sender isEqualToString:self.sender]) {
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
    if ([[currentMessage sender] isEqualToString:self.sender]) {
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
                          sender:self.user.name
                            date:[NSDate date]];
    }
}

@end
