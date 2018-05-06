//
//  LiveArrivalsViewController.m
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import "LiveArrivalsViewController.h"
#import "LiveArrivalTableViewCell.h"
#import "Arrival.h"
#import "TubeStation.h"
#import "LiveArrivalsHeaderView.h"

@interface LiveArrivalsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) NSArray<Arrival *> *arrivals;
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak) UIActivityIndicatorView *indicatorView;

@end

@implementation LiveArrivalsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self shouldDisplayLoadingIndicatorView:YES];
}

- (void)updateArrivals:(NSArray<Arrival *> *)arrivals {
    
    [self shouldDisplayLoadingIndicatorView:NO];
    
    if (self.tableView == nil) {
        UITableView *tableView = [self createTableView];
        [self.view addSubview: tableView];
        self.tableView = tableView;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    
    self.arrivals = [arrivals sortedArrayUsingComparator:^NSComparisonResult(Arrival *  _Nonnull obj1, Arrival *  _Nonnull obj2) {
        if (obj1.timeToStation < obj2.timeToStation) {
            return NSOrderedAscending;
        } else if (obj1.timeToStation > obj2.timeToStation) {
            return NSOrderedDescending;
        }
        
        return NSOrderedSame;
    }];
    
    [self.tableView reloadData];
}

- (UITableView *)createTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LiveArrivalTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([LiveArrivalTableViewCell class])];
    
    tableView.scrollEnabled = NO;
    tableView.tableFooterView = [[UIView alloc] init];
    
    return tableView;
}

- (void)shouldDisplayLoadingIndicatorView:(BOOL)shouldDisplay {
    
    if (shouldDisplay) {
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [indicatorView startAnimating];
        indicatorView.frame = CGRectMake(self.view.center.x, 0.0, indicatorView.frame.size.width, indicatorView.frame.size.height);
        [self.view addSubview:indicatorView];
        self.indicatorView = indicatorView;
    } else {
        [self.indicatorView removeFromSuperview];
    }
}

#pragma mark - UITableViewFlowLayoutDelegate

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LiveArrivalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LiveArrivalTableViewCell class]) forIndexPath:indexPath];
    
    Arrival *arrival = [self.arrivals objectAtIndex:indexPath.item];
    
    cell.dueToArriveLabel.text = [NSString stringWithFormat:@"%ld mins", (long)[@(ceil(arrival.timeToStation / 60)) integerValue]];
    cell.routeLabel.text = [NSString stringWithFormat:@"%@ (%@)", arrival.terminatingDestinationName, arrival.lineName];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell layoutIfNeeded];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MIN(self.arrivals.count, 3);
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LiveArrivalsHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LiveArrivalsHeaderView class])
                                                                        owner:nil
                                                                      options:nil] objectAtIndex:0];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return 50.0;
}

@end
