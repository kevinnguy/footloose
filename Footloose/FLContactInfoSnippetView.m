//
//  FLContactInfoSnippetView.m
//  Footloose
//
//  Created by kevin on 6/1/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import "FLContactInfoSnippetView.h"

@implementation FLContactInfoSnippetView

//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        [self setupView];
//    }
//    return self;
//}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    FLContactInfoSnippetView *view = [[NSBundle mainBundle] loadNibNamed:@"FLContactInfoSnippetView"
                                                                   owner:self
                                                                 options:nil].firstObject;
    
    [self addSubview:view];
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
