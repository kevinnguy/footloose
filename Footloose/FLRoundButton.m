//
//  FLNumberButton.m
//  Footloose
//
//  Created by kevin on 5/31/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import "FLRoundButton.h"

@implementation FLRoundButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupButton];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupButton];
    }
    return self;
}

- (void)setupButton
{
    self.tintColor = [UIColor footloosePrimaryColor];
    self.layer.borderColor = [UIColor footlooseLightPrimaryColor].CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
}


@end
