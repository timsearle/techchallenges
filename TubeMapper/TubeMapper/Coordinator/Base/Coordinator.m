//
//  Coordinator.m
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import "Coordinator.h"

@interface Coordinator ()

@property (nonatomic,strong) UINavigationController *navigationController;
@property (nonatomic,strong) NSMutableArray<Coordinator *> *childCoordinators;
@property (nonatomic,weak) Coordinator *parent;

@end

@implementation Coordinator

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController {
    self = [super init];
    
    if (self) {
        self.navigationController = navigationController;
        self.childCoordinators = [NSMutableArray array];
    }
    
    return self;
}

- (void)addChildCoordinator:(Coordinator *)coordinator {
    [self.childCoordinators addObject:coordinator];
    coordinator.parent = self;
}

@end
