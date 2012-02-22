//
//  CustomCell.m
//  iCollina
//
//  Created by Valenti on 15/09/11.
//  Copyright 2011 Biapum. All rights reserved.
//

#import "CustomCell.h"


@implementation CustomCell
@synthesize nameLabel;
@synthesize image;

-(void)dealloc{
    [super dealloc];
    //[nameLabel release];
    //[image release];
}
@end
