//
//  TubeStationDataHandler.h
//  TubeMapper
//
//  Created by Tim Searle on 19/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class TubeStation;

@interface TubeStationDataHandler : NSObject

- (instancetype)initWithDefaultLocation:(CLLocation *)location radius:(CLLocationDistance)radius;
- (void)tubeStationsForLocation:(CLLocation *)location completion:(void (^)(NSArray<TubeStation *> *stations))completion;

@end
