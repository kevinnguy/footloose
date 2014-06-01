//
//  FLContactInfoExperienceView.m
//  Footloose
//
//  Created by kevin on 5/27/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import "FLContactInfoExperienceView.h"

@implementation FLContactInfoExperienceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        FLContactInfoExperienceView *view = [[NSBundle mainBundle] loadNibNamed:@"FLContactInfoExperienceView"
                                                     owner:self
                                                   options:nil].firstObject;
        
        for (UILabel *label in view.headerLabelArray) {
            label.textColor = [UIColor footloosePrimaryColor];
        }
        
        view.jobTitleLabel1.textColor = [UIColor footloosePrimaryColor];
        view.jobTitleLabel2.textColor = [UIColor footloosePrimaryColor];
        view.jobTitleLabel3.textColor = [UIColor footloosePrimaryColor];
        
        view.locationLabel1.textColor = [UIColor footlooseLightPrimaryColor];
        view.locationLabel2.textColor = [UIColor footlooseLightPrimaryColor];
        view.locationLabel3.textColor = [UIColor footlooseLightPrimaryColor];
//
//        view.durationLabel1.textColor = [UIColor footlooseLightPrimaryColor];
//        view.durationLabel2.textColor = [UIColor footlooseLightPrimaryColor];
//        view.durationLabel3.textColor = [UIColor footlooseLightPrimaryColor];
        
        [self addSubview:view];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
