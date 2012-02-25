//
//  CameraPreViewViewController.m
//  VisitCard
//
//  Created by Valentí on 11/02/12.
//  Copyright (c) 2012 Biapum. All rights reserved.
//

#import "CameraPreViewViewController.h"
#import "OverlayPageViewController.h"
#import "MBProgressHUD.h"

#include "baseapi.h"

#include "environ.h"
#import "pix.h"
#import "Utils.h"

@interface CameraPreViewViewController()
- (void)initTesseract;
- (void)goToResult;
- (void)updateCounter:(NSTimer *)theTimer;
- (void)processOcrAt:(UIImage *)image;
- (void)ocrProcessingFinished:(NSString *)result;
@end

@implementation CameraPreViewViewController
@synthesize imagePicker, overlayPageVCFront, overlayPageVCBack, resultPageVC;
@synthesize openCamera,isFotoFront;
@synthesize imageBack,imageFront;
@synthesize imageBackScan,imageFrontScan;
@synthesize labelScaningCard,buttonScan;
@synthesize labelScaningCardValue;

@synthesize progressHud,progress;

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
    [progress release];
    //Tessract
    delete tesseract;
    tesseract = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initTesseract];//        -(void)initTesseract{

    }
    return self;
}

-(void)initTesseract{
    // Set up the tessdata path. This is included in the application bundle
    // but is copied to the Documents directory on the first run.
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = ([documentPaths count] > 0) ? [documentPaths objectAtIndex:0] : nil;
    
    NSString *dataPath = [documentPath stringByAppendingPathComponent:@"tessdata"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // If the expected store doesn't exist, copy the default store.
    if (![fileManager fileExistsAtPath:dataPath]) {
        // get the path to the app bundle (with the tessdata dir)
        NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
        NSString *tessdataPath = [bundlePath stringByAppendingPathComponent:@"tessdata"];
        if (tessdataPath) {
            [fileManager copyItemAtPath:tessdataPath toPath:dataPath error:NULL];
        }
    }
    
    setenv("TESSDATA_PREFIX", [[documentPath stringByAppendingString:@"/"] UTF8String], 1);
    
    // init the tesseract engine.
    tesseract = new tesseract::TessBaseAPI();
    tesseract->Init([dataPath cStringUsingEncoding:NSUTF8StringEncoding], "eng");  
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
    [NSTimer scheduledTimerWithTimeInterval:.03
									 target:self
								   selector:@selector(updateCounter:)
								   userInfo:nil
									repeats:YES];
    
    self.progressHud = [[MBProgressHUD alloc] initWithView:self.view];
    self.progressHud.labelText = @"Processing OCR";
    
    [self.view addSubview:self.progressHud];
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
    self.labelScaningCard.text = @"Scanning card...";
    self.labelScaningCardValue.text = @"0";
    [self.labelScaningCardValue setHidden:YES];
    [self.progress setHidden:YES];
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
    if (![self.progressHud isHidden])
        [self.progressHud hide:NO];
    self.progressHud = nil;
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
    self.labelScaningCardValue.text = @"0";
    [self.labelScaningCardValue setHidden:NO];
    [self.progress setHidden:NO];
    [self performSelectorInBackground:@selector(goToResult) withObject:nil];
}

-(void)goToResult{
    //[NSThread sleepForTimeInterval:2.2];

    UIImage *image =[UIImage imageNamed:@"cardtext.png"];
    //[self.progressHud showWhileExecuting:@selector(processOcrAt:) onTarget:self withObject:[Utils convertImageToGrayScale:self.imageFront.image] animated:YES];
    if(self.imageFront.image)
        [self processOcrAt:[Utils convertImageToGrayScale:self.imageFront.image]];
    else
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
    
    [UIView animateWithDuration:4
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

#pragma mark - Tesseract

- (void)processOcrAt:(UIImage *)image
{
    [self setTesseractImage:image];
    
    tesseract->Recognize(NULL);
    char* utf8Text = tesseract->GetUTF8Text();
    
    [self performSelectorOnMainThread:@selector(ocrProcessingFinished:)
                           withObject:[NSString stringWithUTF8String:utf8Text]
                        waitUntilDone:NO];
}

- (void)ocrProcessingFinished:(NSString *)result
{
    [[[UIAlertView alloc] initWithTitle:@"Alerta"
                                message:[NSString stringWithFormat:@"Reconegut:\n%@", result]
                               delegate:self
                      cancelButtonTitle:nil
                      otherButtonTitles:@"Seguir", nil] show];
    self.labelScaningCard.text = @"Scanned done";
    [self.progress setHidden:YES];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [resultPageVC setImageBack:nil];
    [resultPageVC setImageFront:nil];
    [resultPageVC setImageBack:self.imageBack.image];
    [resultPageVC setImageFront:self.imageFront.image];
    [self.navigationController pushViewController:resultPageVC animated:YES];
}

- (void)setTesseractImage:(UIImage *)image
{
    free(pixels);
    
    CGSize size = [image size];
    int width = size.width;
    int height = size.height;
	
	if (width <= 0 || height <= 0)
		return;
	
    // the pixels will be painted to this array
    pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
    // clear the pixels so any transparency is preserved
    memset(pixels, 0, width * height * sizeof(uint32_t));
	
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace, 
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
	
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [image CGImage]);
	
	// we're done with the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    tesseract->SetImage((const unsigned char *) pixels, width, height, sizeof(uint32_t), width * sizeof(uint32_t));
}


@end
