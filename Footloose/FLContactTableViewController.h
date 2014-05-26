//
//  FLContactTableViewController.h
//  Footloose
//
//  Created by kevin on 5/17/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLUser.h"

@protocol FLContactTableViewDelegate <NSObject>

- (void)didSelectUser:(FLUser *)user;

@end

@interface FLContactTableViewController : UITableViewController
@property (nonatomic, assign) id<FLContactTableViewDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *contactArray;

@end
