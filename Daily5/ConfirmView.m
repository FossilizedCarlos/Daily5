//
//  ConfirmView.m
//  Daily5
//
//  Created by Mohammad Azam on 10/1/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import "ConfirmView.h"

@implementation ConfirmView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIImageView *img = [[UIImageView alloc] initWithFrame:rect];
    [img setImage:[UIImage imageNamed:@"green_circle"]];
    
    [self addSubview:img];
}


@end
