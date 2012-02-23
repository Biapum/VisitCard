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
    contact.contactId = [self getCurrentId];
    [self.arrayContacts addObject:contact];
}

#pragma mark - gets

-(NSString*)getCurrentId{
    NSString *newId;
    if([self.arrayContacts count]>0){
        newId =[[self.arrayContacts lastObject] contactId];
        newId = [NSString stringWithFormat:@"%i", [newId intValue]+1];
    }else{
        newId = @"0";
    }
    return newId;
}

-(NSMutableArray *)getTheArrayContacts{
    return self.arrayContacts;
}

-(ContactEntity *)getContact:(NSString *)contactId{
    for (ContactEntity *c in self.arrayContacts) {
        if([contactId isEqualToString:c.contactId]){
            return c;
        }
    }
    return nil;
}

#pragma mark-
#pragma mark SaveData

-(void)saveData{
    NSFileManager *filemgr;
    NSData *databuffer;
    NSString *dataFile;
    NSString *docsDir;
    NSArray *dirPaths;
    
    //Save data
    filemgr = [NSFileManager defaultManager];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    dataFile = [docsDir stringByAppendingPathComponent: @"datafile"];
    
    databuffer = [NSKeyedArchiver archivedDataWithRootObject:self.arrayContacts];
    
    [filemgr createFileAtPath: dataFile contents: databuffer attributes:nil];
    
    //[filemgr release];
}

-(void)loadData{
    NSFileManager *filemgr;
    NSString *dataFile;
    NSString *docsDir;
    NSArray *dirPaths;
    
    filemgr = [NSFileManager defaultManager];
    
    // Identify the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the data file
    dataFile = [docsDir stringByAppendingPathComponent: @"datafile"];
    
    // Check if the file already exists
    if ([filemgr fileExistsAtPath: dataFile])
    {
        // Read file contents and display in textBox
        NSData *databuffer;
        databuffer = [filemgr contentsAtPath: dataFile];
        
        NSMutableArray* datastring = [NSKeyedUnarchiver unarchiveObjectWithData:databuffer];       
        self.arrayContacts = datastring;
    }
    
    //If is the first time we open de app
    //[filemgr release];
}

@end
