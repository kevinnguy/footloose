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
