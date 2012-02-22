//
//  FiltersServices.m
//  VisitCard
//
//  Created by Valentí on 13/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FiltersServices.h"

@implementation FiltersServices
@synthesize arrayType,arrayEvent,arrayProfession;

#pragma mark -
#pragma mark Singleton methods

static FiltersServices *myInstance = nil;

+ (FiltersServices *)instance {
	if( myInstance == nil ) {
        myInstance = [[super allocWithZone:NULL] init];
        
        myInstance.arrayEvent = [[NSMutableArray alloc]init];
        myInstance.arrayProfession = [[NSMutableArray alloc]init];
        myInstance.arrayType = [[NSMutableArray alloc]init];
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

-(void)initArrays{
    [self.arrayType addObject:@"Empty"];
    [self.arrayType addObject:@"Work"];
    [self.arrayType addObject:@"Sports"];
    [self.arrayType addObject:@"Family"];

    [self.arrayProfession addObject:@"Empty"];
    [self.arrayProfession addObject:@"Designer"];
    [self.arrayProfession addObject:@"Developer"];
    [self.arrayProfession addObject:@"Inversor"];

    [self.arrayEvent addObject:@"Empty"];
    [self.arrayEvent addObject:@"MWC"];
    [self.arrayEvent addObject:@"Gtug"];
    [self.arrayEvent addObject:@"CeBit"];

}

#pragma mark - gets

-(NSMutableArray *)getTheArrayTypes{
    return self.arrayType;
}

-(NSMutableArray *)getTheArrayProfessions{
    return self.arrayProfession;
}

-(NSMutableArray *)getTheArrayEvents{
    return self.arrayEvent;
}

@end
