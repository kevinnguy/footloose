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
        self.contentSize = CGSizeMake(CGRectGetWidth(frame), CGRectGetHeight(frame) * 3);
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor clearColor];
        
        self.cardScrollView = [[FLContactInfoCardScrollView alloc] initWithFrame:CGRectMake(0,
                                                                                            0,
                                                                                            CGRectGetWidth(frame),
                                                                                            460)];
        self.profileView = [[FLContactInfoProfileView alloc] initWithFrame:CGRectMake(0,
                                                                                      0,
                                                                                      CGRectGetWidth(self.cardScrollView.frame),
                                                                                      CGRectGetHeight(self.cardScrollView.frame))];
        
        self.experienceView = [[FLContactInfoExperienceView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.cardScrollView.frame),
                                                                                            0,
                                                                                            CGRectGetWidth(self.cardScrollView.frame),
                                                                                            CGRectGetHeight(self.cardScrollView.frame))];
        
        
        int yOffset = (CGRectGetHeight(frame) - CGRectGetHeight(self.cardScrollView.frame) - 20) / 2;
        CGRect cardFrame = self.cardScrollView.frame;
        cardFrame.origin.y = CGRectGetHeight(self.bounds) + yOffset + 20;
        self.cardScrollView.frame = cardFrame;
        self.cardScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.cardScrollView.frame) * 2, CGRectGetHeight(self.cardScrollView.frame));
        self.cardScrollView.pagingEnabled = YES;
        self.cardScrollView.showsHorizontalScrollIndicator = NO;
        self.cardScrollView.showsVerticalScrollIndicator = NO;
        self.cardScrollView.layer.cornerRadius = 4;
        
        [self.cardScrollView addSubview:self.profileView];
        [self.cardScrollView addSubview:self.experienceView];
        [self addSubview:self.cardScrollView];
    }
    
    return self;
}



@end
