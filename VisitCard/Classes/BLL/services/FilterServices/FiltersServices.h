//
//  FiltersServices.h
//  VisitCard
//
//  Created by Valentí on 13/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FiltersServices : NSObject{
    NSMutableArray *arrayType;
    NSMutableArray *arrayEvent;
    NSMutableArray *arrayProfession;
}
@property (nonatomic,retain) NSMutableArray *arrayType;
@property (nonatomic,retain) NSMutableArray *arrayEvent;
@property (nonatomic,retain) NSMutableArray *arrayProfession;

+(FiltersServices *)instance;

-(void)initArrays;
-(NSMutableArray *)getTheArrayTypes;
-(NSMutableArray *)getTheArrayProfessions;
-(NSMutableArray *)getTheArrayEvents;
@end
