//
//  LiveArrivalsCoordinator.h
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import "Coordinator.h"

@class LiveArrivalsViewController;
@class TubeStation;

@interface LiveArrivalsCoordinator : Coordinator

- (LiveArrivalsViewController *)liveArrivalsViewControllerForStation:(TubeStation *)station;

@end
