//
//  MineHeaderView.m
//  ForJob
//
//  Created by Mac on 2019/5/26.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "MineHeaderView.h"

@interface MineHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *browseLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionLabel;
@property (weak, nonatomic) IBOutlet UIView *recordBGView;

@end

@implementation MineHeaderView

- (IBAction)userInfoAction:(UIButton *)sender {
    if (self.mineHeadBlock) {
        self.mineHeadBlock(0);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.recordBGView.clipsToBounds = NO;
    self.recordBGView.layer.cornerRadius = 5;
    self.recordBGView.layer.shadowOffset = CGSizeMake(-2, -2);
    self.recordBGView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    // 设置阴影透明度
    self.recordBGView.layer.shadowOpacity = 0.8;
    // 设置阴影半径
    self.recordBGView.layer.shadowRadius = 5;
}

- (IBAction)browseRecordAction:(UIButton *)sender {
    if (self.mineHeadBlock) {
        self.mineHeadBlock(1);
    }
}

- (IBAction)collectionAction:(UIButton *)sender {
    if (self.mineHeadBlock) {
        self.mineHeadBlock(2);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
