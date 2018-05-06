//
//  Arrival.m
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import "Arrival.h"

@interface Arrival ()

@property (nonatomic,assign) NSInteger timeToStation;
@property (nonatomic,strong) TubeStation *targetContextStation;
@property (nonatomic,copy) NSString *terminatingDestinationName;
@property (nonatomic,copy) NSString *lineName;

@end

@implementation Arrival

- (instancetype)initWithDictionary:(NSDictionary *)dictionary station:(TubeStation *)station {
    self = [super init];
    
    if (self) {
        self.targetContextStation = station;
        self.terminatingDestinationName = dictionary[@"towards"];
        self.lineName = dictionary[@"lineName"];
        self.timeToStation = [dictionary[@"timeToStation"] intValue];
    }
    
    return self;
}



@end
