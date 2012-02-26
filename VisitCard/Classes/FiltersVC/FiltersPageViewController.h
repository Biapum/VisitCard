//
//  FiltersPageViewController.h
//  VisitCard
//
//  Created by Valentí on 12/02/12.
//  Copyright (c) 2012 Biapum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactEntity.h"
#import "StepView.h"

typedef enum {
    pickerTypeType      = 0,
    pickerTypeEvent    = 1,
    pickerTypeProfession  = 2
} PickerType;

@interface FiltersPageViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    ContactEntity *contactNew;
    
    PickerType pickerType; 
	NSMutableArray *arrayPicker;
    
    NSMutableArray *arrayType;
    NSMutableArray *arrayProfession;
    NSMutableArray *arrayEvent;
    
    UITextField *textFieldType;
    UITextField *textFieldProfession;
    UITextField *textFieldEvent;
    
	IBOutlet UIPickerView *myPickerView;
    UILabel *labelName;
    
    //Step
    StepView *stepView;
}
@property (nonatomic, retain) ContactEntity *contactNew;
@property (nonatomic, retain) IBOutlet UIPickerView *myPickerView;
@property (nonatomic, assign) PickerType pickerType;

@property (nonatomic, retain) NSMutableArray *arrayPicker;
@property (nonatomic, retain) NSMutableArray *arrayType;
@property (nonatomic, retain) NSMutableArray *arrayProfession;
@property (nonatomic, retain) NSMutableArray *arrayEvent;

@property (nonatomic, retain) IBOutlet UITextField *textFieldType;
@property (nonatomic, retain) IBOutlet UITextField *textFieldProfession;
@property (nonatomic, retain) IBOutlet UITextField *textFieldEvent;
@property (nonatomic, retain) IBOutlet UILabel *labelName;

//Step
@property (nonatomic,retain) StepView *stepView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil dic:(NSMutableDictionary*)dic_;
-(IBAction)pushType:(id)sender;
-(IBAction)pushEvent:(id)sender;
-(IBAction)pushProfession:(id)sender;

-(IBAction)addType:(id)sender;
-(IBAction)addEvent:(id)sender;
-(IBAction)addProfession:(id)sender;

- (IBAction)saveCard:(id)sender;

@end
