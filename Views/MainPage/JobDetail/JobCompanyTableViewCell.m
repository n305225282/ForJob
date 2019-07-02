//
//  JobCompanyTableViewCell.m
//  ForJob
//
//  Created by Mac on 2019/5/25.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "JobCompanyTableViewCell.h"
#import "JobDetailModel.h"

@interface JobCompanyTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *scaleLabel;
@property (weak, nonatomic) IBOutlet UILabel *managename;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;

@end

@implementation JobCompanyTableViewCell

- (void)setJobDetailModel:(JobDetailModel *)jobDetailModel {
    _jobDetailModel = jobDetailModel;
    self.companyLabel.text = jobDetailModel.company_name;
    self.scaleLabel.text = jobDetailModel.scale;
    self.managename.text = jobDetailModel.manage_name;
    self.mobileLabel.text = jobDetailModel.mobile;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
