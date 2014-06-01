//
//  FLContactViewController.m
//  Footloose
//
//  Created by kevin on 5/31/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import "FLContactViewController.h"

#import "FLContactTableViewCell.h"

@interface FLContactViewController () <UITableViewDataSource, UITableViewDelegate>

@end

static NSString * const kJSQDemoAvatarNameCook = @"Tim Cook";
static NSString * const kJSQDemoAvatarNameJobs = @"Steve Jobs";
static NSString * const kJSQDemoAvatarNameWoz = @"Steve Wozniak";

static NSString * const kCellIdentifier = @"FLContactTableViewCellIdentifier";

#define RECENT_SEGMENT 0
#define ALL_SEGMENT 1

@implementation FLContactViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.contactArray = [NSMutableArray new];
        
        FLUser *cook = [[FLUser alloc] initWithName:kJSQDemoAvatarNameCook
                                        phoneNumber:@"4152345678"
                                       profileImage:[UIImage imageNamed:@"demo_avatar_cook"]];
        
        FLUser *jobs = [[FLUser alloc] initWithName:kJSQDemoAvatarNameJobs
                                        phoneNumber:@"5102345678"
                                       profileImage:[UIImage imageNamed:@"demo_avatar_jobs"]];
        
        FLUser *woz = [[FLUser alloc] initWithName:kJSQDemoAvatarNameWoz
                                       phoneNumber:@"3102343456"
                                      profileImage:[UIImage imageNamed:@"demo_avatar_woz"]];
        
        [self.contactArray addObject:cook];
        [self.contactArray addObject:jobs];
        [self.contactArray addObject:woz];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FLContactTableViewCell" bundle:nil]
         forCellReuseIdentifier:kCellIdentifier];
    FLContactTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    self.tableView.rowHeight = CGRectGetHeight(cell.frame);
    
    self.topSegmentedControl.tintColor = [UIColor footlooseLightPrimaryColor];
    
    self.userNameLabel.text = @"Kevin Nguy";
    self.userProfileView.image = [UIImage imageNamed:@"kevin"];
    
    self.topView.backgroundColor = [UIColor defaultNavigationBarColor];
    self.bottomView.backgroundColor = [UIColor defaultNavigationBarColor];
    
    self.settingsButton.tintColor = [UIColor footloosePrimaryColor];
}

- (IBAction)topSegmentedControlPressed:(UISegmentedControl *)control
{
    if (control.selectedSegmentIndex == RECENT_SEGMENT) {
        
    }
    else if (control.selectedSegmentIndex == ALL_SEGMENT) {
        
    }
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contactArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLContactTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    FLUser *user = self.contactArray[indexPath.row];
    
    cell.contactTextLabel.text = user.name;
    cell.contactImageView.image = user.profileImage;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLUser *user = self.contactArray[indexPath.row];
    [self.delegate didSelectUser:user];
}



@end
