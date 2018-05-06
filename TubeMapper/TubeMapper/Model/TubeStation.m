//
//  TubeStation.m
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import "TubeStation.h"
#import "Facility.h"
#import "Arrival.h"

@interface TubeStation ()

@property (nonatomic,copy) NSString *identity;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSArray<Facility *> *facilities;
@property (nonatomic,copy) NSArray<Arrival *> *arrivals;

@end

@implementation TubeStation

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        self.name = dictionary[@"commonName"];
        self.identity = dictionary[@"id"];
        
        NSMutableArray<Facility *> *facilities = [NSMutableArray array];
        
        for (NSDictionary *additionalPropertyDictionary in dictionary[@"additionalProperties"]) {
            if ([additionalPropertyDictionary[@"category"] isEqualToString:@"Facility"]) {
                [facilities addObject:[[Facility alloc] initWithName:additionalPropertyDictionary[@"key"]]];
            }
        }
        
        self.facilities = facilities;
    }
    
    return self;
}

- (void)updateArrivals:(NSArray<Arrival *> *)arrivals {
    self.arrivals = arrivals;
}

@end
