//
//  FLContactInfoScrollView.h
//  Footloose
//
//  Created by kevin on 5/27/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLContactInfoProfileView.h"
#import "FLContactInfoExperienceView.h"

@interface FLContactInfoScrollView : UIScrollView

@property (nonatomic, strong) FLContactInfoProfileView *profileView;
@property (nonatomic, strong) FLContactInfoExperienceView *experienceView;

@property (nonatomic, strong) UIPageControl *pageControl;
@end
