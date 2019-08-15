//
//  DKSMoreView.m
//  DKSChatKeyboard
//
//  Created by aDu on 2018/1/4.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "DKSMoreView.h"
#import "UIView+FrameTool.h"

@interface DKSMoreView ()

@end

@implementation DKSMoreView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(30, 20, 60, 60);
        imageView.image = [UIImage imageNamed:@"photo"];
        [self addSubview:imageView];
        
        UILabel *label = [UILabel new];
        label.text = @"照片";
        label.frame = CGRectMake(30, imageView.maxY + 5, 60, 30);
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        self.photoClickButton.frame = CGRectMake(20, 20, 80, 80);
        [self addSubview:self.photoClickButton];
    }
    return self;
}



- (UIButton *)photoClickButton {
    if (!_photoClickButton) {
        _photoClickButton = [UIButton buttonWithType:(UIButtonTypeCustom)];

    }
    return _photoClickButton;
}
@end
