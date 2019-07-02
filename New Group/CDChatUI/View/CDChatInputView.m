//
//  CDChatInputView.m
//  CDChat
//
//  Created by 吴文海 on 2019/3/8.
//  Copyright © 2019 吴文海. All rights reserved.
//

#import "CDChatInputView.h"

@interface CDChatInputView ()

@property (nonatomic, weak) id <CDChatInputViewDelegate>delegate;

@end

@implementation CDChatInputView

- (instancetype)initWithFrame:(CGRect)frame withDelegate:(id<CDChatInputViewDelegate>)delegate {
    
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
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 200, 40)];
    lable.text = @"点我发送消息";
    lable.textColor = [UIColor whiteColor];
    [self addSubview:lable];
    self.backgroundColor = [UIColor grayColor];
    [self masLayoutSubViews];
}
- (void)masLayoutSubViews {
    
}
#pragma mark - Target Methods

#pragma mark - Public Methods

#pragma mark - Private Method

#pragma mark - Setter Getter Methods

@end
