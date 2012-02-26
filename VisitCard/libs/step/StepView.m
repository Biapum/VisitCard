//
//  StepView.m
//  VisitCard
//
//  Created by Valentí on 25/02/12.
//  Copyright (c) 2012 Biapum. All rights reserved.
//

#import "StepView.h"

@implementation StepView

static int space =5;

-(void)initView:(UIView*)theView andStep:(int)step{
    int totalPeace=(320-space*(3+1))/3;

    CGRect c1= CGRectMake(space, space, totalPeace, 10);
    CGRect c2= CGRectMake(totalPeace+space*2, space, totalPeace, 10);
    CGRect c3= CGRectMake(totalPeace*2+space*3, space, totalPeace, 10);    
    
    UIView *view1 = [[[UIView alloc] initWithFrame:c1] autorelease];
    UIView *view2 = [[[UIView alloc] initWithFrame:c2] autorelease];
    UIView *view3 = [[[UIView alloc] initWithFrame:c3] autorelease];

    switch (step) {
        case 1:
            [view1 setBackgroundColor:[UIColor greenColor]];
            [view2 setBackgroundColor:[UIColor redColor]];    
            [view3 setBackgroundColor:[UIColor redColor]];                
            break;
        case 2:
            [view1 setBackgroundColor:[UIColor greenColor]];
            [view2 setBackgroundColor:[UIColor greenColor]];    
            [view3 setBackgroundColor:[UIColor redColor]];                
            break;
        case 3:
            [view1 setBackgroundColor:[UIColor greenColor]];
            [view2 setBackgroundColor:[UIColor greenColor]];    
            [view3 setBackgroundColor:[UIColor greenColor]];                
            break;
        default:
            break;
    }
    
    [self addSubview:view1];
    [self addSubview:view2];
    [self addSubview:view3];
    
    [theView addSubview:self];
}
@end
