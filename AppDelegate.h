//
//  AppDelegate.h
//  ForJob
//
//  Created by Mac on 2019/5/24.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserInfoModel;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) UserInfoModel *userInfoModel;
@end

