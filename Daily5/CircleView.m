//
//  CircleView.m
//  Daily5
//
//  Created by Mohammad Azam on 10/2/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    
    return self;
}

-(void) setup
{
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red_circle"]];
    self.imageView.userInteractionEnabled = YES;
    self.imageView.frame = CGRectMake(0, 0, 44, 44);
    [self addSubview:self.imageView];
    
    // register gesture recognizers
    [self registerGestureRecognizers];
}

-(void) registerGestureRecognizers
{
    // single tap
    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bounce)];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    
    // double tap
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggle)];
    doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    
    [self addGestureRecognizer:singleTapGestureRecognizer];
    [self addGestureRecognizer:doubleTapGestureRecognizer];
}

-(void) markAsComplete
{
    self.alpha = 1.0; 
    [self.imageView setImage:[UIImage imageNamed:@"green_circle"]];
}

-(void) markAsIncomplete
{
    self.alpha = 1.0;
    [self.imageView setImage:[UIImage imageNamed:@"red_circle"]];
}

-(void) toggle
{
    if(self.task.taskId == 0)
        return; 
    
    
//    if(isCompleted)
//    {
//        isCompleted = NO;
//        [self markAsIncomplete];
//
//    }
//    else
//    {
//        isCompleted = YES;
//        [self markAsComplete];
//    }
//    
    // did mark selected task as complete
    if(self.didSelectTaskForCompletion != nil)
    {
        self.didSelectTaskForCompletion(self.tag);
    }

}

-(void) bounce
{
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self] mode:UIPushBehaviorModeInstantaneous];
    [pushBehavior setPushDirection:CGVectorMake(0, 0.8)];
    
    [_animator addBehavior:pushBehavior];
    
    // fire the delegate
    if(self.didSelectBlock != nil)
    {
        self.didSelectBlock(self.tag);
    }
}

-(void) enableDynamicsWithBarrier:(BarrierView *)barrierView
{
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.superview];

    _gravity = [[UIGravityBehavior alloc] initWithItems:@[self]];
    [_gravity setGravityDirection:CGVectorMake(0, 0.3)];
    
    _collision = [[UICollisionBehavior alloc] initWithItems:@[self]];
    
    [_collision addBoundaryWithIdentifier:@"barrier" fromPoint:barrierView.frame.origin toPoint:barrierView.rightEdge];
    
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self]];
    itemBehavior.elasticity = 0.25;
    
    [_animator addBehavior:_gravity];
    [_animator addBehavior:_collision];
    [_animator addBehavior:itemBehavior];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
