//
//  FLContactInfoCardScrollView.m
//  Footloose
//
//  Created by kevin on 5/29/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import "FLContactInfoCardScrollView.h"

@implementation FLContactInfoCardScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *view = [[NSBundle mainBundle] loadNibNamed:@"FLContactInfoCardScrollView"
                                      owner:self
                                    options:nil].firstObject;
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
