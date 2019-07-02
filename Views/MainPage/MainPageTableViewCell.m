//
//  MainPageTableViewCell.m
//  ForJob
//
//  Created by Mac on 2019/5/25.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "MainPageTableViewCell.h"
#import "MainPageModel.h"

@interface MainPageTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *salaryTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *startEndLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *educationLabel;
@property (weak, nonatomic) IBOutlet UILabel *expLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;

@end

@implementation MainPageTableViewCell

- (void)setModel:(MainPageModel *)model {
    _model = model;
    self.titleLabel.text = model.post_name;
    self.startEndLabel.text = model.start_end_time;
    self.timeLabel.text = model.update_time;
    self.companyLabel.text = model.company_name;
    self.educationLabel.text = model.education_name;
    self.expLabel.text = model.experience_name;
    self.jobTypeLabel.text = model.type_name;
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
