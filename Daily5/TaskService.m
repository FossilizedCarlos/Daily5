//
//  TaskService.m
//  Daily5
//
//  Created by Mohammad Azam on 10/4/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import "TaskService.h"

@implementation TaskService

-(id) init
{
    self = [super init];
    
    _db = [FMDatabase databaseWithPath:[AppHelper getDatabasePath]];
    _db.logsErrors = YES;
    
    return self;
}

-(NSMutableArray *) getEmptyTasks
{
    NSMutableArray *emptyTasks = [NSMutableArray array];
    
    for(int i = 1; i<= 5; i++)
    {
        Task *task = [[Task alloc] init];
        task.title = @"Add New Task";
        task.taskIndex = i-1;
        
        [emptyTasks addObject:task];
    }
    
    return emptyTasks;
}

-(Task *) createDummyTask
{
    Task *task = [[Task alloc] init];
    task.title = @"Add New Task";
    task.isCompleted = NO;
    
    return task;
}

-(NSMutableArray *) getByTaskDate:(NSString *)taskDate
{
    BOOL tasksAvailable = NO;
    
    NSMutableArray *tasks = [NSMutableArray array];
    
    [_db open];
    
    FMResultSet *result = [_db executeQueryWithFormat:@"select taskId,title,taskDate,taskIndex,isCompleted from tasks where taskDate = %@",taskDate,nil];

    while([result next])
    {
        tasksAvailable = YES;
        
        Task *task = [[Task alloc] init];
        task.taskId = [result intForColumn:@"taskId"];
        task.title = [result stringForColumn:@"title"];
        task.taskDate = [result stringForColumn:@"taskDate"];
        task.taskIndex = [result intForColumn:@"taskIndex"];
        task.isCompleted = [result intForColumn:@"isCompleted"] == 1 ? YES : NO;
        
        [tasks addObject:task];
    }
    
    // check if some dummy tasks needed to be inserted
    while([tasks count] < 5)
    {
        // add dummy tasks
        Task *dummyTask = [self createDummyTask];
        [tasks addObject:dummyTask];
    }
    
    [_db close];
    
    return tasks;
}

-(BOOL) update:(Task *) task
{
    BOOL success = NO;
    
    [_db open];
    
    success = [_db executeUpdate:@"update tasks set title = ?, taskDate = ?, taskIndex = ?, dateModified = current_timestamp, isCompleted = ? where taskId = ?",task.title,task.taskDate,[NSNumber numberWithInt:task.taskIndex],[NSNumber numberWithBool:task.isCompleted],[NSNumber numberWithInt:task.taskId]];
    
    [_db close];
    
    return success;
}

-(BOOL) deleteTask:(Task *) task
{
    BOOL success = NO;
    
    success = [_db executeUpdate:@"delete from tasks where taskId = ?",[NSNumber numberWithInt:task.taskId]];
    
    task.taskId = 0;
    
    return success;
}

-(BOOL) save:(Task *)task
{
    BOOL success = NO;
    
    // remove white space
    task.title = [task.title trim];
                  
    [_db open];
    
    if(task.taskId > 0)
    {
        
       if([task.title length] == 0)
       {
           // delete the task
          success = [self deleteTask:task];
       }
        else
        {
            // update the task
            success = [self update:task];
        }
    }
    
    if(!success)
    {
    // save new
    [_db executeUpdate:@"insert into tasks(title,taskDate,taskIndex) values(?,?,?)",task.title,task.taskDate,[NSNumber numberWithInt:task.taskIndex],nil];
    
    // assign the last inserted id to task id
    task.taskId = [_db lastInsertRowId];
    }
    
    [_db close];
    
    [self updateBadgeNumber];
    
    return success;
}

-(void) updateBadgeNumber
{
    NSDate *currentDate = [NSDate date];
    
    int numberOfIncompletedTasksForToday = [[[self getByTaskDate:[currentDate dateAsTaskDate]] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"taskId > 0 && isCompleted = 0"]] count];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:numberOfIncompletedTasksForToday];
}


@end
