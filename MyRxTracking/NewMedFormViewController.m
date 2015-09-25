
//
//  NewMedFormViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 8/26/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "NewMedFormViewController.h"
#import "AFNetwork.h"
#import "Manifest.h"

@implementation NewMedFormViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"New Medication";
    self.drug_image_file_name = @"";
    self.cameraView = [[UIImagePickerController alloc] init];
    self.cameraView.delegate = self;
    self.cameraView.allowsEditing = YES;
    self.cameraView.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: @"http://bipolarhappens.com/bhblog/wp-content/uploads/med-question6.gif"]]];
    self.medication_name.delegate = self;
}
- (IBAction)take_photo_action:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        [self presentViewController:self.cameraView animated:YES completion:NULL];
    }
}

- (IBAction)add_action:(id)sender {
    NSArray *inputs = @[self.medication_name, self.dosage];
    NSString *alert = [[NSString alloc] init];
    for (UITextField *input in inputs) {
        if ([[self trim: input.text] length] == 0) {
            alert = [NSString stringWithFormat:@"%@ cannot be blank", input.placeholder];
            [self showAlert: alert withMessage: alert];
            return;
        }
    }
    if (![JSONHandler isNnumber:self.dosage.text]) {
        [self showAlert:@"Dosage must be number" withMessage:@"Dosage must be number!"];
        return;
    }
    NSMutableDictionary *res_dic = [Drug searchDrug:self.medication_name.text];
    NSLog(@"res_dic %@", [res_dic description]);
    if ([res_dic[@"msg"] isEqualToString:@"No"]) {
        [self showAlert:@"Cannot find this drug" withMessage:@"We are sorry but we cannot find this drug."];
        return;
    }
    self.selected_drug_id = res_dic[@"result"][@"drug_id"];
    [[AFNetwork getAFManager] POST:[SERVER_URL stringByAppendingString:@"medications"] parameters:@{@"prm": @{@"patient_id": [userDefaults valueForKey:@"patient_id"], @"drug_id": self.selected_drug_id , @"dosage": self.dosage.text, @"prescribed_date": [NSDate date]}} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *res_dic = (NSDictionary *)responseObject;
        NSLog(@"dasasfdsds %@", [res_dic description]);
        //see if it's remote url or local file name, if it's local file then do the upload
        NSRange http = [self.drug_image_file_name rangeOfString:@"http://"];
        NSRange https = [self.drug_image_file_name rangeOfString:@"https://"];
        if ([self.drug_image_file_name isEqualToString:@"drug not found"]) {
            [self showAlert:@"Drug added" withMessage:@"Drug added!"];
            return;
        }
        else if (http.location == NSNotFound && https.location == NSNotFound) {
            [self uploadAvatar:self.imageView.image withFileName:self.drug_image_file_name withID:res_dic[@"id"] withFileParamKeyName:@"drug_photo" withUploadingURL: DRUG_PHOTO_URL];
        }
        else{
            [[AFNetwork getAFManager] POST:[SERVER_URL stringByAppendingString:@"medications/update_drug_remote_url"] parameters: @{@"id": res_dic[@"id"], @"drug_photo": self.drug_image_file_name} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {}];
        }
        [self showAlert:@"Drug added" withMessage:@"Drug added!"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *responseObject) {
        NSLog(@"failed");
    }];
}

#pragma UITetxfield stuffs
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.medication_name) {
        NSLog(@"zheng yi zhong");
        //search for drugs from GoodRx and get the drug image after user onblur the textField
        [[AFNetwork getAFManager] GET:[SERVER_URL stringByAppendingString:@"medications/async_search_drug"] parameters:@{@"drug": self.medication_name.text} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *image_dic = (NSDictionary *)responseObject;
            self.drug_image_file_name = image_dic[@"result"];
            NSLog(@"remote: %@", self.drug_image_file_name);
            self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: self.drug_image_file_name]]];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed %@", [operation responseString]);
            self.imageView.image = [UIImage imageNamed:@"default-drug-image.png"];
            self.drug_image_file_name = [operation responseString];
        }];
    }
}
#pragma Camera
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    //NSURL *url = [NSURL URLWithString: photo_upload_url];
    // And dismiss the image picker.
    [self dismissViewControllerAnimated:TRUE completion:nil];
    NSString *filename = [NSString stringWithFormat:@"%@.jpg", [JSONHandler md5:[JSONHandler microtime]]];
    self.drug_image_file_name = filename;
    NSLog(@"take photo finished!");
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
@end
