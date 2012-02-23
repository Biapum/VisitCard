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
    NSString *contactId;
    UILabel *labelName;
    ContactEntity *contactEnt;
}

@property (nonatomic,retain) IBOutlet UILabel *labelName;
@property (nonatomic,retain) NSString *contactId;
@property (nonatomic,retain) ContactEntity *contactEnt;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andContactId:(NSString *)contId;
@end
