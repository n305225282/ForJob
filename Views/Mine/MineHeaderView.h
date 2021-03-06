//
//  MineHeaderView.h
//  ForJob
//
//  Created by Mac on 2019/5/26.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MineHeadBLOCK)(NSUInteger type);

@class UserInfoModel;
@interface MineHeaderView : UIView
@property (nonatomic, copy) MineHeadBLOCK mineHeadBlock;
@property (nonatomic, strong) UserInfoModel *userInfoModel;

@end
