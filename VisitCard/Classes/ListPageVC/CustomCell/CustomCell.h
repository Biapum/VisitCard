//
//  CustomCell.h
//  iCollina
//
//  Created by Valenti on 15/09/11.
//  Copyright 2011 Biapum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomCell : UITableViewCell {
    IBOutlet UILabel *nameLabel;
    IBOutlet UIImageView *image;
}

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UIImageView *image;
@end
