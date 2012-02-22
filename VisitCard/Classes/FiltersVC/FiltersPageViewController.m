//
//  FiltersPageViewController.m
//  VisitCard
//
//  Created by Valentí on 12/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FiltersPageViewController.h"
#import "FiltersServices.h"
#import "DataServices.h"

@interface FiltersPageViewController()

-(void)initPicker;
-(void)pickerAnimation;
-(void)pickerAnimation;

@end

@implementation FiltersPageViewController
@synthesize contactNew;
@synthesize pickerType;
@synthesize arrayPicker;
@synthesize arrayType,arrayEvent,arrayProfession;
@synthesize myPickerView;
@synthesize textFieldType,textFieldEvent,textFieldProfession;
@synthesize labelName;
-(void)dealloc{
    [super dealloc];
    [contactNew release];
    [arrayPicker release];
    [arrayProfession release];
    [arrayType release];
    [arrayEvent release];
    [myPickerView release];
    [textFieldType release];
    [textFieldEvent release];
    [textFieldProfession release];
    [labelName release];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil dic:(NSMutableDictionary*)dic_
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.contactNew = [[ContactEntity alloc]initWithDictionary:dic_];
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
    
    self.labelName.text=self.contactNew.contactName;
    
    self.arrayType = [[NSMutableArray alloc] initWithArray:[[FiltersServices instance] getTheArrayTypes]];
    self.arrayProfession = [[NSMutableArray alloc] initWithArray:[[FiltersServices instance] getTheArrayProfessions]];
    self.arrayEvent = [[NSMutableArray alloc] initWithArray:[[FiltersServices instance] getTheArrayEvents]];
    self.myPickerView.tag=pickerTypeType;
    NSLog(@"arrayPicker %@",self.arrayType);
    [self initPicker];

    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    self.title = @"Set Filters";
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

-(IBAction)pushType:(id)sender{
    [self.arrayPicker removeAllObjects];
    self.myPickerView.tag = pickerTypeType;
    [self.myPickerView reloadAllComponents];
    [self.myPickerView setNeedsDisplay];
    [self.myPickerView selectRow:0 inComponent:0 animated:NO];
    [self pickerAnimation];
}

-(IBAction)pushEvent:(id)sender{
    [self.arrayPicker removeAllObjects];
    self.myPickerView.tag = pickerTypeEvent;
    [self.myPickerView reloadAllComponents];
    [self.myPickerView setNeedsDisplay];
    [self.myPickerView selectRow:0 inComponent:0 animated:NO];
    [self pickerAnimation];
}

-(IBAction)pushProfession:(id)sender{
    [self.arrayPicker removeAllObjects];
    self.myPickerView.tag = pickerTypeProfession;
    [self.myPickerView reloadAllComponents];
    [self.myPickerView setNeedsDisplay];
    [self.myPickerView selectRow:0 inComponent:0 animated:NO];
    [self pickerAnimation];
}

-(IBAction)addType:(id)sender{}
-(IBAction)addEvent:(id)sender{}
-(IBAction)addProfession:(id)sender{}


- (IBAction)saveCard:(id)sender{
    
    [[DataServices instance] addContact:self.contactNew];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Correct" message:@"Card saved correctly" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

#pragma mark -
#pragma mark Picker View

-(void)initPicker{
    self.myPickerView.delegate=self;
	self.arrayPicker = [[NSMutableArray alloc] init];
    [self.myPickerView selectRow:0 inComponent:0 animated:NO];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
	return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView.tag==pickerTypeType){
        self.textFieldType.text = [self.arrayType objectAtIndex:row];
    }
    if(pickerView.tag==pickerTypeProfession){
        self.textFieldProfession.text = [self.arrayProfession objectAtIndex:row];
    }
    if(pickerView.tag==pickerTypeEvent){
        self.textFieldEvent.text = [self.arrayEvent objectAtIndex:row];
    }
}   

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    if(pickerView.tag==pickerTypeType){
        return  [self.arrayType count];
    }
    if(pickerView.tag==pickerTypeProfession){
        return  [self.arrayProfession count];
    }
    if(pickerView.tag==pickerTypeEvent){
        return  [self.arrayEvent count];
    }
	return [self.arrayPicker count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    if(pickerView.tag==pickerTypeType){
        return  [self.arrayType objectAtIndex:row];
    }
    if(pickerView.tag==pickerTypeProfession){
        return  [self.arrayProfession objectAtIndex:row];
    }
    if(pickerView.tag==pickerTypeEvent){
        return  [self.arrayEvent objectAtIndex:row];
    }
	return [self.arrayPicker objectAtIndex:row];
}

-(void)pickerAnimation{
    [self.myPickerView setAlpha:0.5];
    [UIView animateWithDuration:1
                     animations:^{
                         [self.myPickerView setAlpha:1];
                     }];   
}

@end
