//
//  MainPageViewController.m
//  VisitCard
//
//  Created by Valentí on 11/02/12.
//  Copyright (c) 2012 Biapum. All rights reserved.
//

#import "MainPageViewController.h"
#import "DataServices.h"
#import "AppDelegate.h"

#define NUMBER_OF_ITEMS ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)? 19: 12)
#define ITEM_SPACING 210

@interface MainPageViewController ()
-(void)makeTheSoundPassCard;
@end

@implementation MainPageViewController
@synthesize cameraPreViewVC,listPageVC,meVC;
@synthesize labelCurrentPoint;
@synthesize carousel;
@synthesize arrayCards;

-(void)dealloc{
    [super dealloc];
    [cameraPreViewVC release];
    [listPageVC release];
    [meVC release];
    [labelCurrentPoint release];
    [arrayCards release];
    
    carousel.delegate = nil;
    carousel.dataSource = nil;
    [carousel release];
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
    [super didReceiveMemoryWarning];    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    cameraPreViewVC = [[CameraPreViewViewController alloc]init];
    listPageVC = [[ListPageViewController alloc]init];
    meVC= [[MeViewController alloc]init];

    //configure carousel
    carousel.type = iCarouselTypeWheel;
    self.arrayCards = [[NSMutableArray alloc] init];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setHidden:YES];
    self.arrayCards = [[DataServices instance] getTheArrayContacts];
    [self.carousel reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.carousel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;//for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
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

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
   // return [self.arrayCards count];
    return NUMBER_OF_ITEMS;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{ 
	UIButton *button = (UIButton *)view;
	if (button == nil)
	{
		//no button available to recycle, so create new one
		UIImage *image = [UIImage imageNamed:@"page.png"];
		button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[button setBackgroundImage:image forState:UIControlStateNormal];
		button.titleLabel.font = [button.titleLabel.font fontWithSize:50];
		[button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	}
	
	//set button label
	[button setTitle:[NSString stringWithFormat:@"%i", index] forState:UIControlStateNormal];
    
	
	return button;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return ITEM_SPACING;
}

- (void)carouselDidScroll:(iCarousel *)carousel_{
//    NSInteger index = [carousel indexOfItemView:carousel];


}

- (void)carouselCurrentItemIndexUpdated:(iCarousel *)carousel_{
    NSLog(@"%i,",carousel_.currentItemIndex);
    self.labelCurrentPoint.text = [NSString stringWithFormat:@"%i/%i",carousel_.currentItemIndex,carousel_.numberOfItems];
    [self performSelectorInBackground:@selector(makeTheSoundPassCard) withObject:nil];
}

-(void)makeTheSoundPassCard{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.passCard play];
}

#pragma mark -
#pragma mark Button tap event

- (void)buttonTapped:(UIButton *)sender
{
	//get item index for button
	NSInteger index = [carousel indexOfItemView:sender];
	
    [[[[UIAlertView alloc] initWithTitle:@"Card tapped"
                                 message:[NSString stringWithFormat:@"You tapped tap with id %i", index]
                                delegate:nil
                       cancelButtonTitle:@"OK"
                       otherButtonTitles:nil] autorelease] show];
}

@end
