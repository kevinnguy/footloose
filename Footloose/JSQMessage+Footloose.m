//
//  JSQMessage+Footloose.m
//  Footloose
//
//  Created by kevin on 5/26/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import "JSQMessage+Footloose.h"

@implementation JSQMessage (Footloose)
- (NSDictionary *)JSONFormatWithDateFormatter:(NSDateFormatter *)dateFormatter
{
    return @{
             @"sender" : self.sender,
             @"text" : self.text,
             @"timestamp" : [dateFormatter stringFromDate:self.date]
             };
}
@end
