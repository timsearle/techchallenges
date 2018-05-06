//
//  LocationMonitor.m
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import "LocationMonitor.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationMonitor () <CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) NSMutableDictionary *updateHandlers;

@end

@implementation LocationMonitor

+ (instancetype)shared {
    static LocationMonitor *locationMonitor = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationMonitor = [[self alloc] init];
    });
    
    return locationMonitor;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.updateHandlers = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)startLocationMonitoringIfPossible {
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
    } else {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (void)stopAllMonitoring {
    [self.locationManager stopUpdatingLocation];
    [self.updateHandlers removeAllObjects];
}

- (NSUUID *)registerForLocationUpdates:(void (^)(CLLocation *))updateHandler {
    
    NSUUID *uniqueId = [NSUUID UUID];
    self.updateHandlers[uniqueId] = updateHandler;
    
    if (self.updateHandlers.count == 1) {
        [self startLocationMonitoringIfPossible];
    }
    
    return uniqueId;
}

- (BOOL)unregister:(NSUUID *)uuid {
    
    if (self.updateHandlers[uuid] != nil) {
        [self.updateHandlers removeObjectForKey:uuid];
        
        if (self.updateHandlers.count == 0) {
            [self.locationManager stopUpdatingLocation];
        }
        
        return YES;
    }
    
    return NO;
}

#pragma mark - CLLocationManagerUpdate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *first = [locations firstObject];
    
    if (first != nil) {
        if (first.horizontalAccuracy <= kCLLocationAccuracyHundredMeters) {
            for (LocationUpdateHandler updateHandler in [self.updateHandlers allValues]) {
                updateHandler(first);
            }
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [manager startUpdatingLocation];
    } else if (status != kCLAuthorizationStatusNotDetermined) {
        for (LocationUpdateHandler updateHandler in [self.updateHandlers allValues]) {
            updateHandler(nil);
        }
    }
}

@end
