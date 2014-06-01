//
//  FLTitleView.h
//  Footloose
//
//  Created by kevin on 5/31/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLRoundImageView.h"

@interface FLTitleView : UIView
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) FLRoundImageView *profileImageView;
@property (nonatomic, strong) UIButton *titleButton;

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                 profileImage:(UIImage *)profileImage
                       target:(id)target
                     selector:(SEL)action;
@end
