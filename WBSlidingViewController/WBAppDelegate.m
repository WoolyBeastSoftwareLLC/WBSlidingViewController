//
//  WBAppDelegate.m
//  SideSwipeView
//
//  Created by Scott Chandler on 4/12/13.
//  Copyright (c) 2013 Wooly Beast Software. All rights reserved.
//

#import "WBAppDelegate.h"

#import "WBSlidingViewController.h"
#import "BackViewController.h"
#import "FrontViewController.h"

static UIViewController *TestViewController( UIColor *backgroundColor, NSString *text )
{
	UIViewController *controller = [[FrontViewController alloc] initWithBackgroundColor:backgroundColor label:text];
	return controller;
}

@implementation WBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
	
	// Create our sliding view controller that will eventually become the window's root view controller.
	WBSlidingViewController *viewController = [WBSlidingViewController new];
	
	// Create and add a front view controller
	UIViewController	*fvc = [[FrontViewController alloc] initWithBackgroundColor:[UIColor blueColor] label:@"Front"];
	viewController.frontViewController = fvc;

	// Create and add a back view controller. Make it the delegate of the sliding view controller in this example
	UIViewController<WBSlidingViewControllerDelegate>	*bvc = [[BackViewController alloc] initWithBackgroundColor:[UIColor greenColor] label:@"Back"];
	viewController.delegate = bvc;
	viewController.backViewController = bvc;
	
	// Size the back view
	const CGFloat kBackViewWidthAdjust = 44.0;
	CGRect rect = bvc.view.frame;
	rect.size.width = rect.size.width - kBackViewWidthAdjust;
	bvc.view.frame = rect;
	
	// Register the size of the sliding view's reveal amount. In this case, it is the view width minus 44.0 which corresponds to
	// the size we set the back view in the code above.
	viewController.backViewWidth = -kBackViewWidthAdjust;
	
	// Continue on with the set up and launch
	self.viewController = viewController;
	self.window.rootViewController = self.viewController;
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
