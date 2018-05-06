//
//  Arrival.h
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TubeStation;

@interface Arrival : NSObject

@property (nonatomic,assign,readonly) NSInteger timeToStation;
@property (nonatomic,strong,readonly) TubeStation *destination;
@property (nonatomic,copy,readonly) NSString *terminatingDestinationName;
@property (nonatomic,copy,readonly) NSString *lineName;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary station:(TubeStation *)station;

@end
