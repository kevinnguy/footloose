//
//  FLContactInfoProfileView.m
//  Footloose
//
//  Created by kevin on 5/27/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import "FLContactInfoProfileView.h"

@implementation FLContactInfoProfileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        FLContactInfoProfileView *view = [[NSBundle mainBundle] loadNibNamed:@"FLContactInfoProfileView"
                                                     owner:self
                                                   options:nil].firstObject;
        
        view.profileImageView.layer.cornerRadius = CGRectGetWidth(view.profileImageView.frame) / 2;
        view.profileImageView.layer.masksToBounds = YES;
        
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
