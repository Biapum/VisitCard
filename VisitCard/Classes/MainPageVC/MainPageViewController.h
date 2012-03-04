//
//  MainPageViewController.h
//  VisitCard
//
//  Created by Valentí on 11/02/12.
//  Copyright (c) 2012 Biapum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraPreViewViewController.h"
#import "ListPageViewController.h"
#import "MeViewController.h"
#import "iCarousel.h"

@interface MainPageViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>
{
    CameraPreViewViewController *cameraPreViewVC;
    ListPageViewController      *listPageVC;
    MeViewController            *meVC;
    
    NSMutableArray              *arrayCards;
    UILabel                     *labelCurrentPoint;
    
    //CardView
    UILabel                     *cardLabelName;
    UIButton                    *cardButtonRemove;
    UIButton                    *cardButtonMoreInfo;
    
    //Order
    UIView                      *viewOrder;
    UISegmentedControl          *segmentedControl;
}

- (IBAction)newCardAction:(id)sender;
- (IBAction)myCards:(id)sender;
- (IBAction)me:(id)sender;

@property (nonatomic,retain) CameraPreViewViewController    *cameraPreViewVC;
@property (nonatomic,retain) ListPageViewController         *listPageVC;
@property (nonatomic,retain) MeViewController               *meVC;
@property (nonatomic, retain) IBOutlet UILabel              *labelCurrentPoint;
@property (nonatomic, retain) NSMutableArray                *arrayCards;
@property (nonatomic, retain) IBOutlet iCarousel            *carousel;

//Order
@property (nonatomic, retain) IBOutlet UIView               *viewOrder;
@property (nonatomic,retain) IBOutlet UISegmentedControl    *segmentedControl;

- (IBAction)pushOpenOrderView:(id)sender;
- (IBAction)pushCloseOrderView:(id)sender;

#pragma mark- CardView methods
@property (nonatomic, retain) IBOutlet UILabel              *cardLabelName;
@property (nonatomic, retain) IBOutlet UIButton             *cardButtonRemove;
@property (nonatomic, retain) IBOutlet UIButton             *cardButtonMoreInfo;

- (IBAction)removeCard:(id)sender;
- (IBAction)pushMoreButoon:(id)sender;

@end
