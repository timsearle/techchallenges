//
//  AppCoordinator.m
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import "AppCoordinator.h"
#import "TubeCoordinator.h"

@implementation AppCoordinator

- (void)start {
    
    TubeCoordinator *tubeCoordinator = [[TubeCoordinator alloc] initWithNavigationController: self.navigationController];
    [self addChildCoordinator: tubeCoordinator];
    [tubeCoordinator start];    
}

@end
