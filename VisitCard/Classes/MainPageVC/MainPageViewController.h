//
//  MainPageViewController.h
//  VisitCard
//
//  Created by Valentí on 11/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraPreViewViewController.h"
#import "ListPageViewController.h"
#import "MeViewController.h"

@interface MainPageViewController : UIViewController
{
    CameraPreViewViewController *cameraPreViewVC;
    ListPageViewController *listPageVC;
    MeViewController *meVC;
}

-(IBAction)newCardAction:(id)sender;
-(IBAction)myCards:(id)sender;
-(IBAction)me:(id)sender;

@property (nonatomic,retain) CameraPreViewViewController *cameraPreViewVC;
@property (nonatomic,retain) ListPageViewController *listPageVC;
@property (nonatomic,retain) MeViewController *meVC;
@end
