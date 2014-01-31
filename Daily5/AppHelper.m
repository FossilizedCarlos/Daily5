//
//  AppHelper.m
//  Daily5
//
//  Created by Mohammad Azam on 10/4/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import "AppHelper.h"

@implementation AppHelper

+(NSString *) getDatabasePath
{
    NSString *databasePath = [(AppDelegate *)[[UIApplication sharedApplication] delegate] databasePath];
    return databasePath;
}


@end
