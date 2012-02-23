//
//  DataServices.h
//  VisitCard
//
//  Created by Valentí on 13/02/12.
//  Copyright (c) 2012 Biapum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactEntity.h"

@interface DataServices : NSObject
{
    NSMutableArray *arrayContacts;
}

@property (nonatomic,retain) NSMutableArray *arrayContacts;
+(DataServices *)instance;

-(void)initArrayContacts;
-(NSMutableArray *)getTheArrayContacts;
-(ContactEntity *)getContact:(NSString *)contactId;
-(NSString*)getCurrentId;

-(void)addContact:(ContactEntity *)contact;
-(void)loadData;
-(void)saveData;

@end
