//
//  ContactEntity.m
//  VisitCard
//
//  Created by Valentí on 13/02/12.
//  Copyright (c) 2012 Biapum. All rights reserved.
//

#import "ContactEntity.h"

@implementation ContactEntity
@synthesize contactId,contactName,contactPhone,contactEmail,contactWeb;
@synthesize contactTwitter,contactComent,contactCardFront,contactCardBack;
@synthesize contactType,contactEvent,contactProfession;

-(void)dealloc{
    [super dealloc];
    [contactId release];
    [contactName release];
    [contactPhone release];
    [contactEmail release];
    [contactWeb release];
    [contactTwitter release];
    [contactComent release];
    [contactCardFront release];
    [contactCardBack release];
    [contactType release];
    [contactEvent release];
    [contactProfession release];
}

- (id)initWithDictionary:(NSMutableDictionary *)dictionary {
    if ((self = [super init])) {
        [self parseContact:dictionary];
    }
    
    return self;
}

-(void)parseContact:(NSMutableDictionary *)feed {
    
    if([[feed allKeys] count] == 0) return;
    
	NSEnumerator *enumerator = [feed keyEnumerator];
	id aKey = nil;
	
	while ( (aKey = [enumerator nextObject]) != nil) {
		NSString *value = (NSString *)[feed objectForKey:aKey];
        if ([aKey isEqualToString:@"name"])
        {
            self.contactName = [self setValue:value forKey:aKey];
        }
        if ([aKey isEqualToString:@"id"])
        {
            self.contactId = [self setValue:value forKey:aKey];
        }
        if ([aKey isEqualToString:@"contactPhone"])
        {
            self.contactPhone = [self setValue:value forKey:aKey];
        }
        if ([aKey isEqualToString:@"email"])
        {
            self.contactEmail = [self setValue:value forKey:aKey];
        }
        if ([aKey isEqualToString:@"web"])
        {
            self.contactWeb = [self setValue:value forKey:aKey];
        }
        if ([aKey isEqualToString:@"twitter"])
        {
            self.contactTwitter = [self setValue:value forKey:aKey];
        }
        //etc..
	}
}


- (NSString *)setValue:(NSString*)value forKey:(NSString*)key {
    if(![[NSString stringWithFormat:@"%@", value] isEqualToString:@"<null>"]) 
        return [NSString stringWithFormat:@"%@",value];
    else
        return @"";
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.contactName forKey:@"name"];
    [encoder encodeObject:self.contactId forKey:@"id"];
    [encoder encodeObject:self.contactPhone forKey:@"contactPhone"];
    [encoder encodeObject:self.contactEmail forKey:@"email"];
    [encoder encodeObject:self.contactWeb forKey:@"web"];
    [encoder encodeObject:self.contactTwitter forKey:@"twitter"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if( self != nil )
    {
        //decode properties, other class vars
        self.contactName = [decoder decodeObjectForKey:@"name"];
        self.contactId = [decoder decodeObjectForKey:@"id"];
        self.contactPhone = [decoder decodeObjectForKey:@"contactPhone"];
        self.contactEmail = [decoder decodeObjectForKey:@"email"];
        self.contactWeb = [decoder decodeObjectForKey:@"web"];
        self.contactTwitter = [decoder decodeObjectForKey:@"twitter"];
    }
    return self;
}


@end
