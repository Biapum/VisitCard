//
//  ResultPageViewController.h
//  VisitCard
//
//  Created by Valentí on 11/02/12.
//  Copyright (c) 2012 Biapum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FiltersPageViewController.h"

@interface ResultPageViewController : UIViewController <UITextFieldDelegate>
{
    UITextField *textFieldName;
    UITextField *textFieldPhone;
    UITextField *textFieldEmail;
    UITextField *textFieldWeb;
    UITextField *textFieldtwitter;
    
    UIButton *btHideKeypad;
    
    UIImage *imageFront;
    UIImage *imageBack;
    UIImageView *imageViewFront;
    UIImageView *imageViewBack;
    FiltersPageViewController *filterPageVC;
    
    //Loading
    UIActivityIndicatorView	*progress;
}

@property (nonatomic,retain) IBOutlet UITextField *textFieldName;
@property (nonatomic,retain) IBOutlet UITextField *textFieldPhone;
@property (nonatomic,retain) IBOutlet UITextField *textFieldEmail;
@property (nonatomic,retain) IBOutlet UITextField *textFieldWeb;
@property (nonatomic,retain) IBOutlet UITextField *textFieldtwitter;
@property (nonatomic,retain) IBOutlet UIButton *btHideKeypad;

@property (nonatomic,retain) UIImage *imageFront;
@property (nonatomic,retain) UIImage *imageBack;

@property (nonatomic,retain) IBOutlet UIImageView *imageViewFront;
@property (nonatomic,retain) IBOutlet UIImageView *imageViewBack;
@property (nonatomic,retain) FiltersPageViewController *filterPageVC;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *progress;

- (IBAction)hideKeypadButtonPressed;
- (IBAction)goToFilters:(id)sender;
@end
