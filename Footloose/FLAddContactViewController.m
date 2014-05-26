//
//  FLAddContactViewController.m
//  Footloose
//
//  Created by kevin on 5/18/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import "FLAddContactViewController.h"

#import <SlideNavigationController.h>

@interface FLAddContactViewController ()

@end

@implementation FLAddContactViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupNumberButtons];
    
    self.addContactButton.layer.borderColor = self.addContactButton.tintColor.CGColor;
    self.addContactButton.layer.borderWidth = 2;
    self.addContactButton.layer.cornerRadius = CGRectGetHeight(self.addContactButton.frame) / 2;
    self.addContactButton.titleLabel.font = [UIFont systemFontOfSize:22.0f];
    
    self.phoneNumberTextField.font = [UIFont systemFontOfSize:28.0f];
}

- (void)setupNumberButtons
{
    self.numberButton0.layer.borderColor = self.numberButton0.tintColor.CGColor;
    self.numberButton0.layer.borderWidth = 2;
    self.numberButton0.layer.cornerRadius = CGRectGetWidth(self.numberButton0.frame) / 2;
    self.numberButton0.titleLabel.font = [UIFont systemFontOfSize:28.0f];

    self.numberButton1.layer.borderColor = self.numberButton1.tintColor.CGColor;
    self.numberButton1.layer.borderWidth = 2;
    self.numberButton1.layer.cornerRadius = CGRectGetWidth(self.numberButton1.frame) / 2;
    self.numberButton1.titleLabel.font = [UIFont systemFontOfSize:28.0f];

    self.numberButton2.layer.borderColor = self.numberButton2.tintColor.CGColor;
    self.numberButton2.layer.borderWidth = 2;
    self.numberButton2.layer.cornerRadius = CGRectGetWidth(self.numberButton2.frame) / 2;
    self.numberButton2.titleLabel.font = [UIFont systemFontOfSize:28.0f];

    self.numberButton3.layer.borderColor = self.numberButton3.tintColor.CGColor;
    self.numberButton3.layer.borderWidth = 2;
    self.numberButton3.layer.cornerRadius = CGRectGetWidth(self.numberButton3.frame) / 2;
    self.numberButton3.titleLabel.font = [UIFont systemFontOfSize:28.0f];

    self.numberButton4.layer.borderColor = self.numberButton4.tintColor.CGColor;
    self.numberButton4.layer.borderWidth = 2;
    self.numberButton4.layer.cornerRadius = CGRectGetWidth(self.numberButton4.frame) / 2;
    self.numberButton4.titleLabel.font = [UIFont systemFontOfSize:28.0f];

    self.numberButton5.layer.borderColor = self.numberButton5.tintColor.CGColor;
    self.numberButton5.layer.borderWidth = 2;
    self.numberButton5.layer.cornerRadius = CGRectGetWidth(self.numberButton5.frame) / 2;
    self.numberButton5.titleLabel.font = [UIFont systemFontOfSize:28.0f];

    self.numberButton6.layer.borderColor = self.numberButton6.tintColor.CGColor;
    self.numberButton6.layer.borderWidth = 2;
    self.numberButton6.layer.cornerRadius = CGRectGetWidth(self.numberButton6.frame) / 2;
    self.numberButton6.titleLabel.font = [UIFont systemFontOfSize:28.0f];

    self.numberButton7.layer.borderColor = self.numberButton7.tintColor.CGColor;
    self.numberButton7.layer.borderWidth = 2;
    self.numberButton7.layer.cornerRadius = CGRectGetWidth(self.numberButton7.frame) / 2;
    self.numberButton7.titleLabel.font = [UIFont systemFontOfSize:28.0f];

    self.numberButton8.layer.borderColor = self.numberButton8.tintColor.CGColor;
    self.numberButton8.layer.borderWidth = 2;
    self.numberButton8.layer.cornerRadius = CGRectGetWidth(self.numberButton8.frame) / 2;
    self.numberButton8.titleLabel.font = [UIFont systemFontOfSize:28.0f];

    self.numberButton9.layer.borderColor = self.numberButton9.tintColor.CGColor;
    self.numberButton9.layer.borderWidth = 2;
    self.numberButton9.layer.cornerRadius = CGRectGetWidth(self.numberButton9.frame) / 2;
    self.numberButton9.titleLabel.font = [UIFont systemFontOfSize:28.0f];
}

- (IBAction)numberButton1Pressed:(id)sender {
    self.phoneNumberTextField.text = [self.phoneNumberTextField.text stringByAppendingString:@"1"];
}

- (IBAction)numberButton2Pressed:(id)sender {
    self.phoneNumberTextField.text = [self.phoneNumberTextField.text stringByAppendingString:@"2"];
}

- (IBAction)numberButton3Pressed:(id)sender {
    self.phoneNumberTextField.text = [self.phoneNumberTextField.text stringByAppendingString:@"3"];
}

- (IBAction)numberButton4Pressed:(id)sender {
    self.phoneNumberTextField.text = [self.phoneNumberTextField.text stringByAppendingString:@"4"];
}

- (IBAction)numberButton5Pressed:(id)sender {
    self.phoneNumberTextField.text = [self.phoneNumberTextField.text stringByAppendingString:@"5"];
}

- (IBAction)numberButton6Pressed:(id)sender {
    self.phoneNumberTextField.text = [self.phoneNumberTextField.text stringByAppendingString:@"6"];
}

- (IBAction)numberButton7Pressed:(id)sender {
    self.phoneNumberTextField.text = [self.phoneNumberTextField.text stringByAppendingString:@"7"];
}

- (IBAction)numberButton8Pressed:(id)sender {
    self.phoneNumberTextField.text = [self.phoneNumberTextField.text stringByAppendingString:@"8"];
}

- (IBAction)numberButton9Pressed:(id)sender {
    self.phoneNumberTextField.text = [self.phoneNumberTextField.text stringByAppendingString:@"9"];
}

- (IBAction)numberButton0Pressed:(id)sender {
    self.phoneNumberTextField.text = [self.phoneNumberTextField.text stringByAppendingString:@"0"];
}

- (IBAction)deleteButtonPressed:(id)sender {
    self.phoneNumberTextField.text = [self.phoneNumberTextField.text substringToIndex:self.phoneNumberTextField.text.length - 1];
}

- (IBAction)addContactButtonPressed:(id)sender {
    // Do something and then dismiss side menu
    self.phoneNumberTextField.text = nil;
    [[SlideNavigationController sharedInstance] closeMenuWithCompletion:nil];

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Add name to this contact?" message:nil delegate:nil cancelButtonTitle:@"No" otherButtonTitles:@"Okay", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;

    UITextField *textField = [alertView textFieldAtIndex:0];
    textField.placeholder = @"John Doe";
    textField.keyboardType = UIKeyboardTypeAlphabet;
    textField.autocapitalizationType = UITextAutocapitalizationTypeWords;

    [alertView show];
}












@end
