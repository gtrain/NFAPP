//
//  AppDelegate.m
//  NFSYSUNEWS
//
//  Created by yzq on 13-5-15.
//  Copyright (c) 2013年 yzq. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "IndexViewController.h"

NSString* const kBaseURL = @"172.16.21.21/json/";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.engine=[[RESTfulEngine alloc] initWithHostName:kBaseURL];       //MKNetWork 封装类
    
    
    self.leftController=[[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
    RightViewController *rightViewController=[[RightViewController alloc] initWithNibName:@"RightViewController" bundle:nil];
    
    IndexViewController *indexViewController=[[IndexViewController alloc] initWithNibName:@"IndexViewController" bundle:nil];
    self.centerViewController=[[UINavigationController alloc] initWithRootViewController:indexViewController];
    _centerViewController.navigationBarHidden=YES;
    
    IIViewDeckController *deckController=[[IIViewDeckController alloc] initWithCenterViewController:_centerViewController
                                                                                 leftViewController:_leftController
                                                                                rightViewController:rightViewController];
    //因为设置了rightVC,所以要设置rightSize
    deckController.leftSize = 106;
    deckController.rightSize = 106;
    deckController.openSlideAnimationDuration = 0.15f;
    deckController.closeSlideAnimationDuration = 0.1f;
    
    
    self.window.rootViewController=deckController;
    [self.window makeKeyAndVisible];
    return YES;
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
