//
//  ContactEntity.h
//  VisitCard
//
//  Created by Valentí on 13/02/12.
//  Copyright (c) 2012 Biapum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactEntity : NSObject
{
    NSString *contactId;
    NSString *contactName;
    NSString *contactPhone;
    NSString *contactEmail;
    NSString *contactWeb;
    NSString *contactTwitter;
    NSString *contactComent;
    UIImage  *contactCardFront;
    UIImage  *contactCardBack;
    NSString *contactType;
    NSString *contactEvent;
    NSString *contactProfession;
}

@property (nonatomic,retain) NSString *contactId;
@property (nonatomic,retain) NSString *contactName;
@property (nonatomic,retain) NSString *contactPhone;
@property (nonatomic,retain) NSString *contactEmail;
@property (nonatomic,retain) NSString *contactWeb;
@property (nonatomic,retain) NSString *contactTwitter;
@property (nonatomic,retain) NSString *contactComent;
@property (nonatomic,retain) UIImage *contactCardFront;
@property (nonatomic,retain) UIImage *contactCardBack;
@property (nonatomic,retain) NSString *contactType;
@property (nonatomic,retain) NSString *contactEvent;
@property (nonatomic,retain) NSString *contactProfession;

- (id)initWithDictionary:(NSMutableDictionary *)dictionary;
- (void)parseContact:(NSMutableDictionary *)feed;

- (NSString *)setValue:(NSString*)value forKey:(NSString*)key;


@end
