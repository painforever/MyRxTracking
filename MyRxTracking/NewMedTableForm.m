//
//  NewMedTableForm.m
//  MyRxTracking
//
//  Created by Yu Song on 10/8/15.
//  Copyright © 2015 EagleForce. All rights reserved.
//

#import "NewMedTableForm.h"

@interface NewMedTableForm ()

@end

@implementation NewMedTableForm

- (void)viewDidLoad {
    [super viewDidLoad];
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 0){
        [self addTextFieldToCell:@"Medication Name" withCGRect:CGRectMake((cell.frame.size.width-250)/2, (cell.frame.size.height-40)/2, 250, 40) withTag:indexPath.row withUITextfield: self.medication_name withCell:cell];
    }
    
    if (indexPath.row == 1){
        [self addTextFieldToCell:@"Dosage" withCGRect:CGRectMake((cell.frame.size.width-250)/2, (cell.frame.size.height-40)/2, 250, 40) withTag:indexPath.row withUITextfield: self.dosage withCell:cell];
    }
    
    if (indexPath.row == 2){
        
    }
    
    if (indexPath.row == 3){
        [self addButtonToCell:@"Take Photo" withCGRect:CGRectMake((cell.frame.size.width-250)/2, (cell.frame.size.height-40)/2, 250, 40) withTag:indexPath.row withButton:self.take_photo_btn withCell:cell];
    }
    self.medication_name.delegate = self;
    self.dosage.delegate = self;
    self.frequency.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        return 300;
    }
    else return 90;
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

-(void)addButtonToCell: (NSString *)title withCGRect: (CGRect)rect withTag: (int)tag withButton: (UIButton *)btn withCell: (UITableViewCell *)cell{
    btn = [[UIButton alloc] initWithFrame:rect];
    btn.tag = tag;
    [btn setImage:[UIImage imageNamed:@"name_background.jpg"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.textColor = [UIColor blackColor];
    [btn setBackgroundColor:[UIColor colorWithRed:THEME_COLOR_RED green:THEME_COLOR_GREEN blue:THEME_COLOR_BLUE alpha:1]];
    [btn setTitle: title forState:UIControlStateNormal];
    [cell addSubview: btn];
}

-(IBAction)buttonClicked:(id)sender{
    NSLog(@"sdsdsdsdsdsds");
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
