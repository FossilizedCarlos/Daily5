//
//  TaskView.m
//  Daily5
//
//  Created by Mohammad Azam on 10/1/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import "TaskView.h"

@implementation TaskView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(CircleView *) createCircleView
{
    CircleView *circleView = [[CircleView alloc] initWithFrame:CGRectMake(20 + 60 * index, self.bounds.size.height - 300, 44, 44)];
    
    circleView.userInteractionEnabled = YES;
    circleView.tag = index;
    circleView.alpha = 0.1;

    return circleView;
}


-(void) performTaskAddedAnimation
{
    Task *task = [self.tasks objectAtIndex:index];
    
    BarrierView *barrierView = [_barrierViews objectAtIndex:index];
    
    CircleView *circleView = [self createCircleView];
    circleView.task = task;
    
    __weak CircleView *circleViewSelf =  circleView;
    
    if(task.taskId > 0)
    {
        if(!task.isCompleted)
        {
            circleView.alpha = 1.0;
            [circleView markAsIncomplete];
        }
        else
        {
            circleView.alpha = 1.0;
            [circleView markAsComplete];
        }
    }
    
    // didSelectTaskForCompletionBlock
    circleView.didSelectTaskForCompletion = ^(int tag)
    {
        Task *task = [self.tasks objectAtIndex:tag];
        task.isCompleted = !task.isCompleted;
        
        if(task.isCompleted)
        {
            [circleViewSelf markAsComplete];
        }
        else
        {
            [circleViewSelf markAsIncomplete];
        }
            
        
        [_taskService save:task];
    };
    
    
    // didSelectBlock
    circleView.didSelectBlock = ^(int tag)
    {
        // set all barriers to alpha 0.0
        for(BarrierView *bv in _barrierViews)
        {
            bv.alpha = 0.0;
        }
        
        // highlight the barrier for the current selection
        
        BarrierView *barrier = [_barrierViews objectAtIndex:tag];
        [UIView animateWithDuration:0.25 animations:^{
            barrier.alpha = 1.0;
        }];

        
        Task *task = [self.tasks objectAtIndex:tag];
        self.textView.text = task.title;
        task.taskIndex = tag;
        
        if(![task.title isEqualToString:@"Add New Task"] && ![task.title isEqualToString:@""])
        {
             self.textView.alpha = 1.0;
            
            [UIView animateWithDuration:1.0 animations:^{
                     circleViewSelf.alpha = 1.0;
            }];
            
        }
        else
        {
            self.textView.alpha = 0.1;
        }
        
        _currentTask = task;
        
        if([task.title isEqualToString:@""])
        {
            self.textView.text = @"Add New Task";
            
            [UIView animateWithDuration:1.0 animations:^{
                circleViewSelf.alpha = 0.1;
            }];
        }
        
    };
    
    
    [self addSubview:circleView];
    
    [circleView enableDynamicsWithBarrier:barrierView];
    
    [_circleViews addObject:circleView];
    
}

-(void) createBarriers
{
    _barrierViews = [NSMutableArray array];
    
    int x = 39;
    
    for(int i = 1; i<=5; i++)
    {
        BarrierView *barrierView = [[BarrierView alloc] initWithFrame:CGRectMake(x, self.bounds.size.height - 40 , 22, 20)];
        barrierView.backgroundColor = [UIColor clearColor];
        barrierView.alpha = 0.0;
        
        x+= 60;
        
        [self addSubview:barrierView];
        
        [_barrierViews addObject:barrierView];
    }
    
   }

-(void) textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"Add New Task"])
    {
        textView.text = @"";
    }
    
    // change the alpha
    self.textView.alpha = 1.0;
}

-(void) updateTask
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];

    _currentTask.title = self.textView.text;
    _currentTask.taskDate = [dateFormatter stringFromDate:_newDate];
    
    CircleView *circleView = [_circleViews objectAtIndex:_currentTask.taskIndex];
    
    if([self.textView.text isEqualToString:@""])
    {
        [circleView markAsIncomplete];
    }
    
    
    [circleView bounce];
    
    // save task
    [_taskService save:_currentTask];
}

-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        if([self.textView.text trim].length == 0 && _currentTask.taskId == 0)
        {
            [textView resignFirstResponder];
            return NO;
        }
        
        
        [self updateTask];
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void) initializeTasks
{
    for(int i = 1; i<=[self.tasks count];i++)
    {
        [self performTaskAddedAnimation];
        index++;
    }
}

-(void) setupDateLabels
{
    NSDate *currentDate = [[NSDate alloc] init];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE MMM dd yyyy"];
    
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = self.tag;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    _newDate = [calendar dateByAddingComponents:dayComponent toDate:currentDate options:0];
    
    // create date label
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width, 40)];
    
    [self.dateLabel setTextAlignment:NSTextAlignmentCenter];
    
    self.dateLabel.text = [dateFormatter stringFromDate:_newDate];
    self.dateLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:28];
    self.dateLabel.textColor = [UIColor colorWithRed:17.0/255.0 green:129.0/255.0 blue:178.0/255.0 alpha:1.0];
    [self addSubview:self.dateLabel];
    
    if(self.tag == 0)
    {
        self.dateLabel.backgroundColor = [UIColor orangeColor];
        self.dateLabel.textColor = [UIColor whiteColor];
    }
}

-(void) initializeControls
{
    [self setupDateLabels];
    
    // create text view
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 100, self.frame.size.width, 200)];
    [self.textView setTextAlignment:NSTextAlignmentCenter];
    [self.textView setReturnKeyType:UIReturnKeyDone];
    
    [self.textView setBackgroundColor:[UIColor clearColor]];
    self.textView.alpha = 0.1;
    [self.textView setDelegate:self];
    [self.textView setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:36]];
    [self addSubview:self.textView];
    
}

-(void) setup
{
    index = 0;
    
    _circleViews = [NSMutableArray array];
    
    _taskService = [[TaskService alloc] init];
    
    [self createBarriers];
    
    [self initializeTasks];
    
    [self initializeControls];

}

//- (void)drawRect:(CGRect)rect
//{
//   }


@end
