//
//  WechatShareManager.h
//  ForJob
//
//  Created by 宇宇宇哲 on 2019/8/1.
//  Copyright © 2019 Arther. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WechatShareManager : NSObject
+ (BOOL)isWXAppInstalled;

/**
 分享网页
 @param title 标题
 @param description 描述
 @param thumbImage 缩略图
 @param webpageUrl 链接
 @param type 分享类型 0：聊天界面 1：朋友圈 2：收藏
 */
+ (void)shareToWechatWithWebTitle:(NSString *)title
                      description:(NSString *)description
                       thumbImage:(UIImage *)thumbImage
                       webpageUrl:(NSString *)webpageUrl
                             type:(NSUInteger)type;

@end

NS_ASSUME_NONNULL_END
