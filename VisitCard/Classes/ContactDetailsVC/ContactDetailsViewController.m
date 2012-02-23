//
//  ContactDetailsViewController.m
//  VisitCard
//
//  Created by Valentí on 23/02/12.
//  Copyright (c) 2012 Biapum. All rights reserved.
//

#import "ContactDetailsViewController.h"
#import "DataServices.h"

@implementation ContactDetailsViewController
@synthesize labelName;
@synthesize contactId;
@synthesize contactEnt;

-(void)dealloc{
    [super dealloc];
    [contactId release];
    [labelName release];
    [contactEnt release];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andContactId:(NSString *)contId{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//res
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
    self.contactEnt = [[DataServices instance] getContact:contactId]; 

    self.labelName.text = contactEnt.contactName;//contactId;
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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

@end
