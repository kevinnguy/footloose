//
//  FLContactViewController.h
//  Footloose
//
//  Created by kevin on 5/31/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLRoundImageView.h"
#import "FLUser.h"

@protocol FLContactViewDelegate <NSObject>

- (void)didSelectUser:(FLUser *)user;

@end

@interface FLContactViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *topSegmentedControl;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet FLRoundImageView *userProfileView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;

@property (nonatomic, assign) id<FLContactViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *contactArray;

@end
