//
//  CLLocation+LondonCoordinates.h
//  TubeMapper
//
//  Created by Tim Searle on 19/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (LondonCoordinates)

- (BOOL)ts_isInLondon;

@end
