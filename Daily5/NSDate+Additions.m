//
//  NSDate+Additions.m
//  Daily5
//
//  Created by Mohammad Azam on 10/12/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import "NSDate+Additions.h"

@implementation NSDate (Additions)

-(NSString *) dateAsTaskDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    return [dateFormatter stringFromDate:self];
}

@end
