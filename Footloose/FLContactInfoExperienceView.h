//
//  FLContactInfoExperienceView.h
//  Footloose
//
//  Created by kevin on 5/27/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLRoundImageView.h"
#import "FLContactInfoSnippetView.h"

@interface FLContactInfoExperienceView : UIView
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *headerLabelArray;

@property (weak, nonatomic) IBOutlet FLRoundImageView *imageView1;
@property (weak, nonatomic) IBOutlet FLRoundImageView *imageView2;
@property (weak, nonatomic) IBOutlet FLRoundImageView *imageView3;

@property (weak, nonatomic) IBOutlet UILabel *jobTitleLabel1;
@property (weak, nonatomic) IBOutlet UILabel *jobTitleLabel2;
@property (weak, nonatomic) IBOutlet UILabel *jobTitleLabel3;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel1;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel2;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel3;

@property (weak, nonatomic) IBOutlet UILabel *durationLabel1;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel2;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel3;

@end
