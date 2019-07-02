//
//  CDMessageContentButton.h
//  CDChat
//
//  Created by 吴文海 on 2019/3/7.
//  Copyright © 2019 吴文海. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDChatDefine.h"

@protocol CDMessageContentButtonDelegate <NSObject>

@optional

@end

@interface CDMessageContentButton : UIButton

@property (nonatomic, retain) UIImageView *backImageView;

// 语音相关属性
@property (nonatomic, retain) UIView *voiceBackView;
@property (nonatomic, retain) UILabel *voiceTimeLable;
@property (nonatomic, retain) UIImageView *voiceImageView;
@property (nonatomic, retain) UIActivityIndicatorView *indicator;


- (instancetype)initWithFrame:(CGRect)frame withDelegate:(id<CDMessageContentButtonDelegate>)delegate;

// 消息内容处理
- (void)settingContentButtonWithMessageModel:(CDMessageModel *)messageModel;

// 开始导入语音
- (void)beginLoadVoice;

// 开始播放语音
- (void)beginPlayingVoice;

// 停止播放语音
-(void)stopPlayVoice;

@end
