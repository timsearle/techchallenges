//
//  Facility.m
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import "Facility.h"

@interface Facility ()

@property (nonatomic,copy) NSString *name;

@end

@implementation Facility

- (instancetype)initWithName:(NSString *)name {
    
    self = [super init];
    
    if (self) {
        self.name = name;
    }
    
    return self;
}

@end
