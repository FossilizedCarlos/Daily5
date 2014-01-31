//
//  CircleView.h
//  Daily5
//
//  Created by Mohammad Azam on 10/2/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarrierView.h"
#import "Task.h"

typedef void (^didSelectTask) (int);
typedef void (^didSelectTaskForCompletion) (int);

@interface CircleView : UIView
{
    UIDynamicAnimator *_animator;
    UIGravityBehavior *_gravity;
    UICollisionBehavior *_collision;
    
    BOOL isCompleted;
}

@property (nonatomic,strong) Task *task;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,copy) didSelectTask didSelectBlock;
@property (nonatomic,copy) didSelectTaskForCompletion didSelectTaskForCompletion;

-(void) enableDynamicsWithBarrier:(BarrierView *) barrierView;
-(void) bounce;
-(void) markAsComplete;
-(void) markAsIncomplete;

@end

