    //
//  ContactDetailsViewController.m
//  VisitCard
//
//  Created by Valentí on 23/02/12.
//  Copyright (c) 2012 Biapum. All rights reserved.
//

#import "ContactDetailsViewController.h"
#import "DataServices.h"

@interface ContactDetailsViewController()

-(void)initImages;
-(void)setContactInfo;
-(void)pushEdit;
-(void)canEditButtons:(BOOL)isEdit;
@end

@implementation ContactDetailsViewController
@synthesize buttonEdit;
@synthesize labelName,labelPhone,labelEmail,labelWeb,labelTwitter;
@synthesize contactId;
@synthesize contactEnt;
@synthesize contactCardFront,contactCardBack;
@synthesize imageEdit0,imageEdit1,imageEdit2,imageEdit3,imageEdit4;
@synthesize progress1,progress2;
@synthesize labelBack, labelFront;

-(void)dealloc{
    [super dealloc];
    [buttonEdit release];
    [contactId release];
    [labelName release];
    [labelPhone release];
    [labelEmail release];
    [labelWeb release];
    [labelTwitter release];
    [contactCardBack release];
    [contactCardFront release];
    [imageEdit0 release];
    [imageEdit1 release];
    [imageEdit2 release];
    [imageEdit3 release];
    [imageEdit4 release];
    [progress1 release];
    [progress2 release];
    [labelBack release];
    [labelFront release];
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
    [self setContactInfo];
    // Do any additional setup after loading the view from its nib.
    self.buttonEdit = [[UIBarButtonItem alloc] 
                       initWithTitle:@"Edit"                                            
                       style:UIBarButtonItemStylePlain
                       target:self 
                       action:@selector(pushEdit)];
    self.navigationItem.rightBarButtonItem = buttonEdit;
    
    if(contactEnt.contactCardFrontData){
        [self.progress1 setHidden:NO];
        [self.labelFront setHidden:NO];
    }else{
        [self.progress1 setHidden:YES];
        [self.labelFront setHidden:YES];
    }
    if(contactEnt.contactCardBackData){
        [self.progress2 setHidden:NO];
        [self.labelBack setHidden:NO];
    }else{
        [self.progress2 setHidden:YES];
        [self.labelBack setHidden:YES];
    }
}

-(void)setContactInfo{
    self.labelName.text = contactEnt.contactName;
    self.labelPhone.text = contactEnt.contactPhone;
    self.labelEmail.text = contactEnt.contactEmail;
    self.labelWeb.text = contactEnt.contactWeb;
    self.labelTwitter.text = contactEnt.contactTwitter;
    
    
}

-(void)initImages{
    //NSLog(@"NSDATAfront es: %@",contactEnt.contactCardFrontData);
    self.contactCardFront.image = [UIImage imageWithData:contactEnt.contactCardFrontData];
    self.contactCardBack.image = [UIImage imageWithData:contactEnt.contactCardBackData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    isEditingMode = NO;
    [self canEditButtons:NO];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self performSelectorInBackground:@selector(initImages) withObject:nil];
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
#pragma mark actions

-(void)pushEdit{
    if(isEditingMode){
        [self canEditButtons:NO];
        isEditingMode=NO;
        [self.buttonEdit setTitle:@"Edit"];
        [self.imageEdit0 setHidden:YES];
        [self.imageEdit1 setHidden:YES];
        [self.imageEdit2 setHidden:YES];
        [self.imageEdit3 setHidden:YES];
        [self.imageEdit4 setHidden:YES];
        [self.labelName setBackgroundColor:[UIColor clearColor]];
        [self.labelPhone setBackgroundColor:[UIColor clearColor]];
    }
    else{
        [self canEditButtons:YES];        
        isEditingMode=YES;
        [self.buttonEdit setTitle:@"Done"];
        [self.imageEdit0 setHidden:NO];
        [self.imageEdit1 setHidden:NO];
        [self.imageEdit2 setHidden:NO];
        [self.imageEdit3 setHidden:NO];
        [self.imageEdit4 setHidden:NO];
        [self.labelName setBackgroundColor:[UIColor darkGrayColor]];
        [self.labelPhone setBackgroundColor:[UIColor darkGrayColor]];
    }
}

-(void)canEditButtons:(BOOL)isEdit{
    [self.labelName setEditable:isEdit];
    [self.labelPhone setEditable:isEdit];
    [self.labelEmail setEditable:isEdit];
    [self.labelWeb setEditable:isEdit];
    [self.labelTwitter setEditable:isEdit];
}


@end
