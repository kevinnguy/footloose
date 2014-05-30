//
//  FLContactInfoScrollView.m
//  Footloose
//
//  Created by kevin on 5/27/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import "FLContactInfoScrollView.h"

@implementation FLContactInfoScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.profileView = [[NSBundle mainBundle] loadNibNamed:@"FLContactInfoProfileView"
                                                         owner:self
                                                       options:nil].firstObject;
        
        self.experienceView = [[NSBundle mainBundle] loadNibNamed:@"FLContactInfoExperienceView"
                                                            owner:self
                                                          options:nil].firstObject;
        
        CGRect experienceViewFrame = self.bounds;
        experienceViewFrame.origin = CGPointMake(CGRectGetWidth(frame), 0);
        self.experienceView.frame = experienceViewFrame;
        
        self.contentSize = CGSizeMake(CGRectGetWidth(frame) * 2, CGRectGetHeight(frame));
        [self addSubview:self.profileView];
        [self addSubview:self.experienceView];
        
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}



@end
