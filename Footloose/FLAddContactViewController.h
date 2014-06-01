//
//  FLAddContactViewController.h
//  Footloose
//
//  Created by kevin on 5/18/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLNumberButton.h"

@protocol FLAddContactDelegate <NSObject>

- (void)didConnectWithPhoneNumber:(NSString *)phoneNumber;

@end

@interface FLAddContactViewController : UIViewController

@property (nonatomic, assign) id<FLAddContactDelegate> delegate;

@property (weak, nonatomic) IBOutlet FLNumberButton *numberButton1;
@property (weak, nonatomic) IBOutlet FLNumberButton *numberButton2;
@property (weak, nonatomic) IBOutlet FLNumberButton *numberButton3;
@property (weak, nonatomic) IBOutlet FLNumberButton *numberButton4;
@property (weak, nonatomic) IBOutlet FLNumberButton *numberButton5;
@property (weak, nonatomic) IBOutlet FLNumberButton *numberButton6;
@property (weak, nonatomic) IBOutlet FLNumberButton *numberButton7;
@property (weak, nonatomic) IBOutlet FLNumberButton *numberButton8;
@property (weak, nonatomic) IBOutlet FLNumberButton *numberButton9;
@property (weak, nonatomic) IBOutlet FLNumberButton *numberButton0;
@property (weak, nonatomic) IBOutlet FLNumberButton *deleteNumberButton;
@property (weak, nonatomic) IBOutlet UIButton *addContactButton;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;


@end
