//
//  LiveArrivalsCoordinator.m
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import "LiveArrivalsCoordinator.h"
#import "LiveArrivalsViewController.h"
#import "Arrival.h"
#import "TubeStation.h"
#import "LiveArrivalsDataHandler.h"

@interface WeakStationArrivalsHandler: NSObject

@property (nonatomic,weak) TubeStation *station;
@property (nonatomic,weak) LiveArrivalsViewController *controller;

- (instancetype)initWithStation:(TubeStation *)station controller:(LiveArrivalsViewController *)controller;

@end

@implementation WeakStationArrivalsHandler

- (instancetype)initWithStation:(TubeStation *)station controller:(LiveArrivalsViewController *)controller {
    self = [super init];
    
    if (self) {
        self.station = station;
        self.controller = controller;
    }
    
    return self;
}

@end

@interface LiveArrivalsCoordinator ()

@property (nonatomic,strong) LiveArrivalsDataHandler *dataHandler;
@property (nonatomic,strong) NSMutableArray<WeakStationArrivalsHandler *> *liveArrivalsForUpdate;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation LiveArrivalsCoordinator

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController {
    self = [super initWithNavigationController:navigationController];
    self.liveArrivalsForUpdate = [NSMutableArray array];
    
    return self;
}

- (LiveArrivalsViewController *)liveArrivalsViewControllerForStation:(TubeStation *)station {
    LiveArrivalsViewController *liveArrivalsViewController = [[LiveArrivalsViewController alloc] init];
    
    [self updateArrivalsForStation:station onArrivalsController:liveArrivalsViewController];
    [self scheduleUpdatesForStation:station onArrivalsController:liveArrivalsViewController];
    
    return liveArrivalsViewController;
}

- (void)updateArrivalsForStation:(TubeStation *)station onArrivalsController:(LiveArrivalsViewController *)arrivalsViewController {
    
    if (self.dataHandler == nil) {
        self.dataHandler = [[LiveArrivalsDataHandler alloc] init];
    }
    
    [self.dataHandler loadArrivalsFor:station completion:^(NSArray<Arrival *> *arrivals) {
        [arrivalsViewController updateArrivals:arrivals];
    }];
}

- (void)scheduleUpdatesForStation:(TubeStation *)station onArrivalsController:(LiveArrivalsViewController *)arrivalsViewController {
    [self.liveArrivalsForUpdate addObject:[[WeakStationArrivalsHandler alloc] initWithStation:station
                                                                                   controller:arrivalsViewController]];
    if (self.timer == nil) {
        
        __weak typeof(self) weakSelf = self;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:30 repeats:true block:^(NSTimer * _Nonnull timer) {
            [weakSelf updateArrivalsForStation:station onArrivalsController:arrivalsViewController];
        }];
    }
}

@end
