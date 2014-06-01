//
//  FLAddContactViewController.m
//  Footloose
//
//  Created by kevin on 5/18/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import "FLAddContactViewController.h"

#import <SlideNavigationController.h>

@interface FLAddContactViewController () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) UILongPressGestureRecognizer *deleteNumberLongPressGesture;
@property (nonatomic, strong) NSTimer *deleteNumberTimer;
@end

@implementation FLAddContactViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.phoneNumber = @"";

    self.addContactButton.tintColor = [UIColor footloosePrimaryColor];
    self.addContactButton.layer.borderColor = [UIColor footlooseLightPrimaryColor].CGColor;
    self.addContactButton.layer.borderWidth = 1;
    self.addContactButton.layer.cornerRadius = CGRectGetHeight(self.addContactButton.frame) / 2;

    self.deleteNumberLongPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(holdDeleteNumberButton:)];
    self.deleteNumberLongPressGesture.minimumPressDuration = 0.3f;
    self.deleteNumberLongPressGesture.cancelsTouchesInView = NO;
    self.deleteNumberLongPressGesture.delegate = self;
    [self.deleteNumberButton addGestureRecognizer:self.deleteNumberLongPressGesture];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}

- (void)holdDeleteNumberButton:(UIGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        if (self.deleteNumberTimer) {
            [self.deleteNumberTimer invalidate];
            self.deleteNumberTimer = nil;
        }

        self.deleteNumberTimer = [NSTimer scheduledTimerWithTimeInterval:0.3f target:self selector:@selector(deleteButtonPressed:) userInfo:nil repeats:YES];
    }

    if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        [self.deleteNumberTimer invalidate];
        self.deleteNumberTimer = nil;
    }
}

- (IBAction)numberButton1Pressed:(id)sender {
    self.phoneNumber = [self.phoneNumber stringByAppendingString:@"1"];
    [self formatPhoneNumberTextField];
}

- (IBAction)numberButton2Pressed:(id)sender {
    self.phoneNumber = [self.phoneNumber stringByAppendingString:@"2"];
    [self formatPhoneNumberTextField];
}

- (IBAction)numberButton3Pressed:(id)sender {
    self.phoneNumber = [self.phoneNumber stringByAppendingString:@"3"];
    [self formatPhoneNumberTextField];
}

- (IBAction)numberButton4Pressed:(id)sender {
    self.phoneNumber = [self.phoneNumber stringByAppendingString:@"4"];
    [self formatPhoneNumberTextField];
}

- (IBAction)numberButton5Pressed:(id)sender {
    self.phoneNumber = [self.phoneNumber stringByAppendingString:@"5"];
    [self formatPhoneNumberTextField];
}

- (IBAction)numberButton6Pressed:(id)sender {
    self.phoneNumber = [self.phoneNumber stringByAppendingString:@"6"];
    [self formatPhoneNumberTextField];
}

- (IBAction)numberButton7Pressed:(id)sender {
    self.phoneNumber = [self.phoneNumber stringByAppendingString:@"7"];
    [self formatPhoneNumberTextField];
}

- (IBAction)numberButton8Pressed:(id)sender {
    self.phoneNumber = [self.phoneNumber stringByAppendingString:@"8"];
    [self formatPhoneNumberTextField];
}

- (IBAction)numberButton9Pressed:(id)sender {
    self.phoneNumber = [self.phoneNumber stringByAppendingString:@"9"];
    [self formatPhoneNumberTextField];
}

- (IBAction)numberButton0Pressed:(id)sender {
    self.phoneNumber = [self.phoneNumber stringByAppendingString:@"0"];
    [self formatPhoneNumberTextField];
}

- (IBAction)deleteButtonPressed:(id)sender {
    int length = self.phoneNumber.length;

    if (length == 0) {
        return;
    }

    // If first number is 1
    if ([[self.phoneNumber substringToIndex:1] isEqualToString:@"1"]) {
        length--;

        if (self.phoneNumber.length == 1) {
            self.phoneNumberTextField.text = @"";
        }
        else if (self.phoneNumber.length == 2) {
            self.phoneNumberTextField.text = @"1";
        }
        else if (self.phoneNumber.length == 3) {
            self.phoneNumberTextField.text = [NSString stringWithFormat:@"1 (%@  )", [self.phoneNumber substringWithRange:NSMakeRange(1, 1)]];

        }
        else if (self.phoneNumber.length == 4) {
            self.phoneNumberTextField.text = [NSString stringWithFormat:@"1 (%@%@ )", [self.phoneNumber substringWithRange:NSMakeRange(1, 1)], [self.phoneNumber substringWithRange:NSMakeRange(2, 1)]];
        }
    }
    else {
        if (self.phoneNumber.length == 1) {
            self.phoneNumberTextField.text = @"";
        }
        else if (self.phoneNumber.length == 2) {
            self.phoneNumberTextField.text = [NSString stringWithFormat:@"(%@  )", [self.phoneNumber substringWithRange:NSMakeRange(0, 1)]];
        }
        else if (self.phoneNumber.length == 3) {
            self.phoneNumberTextField.text = [NSString stringWithFormat:@"(%@%@ )", [self.phoneNumber substringWithRange:NSMakeRange(0, 1)], [self.phoneNumber substringWithRange:NSMakeRange(1, 1)]];
        }
    }

    if (length == 4) {
        self.phoneNumberTextField.text = [self.phoneNumberTextField.text substringToIndex:self.phoneNumberTextField.text.length - 2];
    }
    else if (length == 5 || length == 6) {
        self.phoneNumberTextField.text = [self.phoneNumberTextField.text substringToIndex:self.phoneNumberTextField.text.length - 1];
    }
    else if (length == 7) {
        self.phoneNumberTextField.text = [self.phoneNumberTextField.text substringToIndex:self.phoneNumberTextField.text.length - 2];
    }
    else if (length > 7 && length < 11) {
        self.phoneNumberTextField.text = [self.phoneNumberTextField.text substringToIndex:self.phoneNumberTextField.text.length - 1];
    }

    self.phoneNumber = [self.phoneNumber substringToIndex:self.phoneNumber.length - 1];
}

