//
//  CDMessageContentButton.m
//  CDChat
//
//  Created by 吴文海 on 2019/3/7.
//  Copyright © 2019 吴文海. All rights reserved.
//

#import "CDMessageContentButton.h"

#import "CDChatDefine.h"

@interface CDMessageContentButton ()

@property (nonatomic, weak) id <CDMessageContentButtonDelegate>delegate;

// 背景气泡图
@property (nonatomic, strong) UIImage *resizableImage;
// 是否是自己的消息
@property (nonatomic, assign) BOOL isMyMessage;

@end

@implementation CDMessageContentButton

- (instancetype)initWithFrame:(CGRect)frame withDelegate:(id<CDMessageContentButtonDelegate>)delegate {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}
#pragma mark - Intial Methods
- (void)setupView {
   
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:14.0];
  
    [self addSubview:self.backImageView];
    [self addSubview:self.voiceBackView];
    [self.voiceBackView addSubview:self.indicator];
    [self.voiceBackView addSubview:self.voiceImageView];
    [self.voiceBackView addSubview:self.voiceTimeLable];
    [self masLayoutSubViews];
}
- (void)masLayoutSubViews {
    
}
#pragma mark - Target Methods

#pragma mark - Public Methods
- (void)settingContentButtonWithMessageModel:(CDMessageModel *)messageModel {
    
    self.isMyMessage = (messageModel.from == CDMessageFromMe) ? YES : NO;
    self.voiceBackView.hidden = YES;
    self.backImageView.hidden = YES;
    [self setTitle:@"" forState:UIControlStateNormal];
    if (self.isMyMessage) { // 自己
        
        self.resizableImage = [UIImage cd_imageWithName:@"chatto_bg_normal"];
        self.resizableImage = [self.resizableImage resizableImageWithCapInsets:UIEdgeInsetsMake(35, 10, 10, 22)];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.backImageView.frame = CGRectMake(5, 5, 220, 220);
        self.voiceBackView.frame = CGRectMake(15, 10, 130, 35);
        self.voiceTimeLable.textColor = [UIColor whiteColor];
        self.titleEdgeInsets = UIEdgeInsetsMake(MsgContentTopBottom, 0, MsgContentTopBottom, MsgContentSmaller);
        
    } else { // 他人
        
        self.resizableImage = [UIImage cd_imageWithName:@"chatfrom_bg_normal"];
        self.resizableImage = [self.resizableImage resizableImageWithCapInsets:UIEdgeInsetsMake(35, 22, 10, 10)];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.backImageView.frame = CGRectMake(15, 5, 220, 220);
        self.voiceBackView.frame = CGRectMake(25, 10, 130, 35);
        self.voiceTimeLable.textColor = [UIColor grayColor];
        self.titleEdgeInsets = UIEdgeInsetsMake(MsgContentTopBottom, MsgContentBiger, MsgContentTopBottom, MsgContentSmaller);
    }
    
    [self setBackgroundImage:self.resizableImage forState:UIControlStateNormal];
    [self setBackgroundImage:self.resizableImage forState:UIControlStateHighlighted];
    
    switch (messageModel.type) {
        case CDMessageTypeText:
        {
            [self setTitle:messageModel.msgContent forState:UIControlStateNormal];
        }
            break;
        case CDMessageTypePicture:
        {
            self.backImageView.hidden = NO;
            [self.backImageView sd_setImageWithURL:[NSURL URLWithString:messageModel.msgPicture]];
            self.backImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            [self makeMaskView:self.backImageView withImage:self.resizableImage];
        }
            break;
        case CDMessageTypeVoice:
        {
            self.voiceBackView.hidden = NO;
            self.voiceTimeLable.text = [NSString stringWithFormat:@"%@'",messageModel.msgVoiceTime];
        }
            break;
            
        default:
            break;
    }
}

- (void)beginLoadVoice {
    
    self.voiceImageView.hidden = YES;
    [self.indicator startAnimating];
}
- (void)beginPlayingVoice {
    
    self.voiceImageView.hidden = NO;
    [self.indicator stopAnimating];
    [self.voiceImageView startAnimating];
}
-(void)stopPlayVoice {
    
    [self.voiceImageView stopAnimating];
}


#pragma mark - Private Method
- (void)makeMaskView:(UIView *)view withImage:(UIImage *)image {
    
    UIImageView *imageViewMask = [[UIImageView alloc] initWithImage:image];
    imageViewMask.frame = CGRectInset(view.frame, 0.0f, 0.0f);
    view.layer.mask = imageViewMask.layer;
}
// 成为第一响应者
- (BOOL)canBecomeFirstResponder {
    
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    return (action == @selector(copy:));
}

// 复制
-(void)copy:(id)sender {
    
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.titleLabel.text;
}


#pragma mark - Setter Getter Methods
- (UIImageView *)backImageView {
    
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.userInteractionEnabled = NO;
        _backImageView.layer.cornerRadius = 5;
        _backImageView.layer.masksToBounds  = YES;
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
//        _backImageView.backgroundColor = [UIColor yellowColor];
        
    }
    return _backImageView;
}

- (UIView *)voiceBackView {
    if (!_voiceBackView) {
        _voiceBackView = [[UIView alloc] init];
        _voiceBackView.backgroundColor = [UIColor clearColor];
        _voiceBackView.userInteractionEnabled = NO;
    }
    return _voiceBackView;
}

- (UILabel *)voiceTimeLable {
    if (!_voiceTimeLable) {
        _voiceTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.voiceBackView.frame) , 0, 30, 30)];
//        _voiceTimeLable.center = self.voiceBackView.center;
        _voiceTimeLable.textAlignment = NSTextAlignmentRight;
        _voiceTimeLable.font = [UIFont systemFontOfSize:13];
    }
    return _voiceTimeLable;
}

- (UIImageView *)voiceImageView {
    if (!_voiceImageView) {
        _voiceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.voiceBackView.frame) - 15, 5, 15, 15)];
        _voiceImageView.hidden= YES;
        _voiceImageView.image = [UIImage cd_imageWithName:@"chat_animation_white3"];
        _voiceImageView.animationImages = [NSArray arrayWithObjects:
                                      [UIImage cd_imageWithName:@"chat_animation_white1"],
                                      [UIImage cd_imageWithName:@"chat_animation_white2"],
                                      [UIImage cd_imageWithName:@"chat_animation_white3"],nil];
        _voiceImageView.animationDuration = 1;
        _voiceImageView.animationRepeatCount = 0;
    }
    return _voiceImageView;
}

- (UIActivityIndicatorView *)indicator {
    if (!_indicator) {
        _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _indicator.center=CGPointMake(80, 15);
    }
    return _indicator;
}


@end
