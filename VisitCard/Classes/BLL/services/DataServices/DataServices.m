//
//  DataServices.m
//  VisitCard
//
//  Created by Valentí on 13/02/12.
//  Copyright (c) 2012 Biapum. All rights reserved.
//

#import "DataServices.h"
#import "ContactEntity.h"

@implementation DataServices
@synthesize arrayContacts;

#pragma mark -
#pragma mark Singleton methods

static DataServices *myInstance = nil;

+ (DataServices *)instance {
	if( myInstance == nil ) {
        myInstance = [[super allocWithZone:NULL] init];
        myInstance.arrayContacts = [[NSMutableArray alloc]init];
	}
	return myInstance;
}

- (void)dealloc
{
    //res
}

+ (id)allocWithZone:(NSZone *)zone {
	return [[self instance] retain];
}

- (id)copyWithZone:(NSZone *)zone {
	return self;
}

- (id)retain {
	return self;
}

- (NSUInteger)retainCount {
	return NSUIntegerMax;
}

- (void)relase {
	// do nothing
}

- (id)autorelease {
	return self;
}

#pragma mark - init

-(void)initArrayContacts{
    
}

-(void)addContact:(ContactEntity *)contact{
    [self.arrayContacts addObject:contact];
}

#pragma mark - gets

-(NSMutableArray *)getTheArrayContacts{
    return self.arrayContacts;
}
@end
