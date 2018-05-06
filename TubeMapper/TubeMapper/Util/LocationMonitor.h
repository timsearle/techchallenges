//
//  LocationMonitor.h
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;

typedef void (^LocationUpdateHandler) (CLLocation* location);

@interface LocationMonitor : NSObject

+ (instancetype)shared;

- (NSUUID *)registerForLocationUpdates:(LocationUpdateHandler)updateHandler;
- (BOOL)unregister:(NSUUID *)uuid;
- (void)stopAllMonitoring;

@end
