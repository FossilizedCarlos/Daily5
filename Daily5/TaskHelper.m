//
//  TaskHelper.m
//  Daily5
//
//  Created by Mohammad Azam on 10/8/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import "TaskHelper.h"

@implementation TaskHelper

+(NSString *) getTaskDateByDay:(int)day
{
    NSDate *currentDate = [[NSDate alloc] init];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = day;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:dayComponent toDate:currentDate options:0];

    return [dateFormatter stringFromDate:newDate];
}

@end
