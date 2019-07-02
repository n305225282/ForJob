//
//  CDChatCategory.m
//  CDChat
//
//  Created by 吴文海 on 2019/3/7.
//  Copyright © 2019 吴文海. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIDevice(CDChatCategory)

+ (BOOL)cd_isIPhone;

+ (BOOL)cd_isIPhoneX;

@end



@interface UIImage (CDChatCategory)

/**
 *  本地 UIImage 获取
 */
+ (nullable instancetype)cd_imageWithName:(NSString *)imageName;

+ (UIImage *)cd_imageWithColor:(UIColor *)color;

@end


@interface NSBundle(CDChatCategory)
/**
 *  pod库本地bundle文件获取
 */
+ (nullable instancetype)cd_photoViewerResourceBundle;

@end

@interface NSString(CDChatCategory)

- (CGSize)cd_sizeWithFont:(UIFont *)font;

/**
 * 计算文字的Size
 */
- (CGSize)cd_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

@end



@interface UIResponder(CDChatCategory)

- (nullable __kindof UIResponder *)cd_findNextResonderInClass:(nonnull Class)responderClass;

@end


NS_ASSUME_NONNULL_END
