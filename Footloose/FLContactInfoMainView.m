//
//  FLContactInfoMainView.m
//  Footloose
//
//  Created by kevin on 5/29/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import "FLContactInfoMainView.h"

@implementation FLContactInfoMainView

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame delegate:nil];
}

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<UIScrollViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.blurView = [[FXBlurView alloc] initWithFrame:frame];
        self.blurView.dynamic = NO;
        self.blurView.blurRadius = 10;
        self.blurView.alpha = 0;
        self.blurView.tintColor = [UIColor clearColor];
        
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:frame];
        self.backgroundImageView.image = [UIImage imageNamed:@"purple"];
        self.backgroundImageView.alpha = 0;
        
        int x = 10;
        int width = CGRectGetWidth(frame) - x * 2;
        self.contactInfoScrollView = [[FLContactInfoScrollView alloc] initWithFrame:CGRectMake(x, 0, width, CGRectGetHeight(frame))];
        self.contactInfoScrollView.delegate = delegate;
        self.contactInfoScrollView.cardScrollView.delegate = delegate;
    }
    return self;
}

- (void)setHidden:(BOOL)hidden
{
    
    __weak typeof(self) weakSelf = self;

    if (hidden) {
        self.contactInfoScrollView.hidden = YES;
        [UIView animateWithDuration:0.2f animations:^{
            weakSelf.blurView.alpha = 0;
            weakSelf.backgroundImageView.alpha = 0;
            [[UIApplication sharedApplication] setStatusBarHidden:!hidden];
        } completion:^(BOOL finished) {
            [weakSelf.blurView removeFromSuperview];
            [weakSelf.backgroundImageView removeFromSuperview];
            [weakSelf.contactInfoScrollView removeFromSuperview];
            weakSelf.contactInfoScrollView.hidden = NO;
            
            [weakSelf.contactInfoScrollView scrollRectToVisible:CGRectMake(0,
                                                                           0,
                                                                           CGRectGetWidth(weakSelf.contactInfoScrollView.frame),
                                                                           CGRectGetHeight(weakSelf.contactInfoScrollView.frame))
                                                       animated:NO];
        }];
    }
    else {
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.blurView];
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.backgroundImageView];
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.contactInfoScrollView];
        
        [UIView animateWithDuration:0.3f animations:^{
            weakSelf.blurView.alpha = 1;
            weakSelf.backgroundImageView.alpha = .85f;
            [[UIApplication sharedApplication] setStatusBarHidden:!hidden];
        }];
        
        [UIView animateWithDuration:0.3f animations:nil completion:^(BOOL finished) {
            [weakSelf.contactInfoScrollView scrollRectToVisible:CGRectMake(0,
                                                                           CGRectGetHeight(weakSelf.contactInfoScrollView.frame),
                                                                           CGRectGetWidth(weakSelf.contactInfoScrollView.frame),
                                                                           CGRectGetHeight(weakSelf.contactInfoScrollView.frame))
                                                       animated:YES];
        }];
        

    }
}

@end