- (IBAction)addContactButtonPressed:(id)sender {
    // Do something and then dismiss side menu

    if (self.phoneNumber.length < 10 || (self.phoneNumber.length > 1 && self.phoneNumber.length < 11 && [[self.phoneNumber substringToIndex:1] isEqualToString:@"1"])) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid Number" message:@"Please complete the phone number" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alertView show];
        return;
    }

    [[SlideNavigationController sharedInstance] closeMenuWithCompletion:nil];
    [self.delegate didConnectWithPhoneNumber:self.phoneNumber];

    self.phoneNumberTextField.text = @"";
    self.phoneNumber = @"";
}

- (void)formatPhoneNumberTextField
{
    int length = self.phoneNumber.length;

    // If first number is 1
    if ([[self.phoneNumber substringToIndex:1] isEqualToString:@"1"]) {
        length--;

        if (self.phoneNumber.length == 1) {
            self.phoneNumberTextField.text = @"1";
        }
        else if (self.phoneNumber.length == 2) {
            self.phoneNumberTextField.text = [NSString stringWithFormat:@"1 (%@  )", [self.phoneNumber substringWithRange:NSMakeRange(1, 1)]];
        }
        else if (self.phoneNumber.length == 3) {
            self.phoneNumberTextField.text = [NSString stringWithFormat:@"1 (%@%@ )", [self.phoneNumber substringWithRange:NSMakeRange(1, 1)], [self.phoneNumber substringWithRange:NSMakeRange(2, 1)]];
        }
        else if (self.phoneNumber.length == 4) {
            self.phoneNumberTextField.text = [NSString stringWithFormat:@"1 (%@%@%@)", [self.phoneNumber substringWithRange:NSMakeRange(1, 1)], [self.phoneNumber substringWithRange:NSMakeRange(2, 1)], [self.phoneNumber substringWithRange:NSMakeRange(3, 1)]];
        }
    }
    else {
        if (self.phoneNumber.length == 1) {
            self.phoneNumberTextField.text = [NSString stringWithFormat:@"(%@  )", [self.phoneNumber substringWithRange:NSMakeRange(0, 1)]];
        }
        else if (self.phoneNumber.length == 2) {
            self.phoneNumberTextField.text = [NSString stringWithFormat:@"(%@%@ )", [self.phoneNumber substringWithRange:NSMakeRange(0, 1)], [self.phoneNumber substringWithRange:NSMakeRange(1, 1)]];
        }
        else if (self.phoneNumber.length == 3) {
            self.phoneNumberTextField.text = [NSString stringWithFormat:@"(%@%@%@)", [self.phoneNumber substringWithRange:NSMakeRange(0, 1)], [self.phoneNumber substringWithRange:NSMakeRange(1, 1)], [self.phoneNumber substringWithRange:NSMakeRange(2, 1)]];
        }
    }

    if (length == 4) {
        self.phoneNumberTextField.text = [self.phoneNumberTextField.text stringByAppendingString:[NSString stringWithFormat:@" %@", [self.phoneNumber substringFromIndex:self.phoneNumber.length - 1]]];
    }
    else if (length == 5 || length == 6) {
        self.phoneNumberTextField.text = [self.phoneNumberTextField.text stringByAppendingString:[self.phoneNumber substringFromIndex:self.phoneNumber.length - 1]];
    }
    else if (length == 7) {
        self.phoneNumberTextField.text = [self.phoneNumberTextField.text stringByAppendingString:[NSString stringWithFormat:@"-%@", [self.phoneNumber substringFromIndex:self.phoneNumber.length - 1]]];
    }
    else if (length > 7 && length < 11) {
        self.phoneNumberTextField.text = [self.phoneNumberTextField.text stringByAppendingString:[self.phoneNumber substringFromIndex:self.phoneNumber.length - 1]];
    }
}










@end
