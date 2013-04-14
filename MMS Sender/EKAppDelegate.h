//
//  EKAppDelegate.h
//  MMS Sender
//
//  Created by edzio27 on 18.03.2013.
//  Copyright (c) 2013 edzio27. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EKViewController;

@interface EKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) EKViewController *viewController;
@property (nonatomic, strong) UINavigationController *navigationController;

@end
