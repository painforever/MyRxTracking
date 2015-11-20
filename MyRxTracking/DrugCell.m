//
//  DrugCell.m
//  MyRxTracking
//
//  Created by Yu Song on 9/9/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "DrugCell.h"

@implementation DrugCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)prepareForReuse{
    [super prepareForReuse];
    [self clearAllComponents];
}

-(void)didMoveToWindow{
    
}

-(void)clearAllComponents{
    Underscore.arrayEach(@[self.dosage, self.drug_image, self.drug_name, self.date, self.take_button, self.type], ^(id ele){
        if ([ele isKindOfClass: [UILabel class]]) {
            UILabel *label = (UILabel *)ele;
            label.text = nil;
        }
        else if ([ele isKindOfClass: [UIImageView class]]){
            UIImageView *imageView = (UIImageView *)ele;
            imageView.image = [UIImage imageNamed:@"default-drug-image.png"];
            //imageView.image = nil;
        }
        else{
            //button and NSString
            ele = nil;
        }
    });
}

@end
