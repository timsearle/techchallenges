//
//  LiveArrivalsDataHandler.h
//  TubeMapper
//
//  Created by Tim Searle on 19/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TubeStation;
@class Arrival;

@interface LiveArrivalsDataHandler : NSObject

- (void)loadArrivalsFor:(TubeStation *)station completion:(void (^)(NSArray<Arrival *> *))completion;

@end
