//
//  RxHistoryCell.h
//  MyRxTracking
//
//  Created by Yu Song on 9/10/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RxHistoryCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *drug_name;
@property (strong, nonatomic) IBOutlet UILabel *rx_id;
@property (strong, nonatomic) IBOutlet UILabel *is_finished;
@property (strong, nonatomic) IBOutlet UITextView *notes;
@end
