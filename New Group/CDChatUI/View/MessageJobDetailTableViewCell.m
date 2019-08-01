//
//  MessageJobDetailTableViewCell.m
//  ForJob
//
//  Created by 宇宇宇哲 on 2019/7/31.
//  Copyright © 2019 Arther. All rights reserved.
//

#import "MessageJobDetailTableViewCell.h"

@interface MessageJobDetailTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *education;
@property (weak, nonatomic) IBOutlet UILabel *experience;
@property (weak, nonatomic) IBOutlet UILabel *wageLabel;

@end

@implementation MessageJobDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = UIColor.clearColor;
    self.contentView.backgroundColor = UIColor.clearColor;
    // Initialization code
}

- (void)setModelDic:(NSDictionary *)modelDic {
    _modelDic = modelDic;
    self.nameLabel.text = modelDic[@"post_name"];
    self.typeLabel.text = modelDic[@"type"];
    self.locationLabel.text = modelDic[@""];
    self.education.text = modelDic[@"education"];
    self.experience.text = modelDic[@"experience"];
    self.wageLabel.text = modelDic[@"wage"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
