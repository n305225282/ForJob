//
//  CDMessageCell.m
//  CDChat
//
//  Created by 吴文海 on 2019/3/7.
//  Copyright © 2019 吴文海. All rights reserved.
//

#import "CDMessageCell.h"

#import "CDMessageContentButton.h"
#import "CDImageTool.h"
#import "CDAVAudioPlayer.h"

#import "CDChatDefine.h"

#import "UIImageView+AFNetworking.h"
//#import <YBImageBrowser.h>

@interface CDMessageCell ()<CDAVAudioPlayerDelegate>
@property (nonatomic, strong) UILabel *dateLabel; 
@property (nonatomic, strong) UILabel *namelabel;
@property (nonatomic, strong) UIView *headBgView;
@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) CDMessageContentButton *contentButton;

@property (nonatomic, strong) NSData *voiceData;
@property (nonatomic, copy) NSString *voiceUrl;

@property (nonatomic, assign) BOOL voiceIsPlaying;
@end

@implementation CDMessageCell

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark - Intial Methods
- (void)setupView {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.headBgView];
    [self.headBgView  addSubview:self.headImageView];
    [self.contentView addSubview:self.namelabel];
    [self.contentView addSubview:self.contentButton];
    
    //红外线感应监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sensorStateChange:)
                                                 name:UIDeviceProximityStateDidChangeNotification
                                               object:nil];
}
#pragma mark - Target Methods
- (void)contentButtonClick:(CDMessageContentButton *)contentButton {
    // 语音
    if (self.messageFrame.message.type == CDMessageTypeVoice) {

        if (!self.voiceIsPlaying) {
            
            self.voiceIsPlaying = YES;
//          [CDAVAudioPlayer sharedInstance] playVoiceWithUrl:];
            [CDAVAudioPlayer sharedInstance].delegate = self;
            [[CDAVAudioPlayer sharedInstance] playVoiceWithData:self.voiceData];
            
        } else {
            
            self.voiceIsPlaying = NO;
            [self cdAVAudioPlayerDidFinishPlay];
        }
    } else if (self.messageFrame.message.type == CDMessageTypePicture) { // 图片
        if (self.contentButton.backImageView) {
//            [[CDImageTool new] showFullScrenImage:self.contentButton.backImageView];
//            YBImageBrowseCellData *data1 = [YBImageBrowseCellData new];
//            UIImage *image = self.contentButton.backImageView.image;
//            data1.imageBlock = ^__kindof UIImage * _Nullable{
//                return image;
//            };
//            data1.sourceObject = self.contentButton.backImageView.image;
//            
//            // 设置数据源数组并展示
//            YBImageBrowser *browser = [YBImageBrowser new];
//            browser.dataSourceArray = @[data1];
//            browser.currentIndex = 0;
//            [browser show];
        }
        if ([self.delegate isKindOfClass:[UIViewController class]]) {
            [[(UIViewController *)self.delegate view] endEditing:YES];
        }
    } else if (self.messageFrame.message.type == CDMessageTypeText) { // 文字
        
//        [self.contentButton becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setTargetRect:self.contentButton.frame inView:self.contentButton.superview];
        [menu setMenuVisible:YES animated:YES];
    }
}

// 处理监听红外线触发事件
-(void)sensorStateChange:(NSNotificationCenter *)notification {
    
    if ([[UIDevice currentDevice] proximityState] == YES) {
        
        NSLog(@"红外线使用");
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    } else {
        
        NSLog(@"红外线不可使用");
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
}

#pragma mark - Public Methods
// 内容及Frame设置
- (void)setMessageFrame:(CDMessageFrame *)messageFrame {
    
    _messageFrame = messageFrame;
    CDMessageModel *message = messageFrame.message;
    
    // 时间
    self.dateLabel.text = message.msgTime;
    self.dateLabel.frame = messageFrame.dateLableF;
    
    // 头像
    _headBgView.frame = messageFrame.headImageViewF;
    self.headImageView.frame = CGRectMake(2, 2, _headBgView.width - 4, _headBgView.height - 4);
    self.headImageView.image = [UIImage imageNamed:@"0.jpeg"];
    
    // 姓名
    self.namelabel.text = message.userName;
    self.namelabel.frame = messageFrame.nameLableF;
    
    // 内容
    self.contentButton.frame = messageFrame.contentF;
    [self.contentButton settingContentButtonWithMessageModel:message];
 
    // 语音
    if (message.msgVoiceData || message.msgVoiceUrl) {
        self.voiceData = message.msgVoiceData;
        //         self.voiceUrl = @"";
    }
}

#pragma mark - Private Method


#pragma mark - CDAVAudioPlayerDelegate -
- (void)cdAVAudioPlayerBeiginLoadVoice {
    
    [self.contentButton beginLoadVoice];
}

- (void)cdAVAudioPlayerBeiginPlay {
    
    //开启红外线感应
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    [self.contentButton beginPlayingVoice];
}

- (void)cdAVAudioPlayerDidFinishPlay {
    
    //关闭红外线感应
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    self.voiceIsPlaying = NO;
    [self.contentButton stopPlayVoice];
    [[CDAVAudioPlayer sharedInstance] stopSound];
}


#pragma mark - Setter Getter Methods
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = [UIColor grayColor];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.font = [UIFont systemFontOfSize:10];
    }
    return _dateLabel;
}

- (UIView *)headBgView {
    if (!_headBgView) {
        _headBgView = [[UIView alloc] init];
        _headBgView.backgroundColor = [UIColor greenColor];
        _headBgView.layer.cornerRadius = 22;
        _headBgView.layer.masksToBounds = YES;
    }
    return _headBgView;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.cornerRadius = 20;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.clipsToBounds = YES;
    }
    return _headImageView;
}

- (UILabel *)namelabel {
    if (!_namelabel) {
        _namelabel = [[UILabel alloc] init];
        _namelabel.textColor = [UIColor grayColor];
        _namelabel.textAlignment = NSTextAlignmentCenter;
        _namelabel.font = [UIFont systemFontOfSize:10];
    }
    return _namelabel;
}

- (CDMessageContentButton *)contentButton {
    if (!_contentButton) {
        _contentButton = [CDMessageContentButton buttonWithType:UIButtonTypeCustom];
        [_contentButton addTarget:self action:@selector(contentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contentButton;
}

@end
