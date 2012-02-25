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
    ContactEntity *contactEnt;
    BOOL isEditingMode;
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andContactId:(NSString *)contId;
@end
