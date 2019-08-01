//
//  CDMessageModel.h
//  CDChat
//
//  Created by 吴文海 on 2019/3/7.
//  Copyright © 2019 吴文海. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CDMessageType) {
    CDMessageTypeText     = 0 , // 文字
    CDMessageTypePicture  = 1 , // 图片
    CDMessageTypeVoice    = 2   // 语音
};

typedef NS_ENUM(NSInteger, CDMessageFrom) {
    CDMessageFromMe    = 0,   // 自己发的
    CDMessageFromOther = 1    // 别人发得
};

@interface CDMessageModel : NSObject

@property (nonatomic, copy) NSString *userIcon;
@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *msgId;
@property (nonatomic, copy) NSString *msgTime;
@property (nonatomic, copy) NSString *msgContent;
@property (nonatomic, strong) NSString  *msgPicture;
@property (nonatomic, copy) NSData   *msgVoiceData;
@property (nonatomic, copy) NSString *msgVoiceTime;
@property (nonatomic, copy) NSString *msgVoiceUrl;

@property (nonatomic, assign) CDMessageType type;
@property (nonatomic, assign) CDMessageFrom from;

// 两条消息之间在5分钟之内不显示时间
@property (nonatomic, assign) BOOL showDateLable;

// 根据时间计算是否显示时间(showDateLable)
- (void)showDateTimeOffSetStart:(NSString *)start end:(NSString *)end;

// 数据初始化
- (void)setWithDict:(NSDictionary *)dict;


@end

NS_ASSUME_NONNULL_END
