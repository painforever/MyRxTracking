//
//  PickTimesTable.m
//  MyRxTracking
//
//  Created by Yu Song on 10/9/15.
//  Copyright © 2015 EagleForce. All rights reserved.
//

#import "PickTimesTable.h"

@interface PickTimesTable ()

@end

@implementation PickTimesTable

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.frequency_count = 4;
    NSLog(@"integer :%@", [self.data description]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data objectForKey:@"fre"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UITextField *field = [[UITextField alloc] init];
    [self addTextFieldToCell:@"Time" withCGRect:CGRectMake((cell.frame.size.width-250)/2, (cell.frame.size.height-40)/2, 250, 40) withTag:indexPath.row withUITextfield: field withCell:cell];
    return cell;
}

-(void)addTextFieldToCell: (NSString *)placeholder withCGRect: (CGRect)rect withTag: (int)tag withUITextfield: (UITextField *)field withCell: (UITableViewCell *)cell{
    field = [[UITextField alloc] initWithFrame: rect];
    field.placeholder = placeholder;
    [field setBorderStyle: UITextBorderStyleRoundedRect];
    field.autocorrectionType = UITextAutocorrectionTypeNo;
    [field setClearButtonMode:UITextFieldViewModeWhileEditing];
    field.tag = tag;
    [cell addSubview: field];
}

@end
