//
//  FLContactInfoProfileView.h
//  Footloose
//
//  Created by kevin on 5/27/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLRoundImageView.h"
#import "FLRoundButton.h"

@interface FLContactInfoProfileView : UIView
@property (weak, nonatomic) IBOutlet FLRoundImageView *profileImageView;
@property (weak, nonatomic) IBOutlet FLRoundButton *phoneButton;
@property (weak, nonatomic) IBOutlet FLRoundButton *emailButton;

@end
