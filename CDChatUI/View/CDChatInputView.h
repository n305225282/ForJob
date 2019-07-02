//
//  CDChatInputView.h
//  CDChat
//
//  Created by 吴文海 on 2019/3/8.
//  Copyright © 2019 吴文海. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CDChatInputViewDelegate <NSObject>

@optional

@end

@interface CDChatInputView : UIView

- (instancetype)initWithFrame:(CGRect)frame withDelegate:(id<CDChatInputViewDelegate>)delegate;

@end
