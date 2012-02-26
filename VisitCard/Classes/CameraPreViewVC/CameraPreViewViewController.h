//
//  CameraPreViewViewController.h
//  VisitCard
//
//  Created by Valentí on 11/02/12.
//  Copyright (c) 2012 Biapum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverlayPageViewController.h"
#import "ResultPageViewController.h"
#import "StepView.h"

@class MBProgressHUD;

namespace tesseract {
    class TessBaseAPI;
};

@interface CameraPreViewViewController : UIViewController<UIImagePickerControllerDelegate,OverlayPageViewControllerDelegate>
{    
    OverlayPageViewController *overlayPageVCFront; 
    OverlayPageViewController *overlayPageVCBack; 

    ResultPageViewController *resultPageVC;
    UIImagePickerController *imagePicker;
    BOOL openCamera;
    BOOL isFotoFront;
    UIImageView *imageFront;
    UIImageView *imageBack;
    
    UIImageView *imageFrontScan;
    UIImageView *imageBackScan;
    
    UILabel *labelScaningCard;
    UILabel *labelScaningCardValue;
    UIButton *buttonScan;
    
    //Tesseract
    tesseract::TessBaseAPI *tesseract;
    uint32_t *pixels;
    
    MBProgressHUD *progressHud;

    //Loading
    UIActivityIndicatorView	*progress;
    
    //Step
    StepView *stepView;

}

-(IBAction)goToCameraFront:(id)sender;
-(IBAction)goToCameraBack:(id)sender;
-(IBAction)scanPush:(id)sender;

- (void)slideView:(UIView *)viewLine withDistance:(CGFloat)distance;
@property (nonatomic,retain) UIImagePickerController *imagePicker;
@property (nonatomic, retain) OverlayPageViewController *overlayPageVCFront;
@property (nonatomic, retain) OverlayPageViewController *overlayPageVCBack;
@property (nonatomic, retain) ResultPageViewController *resultPageVC;
@property (nonatomic, assign) BOOL openCamera;
@property (nonatomic, assign) BOOL isFotoFront;

@property (nonatomic, retain) IBOutlet UIImageView *imageFront;
@property (nonatomic, retain) IBOutlet UIImageView *imageBack;

@property (nonatomic, retain) IBOutlet UIImageView *imageFrontScan;
@property (nonatomic, retain) IBOutlet UIImageView *imageBackScan;
@property (nonatomic, retain) IBOutlet UILabel *labelScaningCard;
@property (nonatomic, retain) IBOutlet UILabel *labelScaningCardValue;
@property (nonatomic, retain) IBOutlet UIButton *buttonScan;

//Step
@property (nonatomic,retain) StepView *stepView;

//Tesseract
- (void)setTesseractImage:(UIImage *)image;

@property (nonatomic, strong) MBProgressHUD *progressHud;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *progress;


@end
