//
//  CityRightTableViewCell.m
//  ForJob
//
//  Created by Mac on 2019/5/25.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "CityRightTableViewCell.h"

@interface CityRightTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *dingweiImageVIew;

@property (weak, nonatomic) IBOutlet UIImageView *xuanzeImageView;

@end

@implementation CityRightTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.dingweiImageVIew.hidden = YES;
    self.xuanzeImageView.hidden = YES;
    // Initialization code
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    self.dingweiImageVIew.hidden = !isSelected;
    self.xuanzeImageView.hidden = !isSelected;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
