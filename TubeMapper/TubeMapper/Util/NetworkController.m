//
//  NetworkController.m
//  TubeMapper
//
//  Created by Tim Searle on 19/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import "NetworkController.h"

@interface NetworkController ()

@property (nonatomic,strong) NSArray<NSURLQueryItem *> *defaultQueryItems;
@property (nonatomic,strong) NSURL *baseURL;
@property (nonatomic,strong) NSURLSession *session;

@end

@implementation NetworkController

- (instancetype)initWithBaseURL:(NSURL *)url defaultQuery:(NSArray<NSURLQueryItem *> *)queryItems
{
    self = [super init];
    
    if (self) {
        self.baseURL = url;
        self.defaultQueryItems = queryItems;
        self.session = [NSURLSession sharedSession];
    }
    
    return self;
}

- (void)loadDataAtPath:(NSURL *)pathURL withQueryItems:(NSArray<NSURLQueryItem *> *)queryItems completion:(void (^)(NSData *data))completion {
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:self.baseURL resolvingAgainstBaseURL:NO];
    components.queryItems = [self.defaultQueryItems arrayByAddingObjectsFromArray:queryItems];
    components.path = pathURL.path;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:components.URL];
    
    [[self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // TODO: We need to propagate any NSURLSessions errors back up here
        // Interestingly the TfL API doesn't seem to respect HTTP and passes back 200s even in the case of an actual 500
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(data);
        });
    }] resume];
}

@end
