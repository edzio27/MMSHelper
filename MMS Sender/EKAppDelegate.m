//
//  EKAppDelegate.m
//  MMS Sender
//
//  Created by edzio27 on 18.03.2013.
//  Copyright (c) 2013 edzio27. All rights reserved.
//

#import "EKAppDelegate.h"
#import "TakePhotoViewController.h"
#import "EKViewController.h"
#import "EKMMSSenderViewController.h"

@implementation EKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[EKViewController alloc] initWithNibName:@"EKViewController_iPhone" bundle:nil];
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    } else {
        self.viewController = [[EKViewController alloc] initWithNibName:@"EKViewController_iPad" bundle:nil];
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    }
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)transitionToCamera {
    TakePhotoViewController *camera = [[TakePhotoViewController alloc] initWithNibName:@"TakePhotoViewController" bundle:nil];
    [camera.view setBackgroundColor:[UIColor blackColor]];
    
    [UIView transitionFromView:self.window.rootViewController.view
                        toView:camera.view
                      duration:0.65f
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    completion:^(BOOL finished){
                        self.window.rootViewController = camera;
                    }];
}

-(void) transitionToTabs {
    UIViewController *controller = [self.navigationController.viewControllers objectAtIndex:0];
    [UIView transitionFromView:self.window.rootViewController.view
                        toView:controller.view
                      duration:0.65f
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    completion:^(BOOL finished){
                        self.window.rootViewController = [self.navigationController.viewControllers objectAtIndex:0];
                    }];
}

-(void) transitionToTabsAndOpenMMS:(NSData *)data {
    UIViewController *controller = [self.navigationController.viewControllers objectAtIndex:0];
    [UIView transitionFromView:self.window.rootViewController.view
                        toView:controller.view
                      duration:0.65f
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    completion:^(BOOL finished){
                        EKMMSSenderViewController *mms = [[EKMMSSenderViewController alloc] initWithNibName:@"EKMMSSenderViewController" bundle:nil imageToSemd:data];
                        [self.navigationController pushViewController:mms animated:NO];
                        self.window.rootViewController = self.navigationController;
                    }];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
