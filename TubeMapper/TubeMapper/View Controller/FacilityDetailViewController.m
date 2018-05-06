//
//  FacilityDetailViewController.m
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import "FacilityDetailViewController.h"
#import "Facility.h"

@interface FacilityDetailViewController ()

@property (nonatomic,strong) Facility *facility;

@end

@implementation FacilityDetailViewController

- (instancetype)initWithFacility:(Facility *)facility
{
    self = [super init];
    
    if (self) {
        self.facility = facility;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.facility.name;
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
