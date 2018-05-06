//
//  FacilitiesTagCloudViewController.m
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import "FacilitiesTagCloudViewController.h"
#import "FacilityTagCollectionViewCell.h"
#import "Facility.h"

@interface FacilitiesTagCloudViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic,strong) NSArray<Facility *> *facilities;
@property (nonatomic,weak) UICollectionView *collectionView;

@end

@implementation FacilitiesTagCloudViewController

- (instancetype)initWithFacilities:(NSArray<Facility *> *)facilities {
    
    self = [super initWithNibName:nil bundle:nil];
    
    if (self) {
        self.facilities = facilities;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self displayFacilities: self.facilities];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    for (NSIndexPath *indexPath in self.collectionView.indexPathsForSelectedItems) {
        [self.collectionView deselectItemAtIndexPath:indexPath animated:true];
    }
}

- (void)displayFacilities:(NSArray<Facility *> *)facilities {
    
    if (self.collectionView == nil) {
        UICollectionView *collectionView = [self createCollectionView];
        [self.view addSubview: collectionView];
        self.collectionView = collectionView;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.contentInset = UIEdgeInsetsMake(0, 8, 0, 8);
    }
    
    self.facilities = facilities;
    [self.collectionView reloadData];
}

- (UICollectionView *)createCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection: UICollectionViewScrollDirectionVertical];
    flowLayout.estimatedItemSize = CGSizeMake(100, 52);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout: flowLayout];

    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FacilityTagCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([FacilityTagCollectionViewCell class])];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    return collectionView;
}

- (CGFloat)calculatedHeight {
    return self.collectionView.contentSize.height;
}

#pragma mark - UICollectionViewFlowLayoutDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(facilitiesTagCloudViewController:didSelectFacility:)]) {
        Facility *facility = self.facilities[indexPath.item];
        [self.delegate facilitiesTagCloudViewController:self didSelectFacility:facility];
    }
}

#pragma mark - UICollectionViewDataSource

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FacilityTagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FacilityTagCollectionViewCell class]) forIndexPath:indexPath];
    
    Facility *facility = [self.facilities objectAtIndex:indexPath.item];
    cell.tagLabel.text = facility.name;
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.facilities.count;
}

@end
