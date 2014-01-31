//
//  BarrierView.m
//  Daily5
//
//  Created by Mohammad Azam on 10/2/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import "BarrierView.h"

@implementation BarrierView

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
    self.rightEdge = CGPointMake(self.frame.origin.x + self.frame.size.width, self.frame.origin.y);
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(contextRef, 31.0/255.0, 141.0/255.0, 255.0/255.0, 1.0);
    //CGContextSetRGBStrokeColor(contextRef, 0, 0, 255, 1.0);
    
    CGContextFillEllipseInRect(contextRef, CGRectMake(0, 10, 5, 5));

    
}


@end
