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
        

        [self addSubview:view];
    }
    return self;
}



@end
