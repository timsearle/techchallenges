//
//  Facility.h
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Facility : NSObject

@property (nonatomic,copy,readonly) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end
