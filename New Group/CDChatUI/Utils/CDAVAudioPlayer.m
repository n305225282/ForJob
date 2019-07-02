//
//  CDAVAudioPlayer.m
//  CDChat
//
//  Created by 吴文海 on 2019/3/7.
//  Copyright © 2019 吴文海. All rights reserved.
//

#import "CDAVAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>


@interface CDAVAudioPlayer ()<AVAudioPlayerDelegate>

@end

@implementation CDAVAudioPlayer

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (CDAVAudioPlayer *)sharedInstance {
    
    static CDAVAudioPlayer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)playVoiceWithUrl:(NSString *)voiceUrl {
    
    dispatch_async(dispatch_queue_create("playSoundFromUrl", NULL), ^{
        
        if ([self.delegate respondsToSelector:@selector(cdAVAudioPlayerBeiginLoadVoice)]) {
            [self.delegate cdAVAudioPlayerBeiginLoadVoice];
        }
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:voiceUrl]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self playSoundWithData:data];
        });
    });
}

- (void)playVoiceWithData:(NSData *)voiceData {
    
    [self setupPlaySound];
    [self playSoundWithData:voiceData];
}

// 播放语音
- (void)playSoundWithData:(NSData *)soundData {
    
// 每次都重新创建player?
    if (_player) {
        
        [_player stop];
        _player.delegate = nil;
        _player = nil;
    }
    NSError *playerError;
    _player = [[AVAudioPlayer alloc] initWithData:soundData error:&playerError];
    _player.volume = 1.0f;
    if (_player == nil){
        
        NSLog(@"ERror creating player: %@", [playerError description]);
    }
    _player.delegate = self;
    [_player play];
    
    if ([self.delegate respondsToSelector:@selector(cdAVAudioPlayerBeiginPlay)]) {
        [self.delegate cdAVAudioPlayerBeiginPlay];
    }
}

-(void)setupPlaySound {
    
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
}

- (void)stopSound {
    
	if (_player.isPlaying) {
        
		[_player stop];
	}
}

// App挂起时需停止播放
- (void)applicationWillResignActive:(UIApplication *)application {
    
    if ([self.delegate respondsToSelector:@selector(cdAVAudioPlayerDidFinishPlay)]) {
        [self.delegate cdAVAudioPlayerDidFinishPlay];
    }
}

#pragma mark - AVAudioPlayerDelegate
// 播放完成
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    if ([self.delegate respondsToSelector:@selector(cdAVAudioPlayerDidFinishPlay)]) {
        [self.delegate cdAVAudioPlayerDidFinishPlay];
    }
}


@end
