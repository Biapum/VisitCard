//
//  ContactDetailsViewController.h
//  VisitCard
//
//  Created by Valentí on 23/02/12.
//  Copyright (c) 2012 Biapum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactEntity.h"


@interface ContactDetailsViewController : UIViewController
{
    UIBarButtonItem *buttonEdit;
    NSString *contactId;
    UITextView *labelName;
    UITextView *labelPhone;
    UITextView *labelEmail;
    UITextView *labelWeb;
    UITextView *labelTwitter;
    
    UIImageView *contactCardFront;
    UIImageView *contactCardBack;

    UIImageView *imageEdit0;
    UIImageView *imageEdit1;
    UIImageView *imageEdit2;
    UIImageView *imageEdit3;
    UIImageView *imageEdit4;
    ContactEntity *contactEnt;
    BOOL isEditingMode;
    
    //Loading
    UIActivityIndicatorView	*progress1;
    UIActivityIndicatorView	*progress2;
    UILabel     *labelFront;
    UILabel     *labelBack;
}

@property (nonatomic,retain) UIBarButtonItem        *buttonEdit;
@property (nonatomic,retain) IBOutlet UITextView    *labelName;
@property (nonatomic,retain) IBOutlet UITextView    *labelPhone;
@property (nonatomic,retain) IBOutlet UITextView    *labelEmail;
@property (nonatomic,retain) IBOutlet UITextView    *labelWeb;
@property (nonatomic,retain) IBOutlet UITextView    *labelTwitter;

@property (nonatomic,retain) IBOutlet UIImageView   *contactCardFront;
@property (nonatomic,retain) IBOutlet UIImageView   *contactCardBack;
@property (nonatomic,retain) NSString               *contactId;
@property (nonatomic,retain) ContactEntity          *contactEnt;

@property (nonatomic,retain) IBOutlet UIImageView   *imageEdit0;
@property (nonatomic,retain) IBOutlet UIImageView   *imageEdit1;
@property (nonatomic,retain) IBOutlet UIImageView   *imageEdit2;
@property (nonatomic,retain) IBOutlet UIImageView   *imageEdit3;
@property (nonatomic,retain) IBOutlet UIImageView   *imageEdit4;

@property (nonatomic,retain) IBOutlet UIActivityIndicatorView	*progress1;
@property (nonatomic,retain) IBOutlet UIActivityIndicatorView	*progress2;

@property (nonatomic,retain) IBOutlet UILabel     *labelFront;
@property (nonatomic,retain) IBOutlet UILabel     *labelBack;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andContactId:(NSString *)contId;
@end
