//
//  LiveArrivalsDataHandler.m
//  TubeMapper
//
//  Created by Tim Searle on 19/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import "LiveArrivalsDataHandler.h"
#import "NetworkController.h"
#import "TubeStation.h"
#import "Arrival.h"
#import "Constants.h"

@interface LiveArrivalsDataHandler ()

@property (nonatomic,strong) NetworkController *networkController;

@end

@implementation LiveArrivalsDataHandler

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSURL *baseURL = [NSURL URLWithString:TFL_BASE_URL];
        NSArray<NSURLQueryItem *> *queries = @[[NSURLQueryItem queryItemWithName:@"app_key" value:TFL_APP_KEY],
                                               [NSURLQueryItem queryItemWithName:@"app_id" value:TFL_APP_ID]];
        
        self.networkController = [[NetworkController alloc] initWithBaseURL:baseURL defaultQuery:queries];
    }
    return self;
}

- (void)loadArrivalsFor:(TubeStation *)station completion:(void (^)(NSArray<Arrival *> *))completion {
    
    NSString *path = [NSString stringWithFormat:@"/StopPoint/%@/Arrivals", station.identity];
    NSURL *url = [NSURL URLWithString:path];
    
    [self.networkController loadDataAtPath:url withQueryItems:nil completion:^(NSData *data) {
        
        NSError *jsonSerializationError = nil;
        
        id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonSerializationError];
        
        if (jsonSerializationError != nil || [json isKindOfClass:[NSDictionary class]] ) {
            NSLog(@"%@", jsonSerializationError);
            completion(@[]);
        } else {
            NSMutableArray<Arrival *> *arrivals = [NSMutableArray array];
            
            NSArray *jsonArray = (NSArray *)json;
            
            for (NSDictionary *arrivalDictionary in jsonArray) {
                if ([arrivalDictionary[@"direction"] isEqualToString:@"inbound"]) {
                    [arrivals addObject:[[Arrival alloc] initWithDictionary: arrivalDictionary station:station]];
                }
            }
            
            [station updateArrivals:arrivals];
            
            completion(arrivals);
        }
    }];
}

@end
