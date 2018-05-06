//
//  LiveArrivalsHeaderCollectionReusableView.m
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import "LiveArrivalsHeaderView.h"

@interface LiveArrivalsHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

@end

@implementation LiveArrivalsHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headerLabel.text = NSLocalizedString(@"tube.arrivals.section.title", nil);
}

@end
