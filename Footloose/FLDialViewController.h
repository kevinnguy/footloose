//
//  FLAddContactViewController.h
//  Footloose
//
//  Created by kevin on 5/18/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLRoundButton.h"

@protocol FLAddContactDelegate <NSObject>

- (void)didConnectWithPhoneNumber:(NSString *)phoneNumber;

@end

@interface FLDialViewController : UIViewController

@property (nonatomic, assign) id<FLAddContactDelegate> delegate;

@property (weak, nonatomic) IBOutlet FLRoundButton *numberButton1;
@property (weak, nonatomic) IBOutlet FLRoundButton *numberButton2;
@property (weak, nonatomic) IBOutlet FLRoundButton *numberButton3;
@property (weak, nonatomic) IBOutlet FLRoundButton *numberButton4;
@property (weak, nonatomic) IBOutlet FLRoundButton *numberButton5;
@property (weak, nonatomic) IBOutlet FLRoundButton *numberButton6;
@property (weak, nonatomic) IBOutlet FLRoundButton *numberButton7;
@property (weak, nonatomic) IBOutlet FLRoundButton *numberButton8;
@property (weak, nonatomic) IBOutlet FLRoundButton *numberButton9;
@property (weak, nonatomic) IBOutlet FLRoundButton *numberButton0;
@property (weak, nonatomic) IBOutlet FLRoundButton *deleteNumberButton;
@property (weak, nonatomic) IBOutlet UIButton *addContactButton;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;


@end
