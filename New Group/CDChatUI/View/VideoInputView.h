//
//  VideoInputView.h
//  CDChat
//
//  Created by mac on 2019/5/27.
//  Copyright © 2019年 吴文海. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^BLOCK)(id data,NSInteger time);

@interface VideoInputView : UIView
{
    UIButton        *_recordButton;     //开始录音
    UIButton        *_playRecordButton; //播放录音
    
    UIView          *_volumeBgView;     //音量背景视图
    UIImageView     *_volumeImageView;  //音量图片
    UILabel         *_volumeLabel;      //提示文字
    UILabel         *_countLabel;
    
    NSTimer         *_timer;            //定时器
    NSInteger       _countDown;         //倒计时,最多60秒
    
    AVAudioSession      *_session;
    AVAudioRecorder     *_recorder;    //录音器
    AVAudioPlayer       *_player;      //音频播放器
    NSString            *_recordFilePath;     //录音文件沙盒地址
    
    BOOL _isLeaveSpeakBtn;   //是否上滑
}

@property (nonatomic,readwrite,strong)BLOCK audioRecordeBlock;
@end

NS_ASSUME_NONNULL_END
