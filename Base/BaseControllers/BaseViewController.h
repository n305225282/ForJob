//
//  BaseViewController.h
//  ForJob
//
//  Created by Mac on 2019/5/24.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
- (void)showInfoWithMessage:(NSString *)message;

@property (nonatomic, strong) HttpHelper *requestManager;
@property (nonatomic, strong) AppDelegate *appDelegate;
- (void)showLodingWithMessage:(NSString *)message;
- (void)hideLoding;


/// 导航栏右侧按钮
@property (nonatomic, strong) NSArray<UIButton *> *rightButtons;
@end
