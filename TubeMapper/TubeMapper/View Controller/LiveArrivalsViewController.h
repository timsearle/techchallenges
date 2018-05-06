//
//  LiveArrivalsViewController.h
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Arrival;

@interface LiveArrivalsViewController : UIViewController

- (void)updateArrivals:(NSArray<Arrival *> *)arrivals;

@end
