//
//  OverlayPageViewController.m
//  VisitCard
//
//  Created by Valentí on 11/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OverlayPageViewController.h"

@implementation OverlayPageViewController
@synthesize delegate,imagePickerController;
@synthesize labelSide;
@synthesize labelSideText;

-(void)dealloc{
    [super dealloc];
    [imagePickerController release];
    [labelSide release];
    [labelSideText release];
}

#pragma mark -
#pragma mark OverlayViewController init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil text:(NSString* )labelText
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        self.labelSideText = labelText;
        self.imagePickerController = [[[UIImagePickerController alloc] init] autorelease];
        self.imagePickerController.delegate = self;
    }
    return self;
}

- (void)setupImagePicker:(UIImagePickerControllerSourceType)sourceType
{
    self.imagePickerController.sourceType = sourceType;
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        // user wants to use the camera interface
        //
        self.imagePickerController.showsCameraControls = NO;
        
        if ([[self.imagePickerController.cameraOverlayView subviews] count] == 0)
        {
            // setup our custom overlay view for the camera
            //
            // ensure that our custom view's frame fits within the parent frame
            CGRect overlayViewFrame = self.imagePickerController.cameraOverlayView.frame;
            CGRect newFrame = CGRectMake(0.0,
                                         CGRectGetHeight(overlayViewFrame) -
                                         self.view.frame.size.height - 10.0,
                                         CGRectGetWidth(overlayViewFrame),
                                         self.view.frame.size.height + 10.0);
            self.view.frame = newFrame;
            [self.imagePickerController.cameraOverlayView addSubview:self.view];
        }
    }
}

- (void)finishAndUpdate
{
    [self.delegate didFinishWithCamera];  // tell our delegate we are done with the camera
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.labelSide.text = self.labelSideText;
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Actions

- (IBAction)back:(id)sender{
    [self.delegate didFinishWithCamera];  // tell our delegate we are done with the camera
    
}

- (IBAction)takePhoto:(id)sender
{
    [self.imagePickerController takePicture];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

// this get called when an image has been chosen from the library or taken from the camera
//
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];

    // give the taken picture to our delegate
    if (self.delegate)
        [self.delegate didTakePicture:image pickerC:picker];
}

@end
