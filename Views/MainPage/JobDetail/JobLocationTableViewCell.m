//
//  JobLocationTableViewCell.m
//  ForJob
//
//  Created by Mac on 2019/5/25.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "JobLocationTableViewCell.h"
#import "JobDetailModel.h"

@interface JobLocationTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation JobLocationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setJobDetailModel:(JobDetailModel *)jobDetailModel {
    _jobDetailModel = jobDetailModel;
    self.addressLabel.text = jobDetailModel.address;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
