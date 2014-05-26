//
//  FLContactTableViewController.m
//  Footloose
//
//  Created by kevin on 5/17/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import "FLContactTableViewController.h"

#import "FLContactTableViewCell.h"

@interface FLContactTableViewController ()
@end

static NSString * const kJSQDemoAvatarNameCook = @"Tim Cook";
static NSString * const kJSQDemoAvatarNameJobs = @"Steve Jobs";
static NSString * const kJSQDemoAvatarNameWoz = @"Steve Wozniak";

static NSString * const kCellIdentifier = @"FLContactTableViewCellIdentifier";


@implementation FLContactTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FLContactTableViewCell" bundle:nil]
         forCellReuseIdentifier:kCellIdentifier];
    FLContactTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    self.tableView.rowHeight = CGRectGetHeight(cell.frame);
    
    self.tableView.sectionHeaderHeight = 20.0f;
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contactArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.contentView.backgroundColor = self.tableView.backgroundColor;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @" ";
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
