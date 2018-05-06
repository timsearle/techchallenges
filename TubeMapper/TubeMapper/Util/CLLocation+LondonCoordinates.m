//
//  CLLocation+LondonCoordinates.m
//  TubeMapper
//
//  Created by Tim Searle on 19/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import "CLLocation+LondonCoordinates.h"
#import <CoreLocation/CoreLocation.h>

@implementation CLLocation (LondonCoordinates)

- (BOOL)ts_isInLondon {
    
    CLLocationDegrees minLon = -0.489;
    CLLocationDegrees minLat = 51.28;
    CLLocationDegrees maxLon = 0.236;
    CLLocationDegrees maxLat = 51.686;
    
    BOOL validLat = self.coordinate.latitude >= minLat && self.coordinate.latitude <= maxLat;
    BOOL validLon = self.coordinate.longitude >= minLon && self.coordinate.longitude <= maxLon;
    
    return validLat && validLon;
}

@end
