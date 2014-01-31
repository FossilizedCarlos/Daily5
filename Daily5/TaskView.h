//
//  TaskView.h
//  Daily5
//
//  Created by Mohammad Azam on 10/1/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "BarrierView.h"
#import "CircleView.h"
#import "TaskService.h"
#import "NSString+Additions.h"

@interface TaskView : UIView<UIGestureRecognizerDelegate,UITextViewDelegate>
{
    UIDynamicAnimator *_animator;
    UIGravityBehavior *_gravity;
    UICollisionBehavior *_collision;
    NSMutableArray *_barrierViews;
    NSMutableArray *_circleViews;
    
    int index;
    int currentTaskIndex;
    Task *_currentTask;
    BOOL editing;
    
    TaskService *_taskService;
    NSDate *_newDate;
    
    int horizontalSpace;
}

@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) Task *task;
@property (nonatomic,strong) NSMutableArray *tasks;

-(void) performTaskAddedAnimation;

-(void) setup;

@end
