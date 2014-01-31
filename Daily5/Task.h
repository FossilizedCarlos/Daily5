//
//  Task.h
//  Daily5
//
//  Created by Mohammad Azam on 10/1/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject
{
    
}

@property (nonatomic,assign) int taskId;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,copy) NSString *taskDate;
@property (nonatomic,assign) BOOL isCompleted;
@property (nonatomic,assign) int taskIndex;

@end
