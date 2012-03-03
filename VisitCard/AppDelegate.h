//
//  AppDelegate.h
//  VisitCard
//
//  Created by Valentí on 11/02/12.
//  Copyright (c) 2012 Biapum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<AVFoundation/AVAudioPlayer.h>

@class MainPageViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    //Audio
    AVAudioPlayer* passCard;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navContr;
@property (nonatomic, retain) MainPageViewController *mainPageVC;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//Audio
@property (nonatomic, retain) AVAudioPlayer* passCard;

- (void)saveContext;
- (void)initSound;
- (NSURL *)applicationDocumentsDirectory;

@end
