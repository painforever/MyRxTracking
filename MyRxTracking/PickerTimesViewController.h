//
//  PickerTimesViewController.h
//  MyRxTracking
//
//  Created by Yu Song on 10/13/15.
//  Copyright © 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manifest.h"

@interface PickerTimesViewController : UIViewController <UITextFieldDelegate>
@property (nonatomic) int frequency;
@property (strong, nonatomic) NSMutableArray *timeControls;
//@property (strong, nonatomic) UIDatePicker *datePicker;
@end
