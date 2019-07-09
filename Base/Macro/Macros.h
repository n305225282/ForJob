//
//  Macros.h
//  Job
//
//  Created by mac on 2019/5/24.
//  Copyright © 2019年 Arther. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#pragma mark - 图片加载
//图片加载
#define KImageName(a) [UIImage imageNamed:(a)]
//默认背景图片
#define KBackImage @"p1"
//默认背景头像
#define KBackHeadImage @"p1"

#define kScreenWidth  UIScreen.mainScreen.bounds.size.width
#define kScreenHeight  UIScreen.mainScreen.bounds.size.height

#define kFont(x)         [UIFont systemFontOfSize:x] //正常字体
#define kBoldFont(x)     [UIFont fontWithName:@"Helvetica-Bold" size:x] //加粗
#define GET_TOKEN  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]

#define GET_UUID  [[NSUserDefaults standardUserDefaults] objectForKey:@"uuid"]

#pragma mark - 屏幕
//屏幕宽高
#define is_Pad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !is_Pad : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !is_Pad : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !is_Pad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !is_Pad : NO)

#define is_iPhoneX ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES) ? YES : NO)
#define IS_X ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max) ? YES : NO)
//状态栏高度
#define StatusBarHeight     (IS_X ? 44.f : 20.f)
// 导航高度
#define NavigationBarHeight 44.f
// Tabbar高度.   49 + 34 = 83
#define TabbarHeight        (IS_X ? 83.f : 49.f)
// Tabbar安全区域底部间隙
#define TabbarSafeBottomMargin  (IS_X ? 34.f : 0.f)
// 状态栏和导航高度
#define StatusBarAndNavigationBarHeight  (IS_X ? 88.f : 64.f)

//接口地址
#define kHost(x) [NSString stringWithFormat:@"http://sp.xijitech.com/api/%@",x]
#endif /* Macros_h */
