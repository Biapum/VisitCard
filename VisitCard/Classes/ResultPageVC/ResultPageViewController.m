//
//  ResultPageViewController.m
//  VisitCard
//
//  Created by Valentí on 11/02/12.
//  Copyright (c) 2012 Biapum. All rights reserved.
//

#import "ResultPageViewController.h"
#import "FiltersPageViewController.h"

@interface ResultPageViewController()
- (void)hideKeypad;
- (void)goToToNextScreen;
@end

@implementation ResultPageViewController
@synthesize textFieldWeb,textFieldName,textFieldEmail,textFieldPhone,textFieldtwitter;
@synthesize btHideKeypad;
@synthesize imageBack,imageFront;
@synthesize imageViewBack,imageViewFront;
@synthesize filterPageVC;
@synthesize progress;
@synthesize stepView;

-(void)dealloc{
    [super dealloc];
    [textFieldWeb release];
    [textFieldName release];
    [textFieldEmail release];
    [textFieldPhone release];
    [textFieldtwitter release];
    [btHideKeypad release];

    [imageViewBack release];
    [imageViewFront release];
    [imageFront release];
    [imageBack release];
    
    [progress release];
    [stepView release];
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
    [self.btHideKeypad setHidden:YES];

    [self.stepView = [StepView alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
    [self.stepView initView:self.view andStep:2];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    self.title = @"Edit info";
    self.imageViewFront.image = imageFront;
    self.imageViewBack.image = imageBack;
    [self.progress setHidden:YES];
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

#pragma mark -
#pragma mark texfield delegate

- (IBAction)hideKeypadButtonPressed {
    [self hideKeypad];
}

- (void)hideKeypad {
    [textFieldName resignFirstResponder];
    [textFieldPhone resignFirstResponder];
    [textFieldEmail resignFirstResponder ];
    [textFieldWeb resignFirstResponder];
    [textFieldtwitter resignFirstResponder];
    [self.btHideKeypad setHidden:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self.btHideKeypad setHidden:NO];

    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [self hideKeypad];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    return  YES;
}

#pragma mark - actions

- (IBAction)goToFilters:(id)sender{

    [self.progress setHidden:NO];

    [self performSelectorInBackground:@selector(goToToNextScreen) withObject:nil];
}

-(void)goToToNextScreen{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:self.textFieldName.text forKey:@"name"];
    [dic setValue:self.textFieldPhone.text forKey:@"phone"];
    [dic setValue:self.textFieldEmail.text forKey:@"email"];
    [dic setValue:self.textFieldWeb.text forKey:@"web"];
    [dic setValue:self.textFieldtwitter.text forKey:@"twitter"];
    
    if(imageFront)
        [dic setObject:UIImagePNGRepresentation(self.imageFront) forKey:@"cardFrontData"];
    if(imageBack)
        [dic setObject:UIImagePNGRepresentation(self.imageBack) forKey:@"cardBackData"];
    
    self.filterPageVC = [[[FiltersPageViewController alloc]initWithNibName:@"FiltersPageViewController" bundle:nil dic:dic] autorelease];
    [self.navigationController pushViewController:self.filterPageVC animated:YES];
    [dic release];

}

@end
