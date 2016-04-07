//
//  AppDelegate.m
//  MatchMe
//
//  Created by Siyana Slavova on 2/22/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import "AppDelegate.h"
#import "WelcomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    
    if ([components.host isEqualToString:@"Level"]) {
        NSString *levelNumber = components.path;
        if ([levelNumber hasPrefix:@"/"]) {
            levelNumber = [levelNumber stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
        }
        
        if ([self.window.rootViewController isKindOfClass:[UINavigationController class]]) {
             UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
           
            NSLog(@"NAV root: %@", nav.topViewController);
             [nav popToRootViewControllerAnimated:NO];
            if ([nav.topViewController isKindOfClass:[WelcomeViewController class]]) {
                WelcomeViewController *welcomeViewController = (WelcomeViewController *)nav.topViewController;
                [welcomeViewController handleDeepLinkForLevel:levelNumber];
            }
            
        }
    }
    
    return YES;
}


@end
