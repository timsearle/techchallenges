//
//  FacilityTagCollectionViewCell.m
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import "FacilityTagCollectionViewCell.h"

@implementation FacilityTagCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 3.0;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    self.backgroundColor = highlighted ? [UIColor lightGrayColor] : [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.backgroundColor = selected ? [UIColor lightGrayColor] : [UIColor whiteColor];
}

@end
