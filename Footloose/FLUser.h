//
//  FLUser.h
//  Footloose
//
//  Created by kevin on 5/26/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLUser : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) UIImage *profileImage;

- (id)initWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber profileImage:(UIImage *)profileImage;
@end
