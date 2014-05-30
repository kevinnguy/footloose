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
        self.cardScrollView = [[NSBundle mainBundle] loadNibNamed:@"FLContactInfoCardScrollView"
                                                            owner:self
                                                          options:nil].firstObject;
        
        self.profileView = [[NSBundle mainBundle] loadNibNamed:@"FLContactInfoProfileView"
                                                         owner:self
                                                       options:nil].firstObject;
        
        self.experienceView = [[NSBundle mainBundle] loadNibNamed:@"FLContactInfoExperienceView"
                                                            owner:self
                                                          options:nil].firstObject;
        
        int yOffset = (CGRectGetHeight(self.bounds) - CGRectGetHeight(self.cardScrollView.bounds) - 20) / 2;
        CGRect cardFrame = self.cardScrollView.frame;
        cardFrame.origin.y = CGRectGetHeight(self.bounds) + yOffset + 20;
        self.cardScrollView.frame = cardFrame;
        
        self.profileView.frame = CGRectMake(0, 0, CGRectGetWidth(self.profileView.frame), CGRectGetHeight(self.profileView.frame));
        
        CGRect experienceViewFrame = self.bounds;
        experienceViewFrame.origin = CGPointMake(CGRectGetWidth(frame), 0);
        self.experienceView.frame = experienceViewFrame;
        
        self.cardScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.cardScrollView.frame) * 2, CGRectGetHeight(self.cardScrollView.frame));
        [self.cardScrollView addSubview:self.profileView];
        [self.cardScrollView addSubview:self.experienceView];
        self.cardScrollView.pagingEnabled = YES;
        self.cardScrollView.showsHorizontalScrollIndicator = NO;
        self.cardScrollView.showsVerticalScrollIndicator = NO;
        
        self.contentSize = CGSizeMake(CGRectGetWidth(frame), CGRectGetHeight(frame) * 3);
        [self addSubview:self.cardScrollView];
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}



@end
