//
//  ViewController.h
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TubeStationListViewController;
@class TubeStation;
@class FacilitiesTagCloudViewController;
@class LiveArrivalsViewController;

@protocol TubeStationListViewControllerDelegate <NSObject>

- (void)stationsForTubeStationListViewController:(TubeStationListViewController *)tubeStationListViewController completion:(void (^) (NSArray<TubeStation *> *stations))completion;
- (LiveArrivalsViewController *)arrivalsViewControllerForTubeStationListViewController:(TubeStationListViewController *)tubeStationListViewController forStation:(TubeStation *)station;

- (FacilitiesTagCloudViewController *)tubeStationListViewController:(TubeStationListViewController *)tubeStationListViewController tagCloudForStation:(TubeStation *)station;

@end

@interface TubeStationListViewController : UIViewController

@property (nonatomic,weak) id<TubeStationListViewControllerDelegate>delegate;

- (void)shouldDisplayLoadingIndicator:(BOOL)shouldDisplay;

@end

