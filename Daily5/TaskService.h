//
//  TaskService.h
//  Daily5
//
//  Created by Mohammad Azam on 10/4/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"
#import "FMDatabase.h"
#import "NSDate+Additions.h"
#import "NSString+Additions.h"
#import "AppHelper.h"

@interface TaskService : NSObject
{
    FMDatabase *_db; 
}

-(BOOL) save:(Task *) task;
-(NSMutableArray *) getByTaskDate:(NSString *) taskDate;

-(void) updateBadgeNumber;

@end
