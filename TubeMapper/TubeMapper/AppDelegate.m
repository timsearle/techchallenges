//
//  AppDelegate.m
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import "AppDelegate.h"
#import "AppCoordinator.h"

@interface AppDelegate ()

@property (nonatomic,strong) AppCoordinator *appCoordinator;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSAssert([self.window.rootViewController class] == [UINavigationController class], @"Expecting a UINavigationController as the rootViewController of UIWindow");
    
    UINavigationController *rootViewController = (UINavigationController *)self.window.rootViewController;
    self.appCoordinator = [[AppCoordinator alloc] initWithNavigationController:rootViewController];
    [self.appCoordinator start];
    
    return YES;
}

@end
