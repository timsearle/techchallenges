//
//  TubeStationDataHandler.m
//  TubeMapper
//
//  Created by Tim Searle on 19/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import "TubeStationDataHandler.h"
#import "TubeStation.h"
#import "NetworkController.h"
#import "CLLocation+LondonCoordinates.h"
#import "Constants.h"

@interface TubeStationDataHandler ()

@property (nonatomic,strong) CLLocation *fallbackLocation;
@property (nonatomic,assign) CLLocationDistance radius;
@property (nonatomic,strong) NetworkController *networkController;

@end

@implementation TubeStationDataHandler

- (instancetype)initWithDefaultLocation:(CLLocation *)defaultLocation radius:(CLLocationDistance)radius {
    self = [super init];
    
    if (self) {
        NSURL *baseURL = [NSURL URLWithString:TFL_BASE_URL];
        NSArray<NSURLQueryItem *> *queries = @[[NSURLQueryItem queryItemWithName:@"app_key" value:TFL_APP_KEY],
                                               [NSURLQueryItem queryItemWithName:@"app_id" value:TFL_APP_ID]];
        
        self.fallbackLocation = defaultLocation;
        self.radius = radius;
        self.networkController = [[NetworkController alloc] initWithBaseURL:baseURL defaultQuery:queries];
    }
    
    return self;
}

- (void)tubeStationsForLocation:(CLLocation *)location completion:(void (^)(NSArray<TubeStation *> *))completion {
    
    CLLocation *queryLocation = (location != nil && [location ts_isInLondon]) ? location : self.fallbackLocation;
    
    NSURL *url = [NSURL URLWithString:@"/StopPoint"];
    
    NSArray<NSURLQueryItem *> *queries = @[[NSURLQueryItem queryItemWithName:@"lat" value:[NSString stringWithFormat:@"%f", queryLocation.coordinate.latitude]],
                                           [NSURLQueryItem queryItemWithName:@"lon" value:[NSString stringWithFormat:@"%f", queryLocation.coordinate.longitude]],
                                           [NSURLQueryItem queryItemWithName:@"radius" value:[NSString stringWithFormat:@"%ld", (long)[@(self.radius) integerValue]]],
                                           [NSURLQueryItem queryItemWithName:@"stopTypes" value:@"NaptanMetroStation"]];
    
    [self.networkController loadDataAtPath:url withQueryItems:queries completion:^(NSData *data) {
        
        NSError *jsonSerializationError = nil;
        
        if (data != nil) {
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonSerializationError];
            
            if (jsonSerializationError != nil) {
                NSLog(@"%@", jsonSerializationError);
                completion(@[]);
            } else {
                
                NSArray *stopPoints = jsonDictionary[@"stopPoints"];
                NSMutableArray<TubeStation *> *stations = [NSMutableArray array];
                
                for (NSDictionary *dictionary in stopPoints) {
                    [stations addObject:[[TubeStation alloc] initWithDictionary:dictionary]];
                }
                
                completion(stations);
            }
        } else {
            completion(@[]);
        }
    }];
}

@end
