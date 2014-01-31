//
//  TasksViewController.h
//  Daily5
//
//  Created by Mohammad Azam on 10/2/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskView.h"
#import "Task.h"
#import "TaskHelper.h"

@interface TasksViewController : UIViewController
{
    NSMutableArray *_taskViews;
    TaskService *_taskService;
}

-(void) performRefreshForCurrentDay:(void (^)(UIBackgroundFetchResult))completionHandler;

@end
