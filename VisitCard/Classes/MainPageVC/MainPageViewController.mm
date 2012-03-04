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
#import "ContactEntity.h"
#import "ContactDetailsViewController.h"

#define NUMBER_OF_ITEMS ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)? 19: 12)
#define ITEM_SPACING 210

@interface MainPageViewController ()
- (void)makeTheSoundPassCard;
- (void)slideView:(CGFloat)distance;
- (void)setSegmentedControlButtons;
@end

@implementation MainPageViewController
@synthesize cameraPreViewVC,listPageVC,meVC;
@synthesize labelCurrentPoint;
@synthesize carousel;
@synthesize arrayCards;
@synthesize viewOrder,segmentedControl;

//cardView
@synthesize cardLabelName;
@synthesize cardButtonRemove,cardButtonMoreInfo;

-(void)dealloc{
    [super dealloc];
    [cameraPreViewVC release];
    [listPageVC release];
    [meVC release];
    [labelCurrentPoint release];
    
    //CARDVIEW
    [cardLabelName release];
    [cardButtonRemove release];
    [cardButtonMoreInfo release];
    
    [viewOrder release];
    [segmentedControl release];
    
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
    //self.arrayCards = [[NSMutableArray alloc] init];
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

-(IBAction)pushMoreButoon:(id)sender{
    NSInteger index = carousel.currentItemIndex;
    
    ContactEntity *contact =[self.arrayCards objectAtIndex:index];
    
    ContactDetailsViewController *contactDetailVC = [[ContactDetailsViewController alloc] initWithNibName:@"ContactDetailsViewController" bundle:nil andContactId:@"proba"];
    contactDetailVC.contactId = contact.contactId;
    
    [self.navigationController pushViewController:contactDetailVC animated:YES];
	[contactDetailVC release];
}

- (IBAction)removeCard:(id)sender
{
    if (carousel.numberOfItems > 0)
    {
//        NSInteger index = carousel.currentItemIndex;
//        [carousel removeItemAtIndex:index animated:YES];
//        ContactEntity *c = [self.arrayCards objectAtIndex:index];
//        NSLog(@"push string %@",c.contactId);
//        NSString *contactId =c.contactId;
//        [[DataServices instance] removeContact:contactId];
//        //[self.arrayCards removeObjectAtIndex:index];
//        [self.carousel reloadData];
    }
}

-(IBAction) segmentedControlIndexChanged{
    
    [self setSegmentedControlButtons];
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [self.arrayCards count];
   // return NUMBER_OF_ITEMS;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{ 
    if (!view)
    {
    	//load new item view instance from nib
        //control events are bound to view controller in nib file
    	view = [[[NSBundle mainBundle] loadNibNamed:@"ItemView" owner:self options:nil] lastObject];
        ContactEntity *c = [self.arrayCards objectAtIndex:index];

        self.cardLabelName.text = [NSString stringWithFormat:@"%@", c.contactName];
    }
    return view;
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

#pragma mark - order view animation

- (IBAction)pushOpenOrderView:(id)sender{
    [self slideView:0];
}

- (IBAction)pushCloseOrderView:(id)sender{
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
    {
        [self slideView:-320];
    }else{
        [self slideView:-480];
    }
}

- (void)slideView:(CGFloat)distance{

    [UIView animateWithDuration:.5
                     animations:^{
                         CGRect vFrame = [viewOrder frame];
                         vFrame.origin.x =distance;
                         [viewOrder setFrame:vFrame];
                     }];

}

#pragma mark - segmentedControl

-(void)setSegmentedControlButtons{
	switch (self.segmentedControl.selectedSegmentIndex) {
		case 0:
            NSLog(@"push 0");
            break;			
		case 1:
            NSLog(@"push 1");
     		break;
    	default:
			break;
	}
}

@end
