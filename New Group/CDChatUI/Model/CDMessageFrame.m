//
//  CDMessageFrame.m
//  CDChat
//
//  Created by 吴文海 on 2019/3/7.
//  Copyright © 2019 吴文海. All rights reserved.
//

#import "CDMessageFrame.h"
#import "CDMessageModel.h"
#import "CDChatCategory.h"


@interface CDMessageFrame()

@end

@implementation CDMessageFrame
- (void)setMessage:(CDMessageModel *)message{
    
    _message = message;
    
    // 1、计算dateLable的位置
    if (message.showDateLable){
        
        CGSize timeSize = [_message.msgTime cd_sizeWithFont:[UIFont systemFontOfSize:10] constrainedToSize:CGSizeMake(MAXFLOAT, 100)];
        _dateLableF = CGRectMake((MsgScreenW - timeSize.width) / 2, MsgMargin, timeSize.width, timeSize.height);
    } else {
        
        _dateLableF = CGRectZero;
    }
    
    // 2、计算头像位置
    CGFloat const iconX = _message.from == CDMessageFromOther ? MsgMargin : (MsgScreenW - MsgMargin - MsgIconWH);
    _headImageViewF = CGRectMake(iconX, CGRectGetMaxY(_dateLableF) + MsgMargin, MsgIconWH, MsgIconWH);
    
    // 3、计算name位置
    CGSize nameSize = [_message.userName cd_sizeWithFont:[UIFont systemFontOfSize:10] constrainedToSize:CGSizeMake(MsgIconWH + MsgMargin, 50)];
    _nameLableF = CGRectMake(iconX - MsgMargin / 2.0, CGRectGetMaxY(_headImageViewF) + MsgMargin / 2.0, MsgIconWH + MsgMargin, nameSize.height);
    
    // 4、计算内容位置
    CGFloat contentX = CGRectGetMaxX(_headImageViewF) + MsgMargin;
    
    //根据种类分
    CGSize contentSize;
    switch (_message.type) {
        case CDMessageTypeText: // 文本
            contentSize = [_message.msgContent cd_sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(MAX(MsgContentW, MsgScreenW * 0.6), CGFLOAT_MAX)];
            contentSize.height = MAX(contentSize.height, 30);
            contentSize.width = MAX(contentSize.width, 40);
            break;
        case CDMessageTypePicture: // 图片
            contentSize = CGSizeMake(MsgPicWH, MsgPicWH);
            break;
        case CDMessageTypeVoice: {// 语音
            NSInteger voiceLenght = [_message.msgVoiceTime integerValue];
            CGFloat width = 30;
            if (voiceLenght < 2) {
                width = 30;
            } else {
                width = 30 + voiceLenght * 5;
            }
            if (width > 200) {
                width = 200;
            }
            contentSize = CGSizeMake(width, 35);
        }
            break;
        default:
            break;
    }
    if (_message.from == CDMessageFromMe) { // 自己
        contentX = MsgScreenW - (contentSize.width + MsgContentBiger + MsgContentSmaller + MsgMargin + MsgIconWH + MsgMargin);
    }
    _contentF = CGRectMake(contentX, CGRectGetMinY(_headImageViewF) + 5, contentSize.width + MsgContentBiger + MsgContentSmaller, contentSize.height + MsgContentTopBottom * 2);
    
    _cellHeight = MAX(CGRectGetMaxY(_contentF), CGRectGetMaxY(_nameLableF))  + MsgMargin;
}

@end
