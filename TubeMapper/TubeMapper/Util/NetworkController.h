//
//  NetworkController.h
//  TubeMapper
//
//  Created by Tim Searle on 19/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkController : NSObject

- (instancetype)initWithBaseURL:(NSURL *)url defaultQuery:(NSArray<NSURLQueryItem *> *)queryItems;
- (void)loadDataAtPath:(NSURL *)path withQueryItems:(NSArray<NSURLQueryItem *> *)queryItems completion:(void (^)(NSData *data))completion;

@end
