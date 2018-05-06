//
//  TubeStation.h
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Facility;
@class Arrival;

@interface TubeStation : NSObject

@property (nonatomic,copy,readonly) NSString *identity;
@property (nonatomic,copy,readonly) NSString *name;
@property (nonatomic,copy,readonly) NSArray<Facility *> *facilities;
@property (nonatomic,copy,readonly) NSArray<Arrival *> *arrivals;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (void)updateArrivals:(NSArray<Arrival *> *)arrivals;

@end
