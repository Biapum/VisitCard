//
//  StepView.m
//  VisitCard
//
//  Created by Valentí on 25/02/12.
//  Copyright (c) 2012 Biapum. All rights reserved.
//

#import "StepView.h"

@implementation StepView

//static int space =5;

-(void)initView:(UIView*)theView andStep:(int)step{
    double totalPeace=320/3;

    CGRect c1= CGRectMake(0, 0, totalPeace, 5);
    CGRect c2= CGRectMake(totalPeace, 0, totalPeace, 5);
    CGRect c3= CGRectMake(totalPeace*2, 0, totalPeace+2, 5);    
    
    UIView *view1 = [[[UIView alloc] initWithFrame:c1] autorelease];
    UIView *view2 = [[[UIView alloc] initWithFrame:c2] autorelease];
    UIView *view3 = [[[UIView alloc] initWithFrame:c3] autorelease];
    
    UIColor *green = [[UIColor alloc] initWithRed:0 green:.54 blue:.27 alpha:1];
    UIColor *red = [[UIColor alloc] initWithRed:0.8 green:.2 blue:.2 alpha:1];

    switch (step) {
        case 1:
            [view1 setBackgroundColor:green];
            [view2 setBackgroundColor:red];    
            [view3 setBackgroundColor:red];                
            break;
        case 2:
            [view1 setBackgroundColor:green];
            [view2 setBackgroundColor:green];    
            [view3 setBackgroundColor:red];                
            break;
        case 3:
            [view1 setBackgroundColor:green];
            [view2 setBackgroundColor:green];    
            [view3 setBackgroundColor:green];                
            break;
        default:
            break;
    }
    
    [self addSubview:view1];
    [self addSubview:view2];
    [self addSubview:view3];
    
    [theView addSubview:self];
    [red release];
    [green release];
}
@end
