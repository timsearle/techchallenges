//
//  FacilitiesTagCloudViewController.h
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Facility;
@class FacilitiesTagCloudViewController;

@protocol FacilitiesTagCloudViewControllerDelegate<NSObject>

- (void)facilitiesTagCloudViewController:(FacilitiesTagCloudViewController *)tagCloudViewController didSelectFacility:(Facility *)facility;

@end

@interface FacilitiesTagCloudViewController : UIViewController

@property (nonatomic,weak) id<FacilitiesTagCloudViewControllerDelegate>delegate;

- (instancetype)initWithFacilities:(NSArray<Facility *> *)facilities;
- (CGFloat)calculatedHeight;

@end
