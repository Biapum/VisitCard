//
//  ListPageViewController.h
//  VisitCard
//
//  Created by Valentí on 11/02/12.
//  Copyright (c) 2012 Biapum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListPageViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTableView;
	NSArray *contactsArray;
}

@property (nonatomic, retain) NSArray *contactsArray;
@property (nonatomic, retain) IBOutlet UITableView  *myTableView;

@end
