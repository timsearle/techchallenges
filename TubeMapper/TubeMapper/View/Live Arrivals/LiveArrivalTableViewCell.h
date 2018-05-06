//
//  LiveArrivalTableViewCell.h
//  TubeMapper
//
//  Created by Tim Searle on 18/11/2017.
//  Copyright © 2017 Tim Searle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveArrivalTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *routeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dueToArriveLabel;

@end
