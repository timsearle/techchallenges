//
//  TubeCoordinator.m
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import "TubeCoordinator.h"
#import "TubeStationListViewController.h"
#import "FacilitiesTagCloudViewController.h"
#import "TubeStation.h"
#import "Facility.h"
#import "LiveArrivalsCoordinator.h"
#import "FacilityDetailViewController.h"
#import "LocationMonitor.h"
#import "TubeStationDataHandler.h"

@interface TubeCoordinator () <TubeStationListViewControllerDelegate,FacilitiesTagCloudViewControllerDelegate>

@property (nonatomic,strong) TubeStationDataHandler *tubeDataHandler;

@end

@implementation TubeCoordinator

- (void)start {
    self.tubeDataHandler = [[TubeStationDataHandler alloc] initWithDefaultLocation:[[CLLocation alloc] initWithLatitude:51.5081124
                                                                                                              longitude:-0.078138]
                                                                            radius:1000];
    
    TubeStationListViewController *tubeStationListViewController = [[TubeStationListViewController alloc] init];
    tubeStationListViewController.delegate = self;
    [tubeStationListViewController shouldDisplayLoadingIndicator:YES];
    
    [self.navigationController pushViewController: tubeStationListViewController animated: true];
}

#pragma mark - TubeStationListViewControllerDelegate

- (FacilitiesTagCloudViewController *)tubeStationListViewController:(TubeStationListViewController *)tubeStationListViewController tagCloudForStation:(TubeStation *)station {
    
    FacilitiesTagCloudViewController *facilitiesTagCloudViewController = [[FacilitiesTagCloudViewController alloc] initWithFacilities:station.facilities];
    facilitiesTagCloudViewController.delegate = self;
    
    return facilitiesTagCloudViewController;
}

- (void)stationsForTubeStationListViewController:(TubeStationListViewController *)tubeStationListViewController completion:(void (^)(NSArray<TubeStation *> *))completion {
    
    [[LocationMonitor shared] registerForLocationUpdates:^(CLLocation *location) {
        [[LocationMonitor shared] stopAllMonitoring];
        
        [self.tubeDataHandler tubeStationsForLocation:location completion:^(NSArray<TubeStation *> *stations) {
            completion(stations);
        }];
    }];
}

- (LiveArrivalsViewController *)arrivalsViewControllerForTubeStationListViewController:(TubeStationListViewController *)tubeStationListViewController forStation:(TubeStation *)station {
    
    LiveArrivalsCoordinator *arrivalsCoordinator = [[LiveArrivalsCoordinator alloc] initWithNavigationController: [[UINavigationController alloc] init]];
    [self addChildCoordinator:arrivalsCoordinator];
    
    return [arrivalsCoordinator liveArrivalsViewControllerForStation:station];
}

#pragma mark - FacilitiesTagCloudViewControllerDelegate

- (void)facilitiesTagCloudViewController:(FacilitiesTagCloudViewController *)tagCloudViewController didSelectFacility:(Facility *)facility {
    
    FacilityDetailViewController *detailViewController = [[FacilityDetailViewController alloc] initWithFacility:facility];
    [self.navigationController pushViewController:detailViewController animated:true];
}

@end
