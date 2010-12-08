//
//  ParkedAppDelegate.h
//  Parked
//
//  Created by Christopher Baltzer on 10-12-07.
//  Copyright 2010 Christopher Baltzer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ParkedViewController;

@interface ParkedAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ParkedViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ParkedViewController *viewController;

@end

