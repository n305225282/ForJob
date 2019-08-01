//
//  MainHeaderView.m
//  ForJob
//
//  Created by Mac on 2019/5/25.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "MainHeaderView.h"
@interface MainHeaderView()
@property (weak, nonatomic) IBOutlet UIButton *minqiButton;
@property (weak, nonatomic) IBOutlet UIButton *rijieButton;
@property (weak, nonatomic) IBOutlet UIButton *quanzhiButton;
@property (weak, nonatomic) IBOutlet UIButton *jianzhiButton;

@end

@implementation MainHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cityButton.titleLabel.adjustsFontSizeToFitWidth = YES;
}



- (IBAction)locationAction:(UIButton *)sender {
    if (self.clickLocationButtonBlock) {
        self.clickLocationButtonBlock(sender.titleLabel.text);
    }
}



- (IBAction)seachAction:(id)sender {
    if (self.seachBlock) {
        self.seachBlock();
    }
    
}



- (IBAction)filterButtonAction:(UIButton *)sender {
    NSString*title = @"";
    if (sender == self.minqiButton) {
        NSLog(@"民企");
        title = @"民企业";
    }
    if (sender == self.rijieButton) {
        NSLog(@"日结");
        title = @"日结";
    }
    if (sender == self.quanzhiButton) {
        NSLog(@"全职");
        title = @"全职";
    }
    if (sender == self.jianzhiButton) {
        NSLog(@"兼职");
        title = @"兼职";
    }
    if (self.clickFilterButtonBlock) {
        self.clickFilterButtonBlock(title);
    }
}

@end
