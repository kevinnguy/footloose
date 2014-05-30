//
//  FLContactInfoMainView.h
//  Footloose
//
//  Created by kevin on 5/29/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLContactInfoScrollView.h"

#import <FXBlurView/FXBlurView.h>

@interface FLContactInfoMainView : UIView

@property (nonatomic, strong) FXBlurView *blurView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) FLContactInfoScrollView *contactInfoScrollView;


- (instancetype)initWithFrame:(CGRect)frame delegate:(id<UIScrollViewDelegate>)delegate;


@end
