//
//  Coordinator.h
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Coordinator : NSObject

@property (nonatomic,strong,readonly) UINavigationController *navigationController;
@property (nonatomic,weak,readonly) Coordinator *parent;

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;
- (void)addChildCoordinator:(Coordinator *)coordinator;

@end
