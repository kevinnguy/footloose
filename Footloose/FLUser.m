//
//  FLUser.m
//  Footloose
//
//  Created by kevin on 5/26/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import "FLUser.h"

@implementation FLUser

- (id)init
{
    return [self initWithName:nil phoneNumber:nil profileImage:nil];
}

- (id)initWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber profileImage:(UIImage *)profileImage
{
    if (self = [super init]) {
        self.name = name;
        self.phoneNumber = phoneNumber;
        self.profileImage = profileImage;
    }
    
    return self;
}

@end
