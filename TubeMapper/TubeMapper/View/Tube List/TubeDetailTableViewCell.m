//
//  TubeDetailTableViewCell.m
//  TubeMapper
//
//  Created by Tim Searle on 19/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import "TubeDetailTableViewCell.h"

@implementation TubeDetailTableViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
}

@end
