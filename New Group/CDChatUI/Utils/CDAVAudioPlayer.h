//
//  CDAVAudioPlayer.h
//  CDChat
//
//  Created by 吴文海 on 2019/3/7.
//  Copyright © 2019 吴文海. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@protocol CDAVAudioPlayerDelegate <NSObject>

- (void)cdAVAudioPlayerBeiginLoadVoice;

- (void)cdAVAudioPlayerBeiginPlay;

- (void)cdAVAudioPlayerDidFinishPlay;

@end

@interface CDAVAudioPlayer : NSObject

@property (nonatomic, strong) AVAudioPlayer *player;

@property (nonatomic, weak) id<CDAVAudioPlayerDelegate> delegate;

// 初始化
+ (instancetype)sharedInstance;

// 播放
-(void)playVoiceWithUrl:(NSString *)voiceUrl;

// 播放
-(void)playVoiceWithData:(NSData *)voiceData;

// 停止播放
- (void)stopSound;

@end
