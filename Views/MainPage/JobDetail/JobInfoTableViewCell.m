//
//  JobInfoTableViewCell.m
//  ForJob
//
//  Created by Mac on 2019/5/25.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "JobInfoTableViewCell.h"
#import "JobDetailModel.h"

@interface JobInfoTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *xueliLabel;
@property (weak, nonatomic) IBOutlet UILabel *expLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *salaryLabel;

@end

@implementation JobInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setJobDetailModel:(JobDetailModel *)jobDetailModel {
    _jobDetailModel = jobDetailModel;
    self.titleLabel.text = jobDetailModel.post_name;
    self.jobLocationLabel.text = jobDetailModel.address;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
