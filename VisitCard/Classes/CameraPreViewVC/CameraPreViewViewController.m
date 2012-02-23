//
//  CameraPreViewViewController.m
//  VisitCard
//
//  Created by Valentí on 11/02/12.
//  Copyright (c) 2012 Biapum. All rights reserved.
//

#import "CameraPreViewViewController.h"
#import "OverlayPageViewController.h"

@interface CameraPreViewViewController()
- (void)goToResult;
- (void)updateCounter:(NSTimer *)theTimer;
@end

@implementation CameraPreViewViewController
@synthesize imagePicker, overlayPageVCFront, overlayPageVCBack, resultPageVC;
@synthesize openCamera,isFotoFront;
@synthesize imageBack,imageFront;
@synthesize imageBackScan,imageFrontScan;
@synthesize labelScaningCard,buttonScan;
@synthesize labelScaningCardValue;

-(void)dealloc{
    [super dealloc];
    [imagePicker release];
    [overlayPageVCFront release];
    [overlayPageVCBack release];
    [resultPageVC release];
    
    [imageBack release];
    [imageFront release];
    [imageFrontScan release];
    [imageBackScan release];
    [labelScaningCard release];
    [labelScaningCardValue release];
    [buttonScan release];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    self.resultPageVC = [[ResultPageViewController alloc] initWithNibName:@"ResultPageViewController" bundle:nil];
    // Do any additional setup after loading the view from its nib.
    self.overlayPageVCFront = [[OverlayPageViewController alloc] initWithNibName:@"OverlayPageViewController" bundle:nil text:@"Front"];
    self.overlayPageVCBack = [[OverlayPageViewController alloc] initWithNibName:@"OverlayPageViewController" bundle:nil text:@"Back"];
    self.overlayPageVCFront.delegate = self;
    self.overlayPageVCBack.delegate = self;
    [NSTimer scheduledTimerWithTimeInterval:.022
									 target:self
								   selector:@selector(updateCounter:)
								   userInfo:nil
									repeats:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    self.title = @"Scan card";
    
    [self.imageFrontScan setHidden:YES];
    [self.imageBackScan setHidden:YES];
    [self.labelScaningCard setHidden:YES];
    [self.buttonScan setEnabled:YES];
    self.labelScaningCardValue.text = @"0";
    [self.labelScaningCardValue setHidden:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    if(openCamera){
        self.imageFront.image = nil;
        self.imageBack.image = nil;
        [self goToCameraFront:nil];
        openCamera =NO;
    }
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

#pragma mark - actions

-(IBAction)scanPush:(id)sender{
    [self slideView:self.imageFrontScan withDistance:-200];
    [self slideView:self.imageBackScan withDistance:-200];
    [self.labelScaningCard setHidden:NO];
    [self.buttonScan setEnabled:NO];
    [resultPageVC setImageBack:self.imageBack.image];
    [resultPageVC setImageFront:self.imageFront.image];
    self.labelScaningCardValue.text = @"0";
    [self.labelScaningCardValue setHidden:NO];
    
    [self performSelectorInBackground:@selector(goToResult) withObject:nil];
}

-(void)goToResult{
    [NSThread sleepForTimeInterval:2.2];

    
    [self.navigationController pushViewController:resultPageVC animated:YES];
}

-(IBAction)goToCameraFront:(id)sender{
    isFotoFront = YES;

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {    
        [self.overlayPageVCFront setupImagePicker:UIImagePickerControllerSourceTypeCamera];
        [self presentModalViewController:self.overlayPageVCFront.imagePickerController animated:YES];
    }
}

-(IBAction)goToCameraBack:(id)sender{
    isFotoFront = NO;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {    
        [self.overlayPageVCBack setupImagePicker:UIImagePickerControllerSourceTypeCamera];
        [self presentModalViewController:self.overlayPageVCBack.imagePickerController animated:YES];
    }
}
#pragma mark -
#pragma mark OverlayViewControllerDelegate

// as a delegate we are being told a picture was taken
- (void)didTakePicture:(UIImage *)picture pickerC:(UIImagePickerController *)pickerC{
    
    NSLog(@"Witdh %f", picture.size.width);
    NSLog(@"Height %f", picture.size.height);
    
    if(isFotoFront){
        self.imageFront.image = picture;
        if(self.imageBack.image == nil){
            [self performSelectorInBackground:@selector(goToCameraBack:) withObject:nil];
        }else{
            [self dismissModalViewControllerAnimated:YES];
        }
    }else{
        [self dismissModalViewControllerAnimated:YES];
        self.imageBack.image = picture;    
    }
}

// as a delegate we are told to finished with the camera
- (void)didFinishWithCamera
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - animations

- (void)slideView:(UIView *)viewLine withDistance:(CGFloat)distance{
    [viewLine setHidden:NO];
    
    CGRect posFinal= viewLine.frame;
    CGRect posInicial= viewLine.frame;
    posInicial.origin.y = posInicial.origin.y+distance;
    viewLine.frame = posInicial;
    
    [UIView animateWithDuration:2
                     animations:^{
                         [viewLine setFrame:posFinal];
                     }];
}


- (void)updateCounter:(NSTimer *)theTimer {
    if([self.labelScaningCardValue.text intValue] <100){
        int value = [self.labelScaningCardValue.text intValue]+1;
        self.labelScaningCardValue.text = [NSString stringWithFormat:@"%i",value];     
    }
}

@end
