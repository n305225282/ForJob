//
//  MainHeaderView.h
//  ForJob
//
//  Created by Mac on 2019/5/25.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MainHeaderBLOCK)(NSString *title);

@interface MainHeaderView : UIView
@property (nonatomic, copy) MainHeaderBLOCK clickFilterButtonBlock;
@property (weak, nonatomic) IBOutlet UIButton *cityButton;

@property (nonatomic, copy) MainHeaderBLOCK clickLocationButtonBlock;

@property (nonatomic, copy) void(^seachBlock)(void);
@end
