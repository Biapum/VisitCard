//
//  OverlayPageViewController.h
//  VisitCard
//
//  Created by Valentí on 11/02/12.
//  Copyright (c) 2012 biapum. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OverlayPageViewControllerDelegate;

@interface OverlayPageViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    id <OverlayPageViewControllerDelegate> delegate;
    
    UIImagePickerController *imagePickerController;
    UILabel *labelSide;
    NSString *labelSideText;
}

@property (nonatomic, assign) id <OverlayPageViewControllerDelegate> delegate;
@property (nonatomic, retain) UIImagePickerController *imagePickerController;
@property (nonatomic, retain) IBOutlet UILabel *labelSide;
@property (nonatomic, retain) NSString *labelSideText;
- (void)setupImagePicker:(UIImagePickerControllerSourceType)sourceType;
- (IBAction)takePhoto:(id)sender;
- (IBAction)back:(id)sender;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil text:(NSString*)labelText;
@end


@protocol OverlayPageViewControllerDelegate
- (void)didTakePicture:(UIImage *)picture pickerC:(UIImagePickerController *)pickerC;
- (void)didFinishWithCamera;
@end