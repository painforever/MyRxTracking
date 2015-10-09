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
    self.menuItems = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7"];
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
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = self.menuItems[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    
//    if (indexPath.row == 0){
//        [self addTextFieldToCell:@"Medication Name" withCGRect:CGRectMake((cell.frame.size.width-250)/2, (cell.frame.size.height-40)/2, 250, 40) withTag:indexPath.row withUITextfield: self.medication_name withCell:cell];
//    }
//    
//    if (indexPath.row == 1){
//        [self addTextFieldToCell:@"Dosage" withCGRect:CGRectMake((cell.frame.size.width-250)/2, (cell.frame.size.height-40)/2, 250, 40) withTag:indexPath.row withUITextfield: self.dosage withCell:cell];
//    }
//    
//    if (indexPath.row == 2){
//        //drug photo....
//        self.drug_photo = [[UIImageView alloc] initWithFrame:CGRectMake((cell.frame.size.width-250)/2, (cell.frame.size.height-40)/2, 250, 250)];
//        self.drug_photo.image = [UIImage imageNamed:@"default-drug-image.png"];
//        [cell addSubview: self.drug_photo];
//    }
//    
//    if (indexPath.row == 3){
//        [self addButtonToCell:@"Take Photo" withCGRect:CGRectMake((cell.frame.size.width-250)/2, (cell.frame.size.height-40)/2, 250, 40) withTag:indexPath.row withButton:self.take_photo_btn withCell:cell];
//    }
//    if (indexPath.row == 4) {
//        self.switcher = [[UISwitch alloc] initWithFrame:CGRectMake(cell.frame.size.width-100, (cell.frame.size.height-30)/2, 100, 30)];
//        [self.switcher addTarget:self action:@selector(flip:) forControlEvents:UIControlEventValueChanged];
//        [cell addSubview: self.switcher];
//        cell.textLabel.text = @"Take as needed";
//    }
//    if (indexPath.row == 5) {
//        [self addTextFieldToCell:@"Frequency" withCGRect:CGRectMake((cell.frame.size.width-250)/2, (cell.frame.size.height-40)/2, 250, 40) withTag:indexPath.row withUITextfield:self.frequency withCell:cell];
//        self.frequencyCell = cell;
//    }
//    if (indexPath.row == 6) {
//        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
//        self.setupTimeCell = cell;
//        [self toggleSetupTimes];
//    }
//    self.medication_name.delegate = self;
//    self.dosage.delegate = self;
//    self.frequency.delegate = self;
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
    field.text = @"";
    field.delegate = self;
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

-(void)toggleSetupTimes{
    NSArray *controls = @[self.setupTimeCell, self.frequencyCell];
    if (self.switcher.on){
        self.setupTimeCell.textLabel.text = @"Not available";
        for (UITableViewCell *cell in controls) {
            cell.userInteractionEnabled = NO;
            cell.textLabel.enabled = NO;
            cell.accessoryType = UITableViewCellSelectionStyleNone;
        }
    }
    else {
        self.setupTimeCell.textLabel.text = @"Go and set up times ->";
        self.setupTimeCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        for (UITableViewCell *cell in controls) {
            cell.textLabel.enabled = YES;
            cell.userInteractionEnabled = YES;
        }
    }
}

-(IBAction)buttonClicked:(id)sender{
    NSLog(@"sdsdsdsdsdsds");
}

-(IBAction)flip:(id)sender{
    UISwitch *switcher = (UISwitch *)sender;
    [self toggleSetupTimes];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 6) {
        NSLog(@"sasasaasasa %@", self.frequency.text);
        PickTimesTable *view = [self.storyboard instantiateViewControllerWithIdentifier:@"PickTimesTable"];
        view.data = [[NSMutableDictionary alloc] init];
        view.data = @{@"fre": self.frequency.text};
        [self.navigationController pushViewController:view animated:YES];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"hjdgsdsh %@", self.frequency.text);
    if ([textField isEqual: self.frequency]) {
        NSLog(@"hjdgsdsh %@", self.frequency.text);
    }
}

- (IBAction)save_action:(id)sender {
}
@end
