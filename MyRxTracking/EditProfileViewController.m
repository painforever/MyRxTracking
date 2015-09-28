//
//  EditProfileViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 9/11/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpStyle];
    self.userInputs = @[self.first_name, self.last_name];
    self.photo_gallery_picker = [[UIImagePickerController alloc] init];
    self.photo_gallery_picker.delegate = self;
    self.photo_gallery_picker.allowsEditing = YES;
    self.photo_gallery_picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    self.avatar.image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: self.user_info[@"avatar_url"]]]];
    self.first_name.text = self.user_info[@"first_name"];
    self.last_name.text = self.user_info[@"last_name"];
    self.country.text = [self stripColon:self.user_info[@"country"]];
    [self.county setText: [self stripColon: self.user_info[@"county"]]];
    [self.cell_phone setText: [self stripColon: self.user_info[@"cell_phone"]]];
    [self.address setText: [self stripColon: self.user_info[@"address"]]];
    [self.state setText: [self stripColon: self.user_info[@"state"]]];
    [self.city setText: [self stripColon: self.user_info[@"city"]]];
    [self.zipcode setText: [self stripColon: self.user_info[@"zipcode"]]];
    [self.email setText: [self stripColon: self.user_info[@"email"]]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)update_action:(id)sender {
    if (![self validUserInput])
        return;
    [[AFNetwork getAFManager] PATCH: [SERVER_URL stringByAppendingString:@"profiles/update_profile"] parameters: @{@"user": @{@"cell_phone_number": self.cell_phone.text, @"home_address1": self.address.text, @"fname": self.first_name.text, @"lname": self.last_name.text, @"city": self.city.text, @"state": self.state.text, @"county": self.county.text, @"country": self.country.text, @"zipcode": self.zipcode.text, @"email_address": self.email.text}, @"user_id": [userDefaults valueForKey:@"user_id"]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self showAlert:@"Update success." withMessage:@"Update success!"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (IBAction)change_avatar_action:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        [self presentViewController:self.photo_gallery_picker animated:YES completion:NULL];
    }
}

-(BOOL)validUserInput{
    for (UITextField *input in self.userInputs) {
        if ([[self trim: input.text] length] == 0) {
            self.non_blank_err_msg = [NSString stringWithFormat:@"%@ cannot be blank!", input.placeholder];
            [self showAlert:self.non_blank_err_msg withMessage: self.non_blank_err_msg];
            return NO;
        }
    }
    return YES;
}

-(void)setUpStyle{
    self.avatar.layer.borderWidth = 3.0f;
    self.avatar.layer.cornerRadius = 10.0f;
    self.avatar.clipsToBounds = YES;
    
    //scrollView
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(400, 900);
}

-(NSString *)stripColon: (NSString *)input{
    return [self trim: [input componentsSeparatedByString:@":"][1]];
}

#pragma Camera
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSURL *url = [NSURL URLWithString: AVATAR_URL];
    // And dismiss the image picker.
    [self dismissViewControllerAnimated:TRUE completion:nil];
    NSString *filename = [NSString stringWithFormat:@"%@.jpg", [JSONHandler md5:[JSONHandler microtime]]];
    self.selected_image = chosenImage;
    //display image on GUI
    self.avatar.image = chosenImage;
    [self uploadAvatar:self.selected_image withFileName: filename withID: [userDefaults valueForKey:@"user_id"] withFileParamKeyName:@"avatar" withUploadingURL: AVATAR_URL];
//    self.avatar.image = [NSString stringWithFormat:@"%@/%@/%@/%@", BASE_URL, @"uploads/user/avatar", [userDefaults valueForKey:@"user_id"], filename];
    NSLog(@"take photo finished!");
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
@end
