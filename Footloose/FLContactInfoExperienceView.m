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
        
        
        view.imageView1.layer.cornerRadius = CGRectGetWidth(view.imageView1.frame) / 2;
        view.imageView2.layer.cornerRadius = CGRectGetWidth(view.imageView2.frame) / 2;
        view.imageView3.layer.cornerRadius = CGRectGetWidth(view.imageView3.frame) / 2;
        view.imageView4.layer.cornerRadius = CGRectGetWidth(view.imageView4.frame) / 2;

        view.imageView1.layer.masksToBounds = YES;
        view.imageView2.layer.masksToBounds = YES;
        view.imageView3.layer.masksToBounds = YES;
        view.imageView4.layer.masksToBounds = YES;
        
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
