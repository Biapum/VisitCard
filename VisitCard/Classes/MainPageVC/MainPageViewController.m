//
//  MainPageViewController.m
//  VisitCard
//
//  Created by Valentí on 11/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainPageViewController.h"

@implementation MainPageViewController
@synthesize cameraPreViewVC,listPageVC,meVC;

-(void)dealloc{
    [super dealloc];
    [cameraPreViewVC release];
    [listPageVC release];
    [meVC release];
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
    cameraPreViewVC = [[CameraPreViewViewController alloc]init];
    listPageVC = [[ListPageViewController alloc]init];
    meVC= [[MeViewController alloc]init];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setHidden:YES];
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

-(IBAction)newCardAction:(id)sender{
    [cameraPreViewVC setOpenCamera:YES];
    [self.navigationController pushViewController:cameraPreViewVC animated:YES];
}

-(IBAction)myCards:(id)sender{
    [self.navigationController pushViewController:listPageVC animated:YES];

}

-(IBAction)me:(id)sender{
    [self.navigationController pushViewController:meVC animated:YES];
    
}
@end
