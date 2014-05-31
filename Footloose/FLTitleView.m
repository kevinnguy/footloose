//
//  FLTitleView.m
//  Footloose
//
//  Created by kevin on 5/31/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import "FLTitleView.h"

@implementation FLTitleView

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame title:nil profileImage:nil target:nil selector:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                 profileImage:(UIImage *)profileImage
                       target:(id)target
                     selector:(SEL)action
{
    self = [super initWithFrame:frame];
    if (self) {
        int widthAndHeight = 34;
        int padding = 8;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        CGRect titleFrame = [title boundingRectWithSize:_titleLabel.frame.size
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName : _titleLabel.font}
                                                context:nil];
        _titleLabel.frame = CGRectMake(widthAndHeight + padding, 0, CGRectGetWidth(titleFrame), widthAndHeight);
        _titleLabel.text = title;
        _titleLabel.textColor = [UIColor footloosePrimaryColor];
        
        _profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, widthAndHeight, widthAndHeight)];
        _profileImageView.image = profileImage;
        _profileImageView.layer.cornerRadius = CGRectGetWidth(_profileImageView.frame) / 2;
        _profileImageView.layer.borderColor = [UIColor footloosePrimaryColor].CGColor;
        _profileImageView.layer.borderWidth = 1;
        _profileImageView.layer.masksToBounds = YES;
        
        CGRect mainFrame = CGRectMake(0,
                                      0,
                                      widthAndHeight + padding + CGRectGetWidth(_titleLabel.frame),
                                      widthAndHeight);
        
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleButton.frame = mainFrame;
        [_titleButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
        self.frame = mainFrame;
        [self addSubview:_profileImageView];
        [self addSubview:_titleLabel];
        [self addSubview:_titleButton];
    }
    
    return self;
}

@end
