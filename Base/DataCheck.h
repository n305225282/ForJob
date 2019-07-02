//
//  DataCheck.h
//  moumouRedPackage
//
//  Created by 陈洋的MBP on 16/11/1.
//  Copyright © 2016年 陈洋的MBP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataCheck : NSObject

+ (BOOL) isValidNumber:(id)input;
+ (BOOL) isValidString:(id)input;
+ (BOOL) isValidDictionary:(id)input;
+ (BOOL) isValidArray:(id)input;
+ (BOOL) isMobile:(NSString *)mobileNumbel;
+ (BOOL) isEMail:(NSString *)email;
/**  检测是否含有表情*/
+(BOOL)stringContainsEmoji:(NSString *)string;
//判断是否有屏蔽字
//+(BOOL)stringContainsString:(NSString *)string;
@end
