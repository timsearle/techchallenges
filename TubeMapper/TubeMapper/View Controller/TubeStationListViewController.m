//
//  ViewController.m
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import "TubeStationListViewController.h"
#import "TubeStation.h"
#import "FacilitiesTagCloudViewController.h"
#import "LiveArrivalsViewController.h"
#import "TubeStationHeaderView.h"
#import "TubeDetailTableViewCell.h"

typedef NS_ENUM(NSInteger, TubeStationRowEntry) {
    TubeStationRowEntryFacilities = 0,
    TubeStationRowEntryLiveArrivals = 1,
    TubeStationRowEntry_Count = 2
};

@interface TubeStationListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak) UIActivityIndicatorView *indicatorView;
@property (nonatomic,strong) NSArray<TubeStation *> *stations;
@property (nonatomic,strong) NSArray<FacilitiesTagCloudViewController *> *tagCloudViewControllers;
@property (nonatomic,strong) NSArray<LiveArrivalsViewController *> *liveArrivalsViewControllers;
@property (nonatomic,weak) UIRefreshControl *refreshControl;

@end

@implementation TubeStationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"app.title", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setLargeTitleDisplayMode:UINavigationItemLargeTitleDisplayModeAlways];
    
    self.tagCloudViewControllers = [NSArray array];
    
    [self loadStations];
}

- (void)loadStations {
    
    if ([self.delegate respondsToSelector:@selector(stationsForTubeStationListViewController:completion:)]) {
        
        __weak typeof (self) weakSelf = self;
        
        [self.delegate stationsForTubeStationListViewController:self completion:^(NSArray<TubeStation *> *stations) {
            [weakSelf displayStations:stations];
        }];
    }
}

- (void)displayStations:(NSArray<TubeStation *> *)stations {
    
    if (self.tableView == nil) {
        UITableView *tableView = [self createTableView];
        [self.view addSubview: tableView];
        tableView.frame = self.view.bounds;
        self.tableView = tableView;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
        [refreshControl addTarget:self action:@selector(loadStations) forControlEvents:UIControlEventValueChanged];
        
        self.refreshControl = refreshControl;
        
        self.tableView.refreshControl = refreshControl;
    }
    
    self.stations = stations;
    
    if (self.stations.count > 0) {
        
        if ([self.delegate respondsToSelector:@selector(tubeStationListViewController:tagCloudForStation:)] &&
            [self.delegate respondsToSelector:@selector(arrivalsViewControllerForTubeStationListViewController:forStation:)]) {
            
            NSMutableArray *tagClouds = [NSMutableArray arrayWithCapacity:self.stations.count];
            NSMutableArray *arrivalViewControllers = [NSMutableArray arrayWithCapacity:self.stations.count];
            
            for (TubeStation *station in stations) {
                
                LiveArrivalsViewController *arrivalViewController = [self.delegate arrivalsViewControllerForTubeStationListViewController:self forStation:station];
                [arrivalViewController.view layoutIfNeeded];
                [arrivalViewControllers addObject:arrivalViewController];
                
                FacilitiesTagCloudViewController *viewController = [self.delegate tubeStationListViewController:self tagCloudForStation:station];
                [viewController.view layoutIfNeeded];
                [tagClouds addObject: viewController];
            }
            
            self.liveArrivalsViewControllers = arrivalViewControllers;
            self.tagCloudViewControllers = tagClouds;
        }
    } else {
        self.liveArrivalsViewControllers = @[];
        self.tagCloudViewControllers = @[];
    }
    
    // Ensure that the tableView reload does not interrupt the refresh control animation
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [self.tableView reloadData];
    }];
    
    [self.tableView.refreshControl endRefreshing];
    [CATransaction commit];
    
    [self shouldDisplayLoadingIndicator:NO];
}

- (void)shouldDisplayLoadingIndicator:(BOOL)shouldDisplay {
    
    if (shouldDisplay) {
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
        [indicatorView startAnimating];
        indicatorView.center = self.view.center;
        [self.view addSubview:indicatorView];
        self.indicatorView = indicatorView;
    } else {
        [self.indicatorView removeFromSuperview];
    }
}

- (UITableView *)createTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [tableView registerClass:[TubeDetailTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TubeDetailTableViewCell class])];
    tableView.tableFooterView = [[UIView alloc] init];
    
    return tableView;
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDatasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TubeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TubeDetailTableViewCell class]) forIndexPath:indexPath];
    
    if (indexPath.row == TubeStationRowEntryFacilities) {
        FacilitiesTagCloudViewController *tagCloudViewController = [self.tagCloudViewControllers objectAtIndex: indexPath.section];
        if (tagCloudViewController.parentViewController == nil) {
            [self addChildViewController:tagCloudViewController];
        }
        
        [cell.contentView addSubview:tagCloudViewController.view];
        [tagCloudViewController didMoveToParentViewController:self];
        
    } else if (indexPath.row == TubeStationRowEntryLiveArrivals) {
        LiveArrivalsViewController *arrivalViewController = [self.liveArrivalsViewControllers objectAtIndex: indexPath.section];
        if (arrivalViewController.parentViewController == nil) {
            [self addChildViewController:arrivalViewController];
        }
        
        [cell.contentView addSubview:arrivalViewController.view];
        arrivalViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
        [arrivalViewController didMoveToParentViewController:self];
    }
    
    [cell setClipsToBounds:YES];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.stations.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.stations objectAtIndex:section] name];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TubeStationHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TubeStationHeaderView class]) owner:nil options:nil] objectAtIndex: 0];
    
    headerView.tubeStationLabel.text = [[self.stations objectAtIndex:section] name];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == TubeStationRowEntryFacilities) {
        return [self.tagCloudViewControllers[indexPath.section] calculatedHeight];
    } else if (indexPath.row == TubeStationRowEntryLiveArrivals) {
        return 120;
    }
    
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

@end
