//
//  CDMessageFrame.h
//  CDChat
//
//  Created by 吴文海 on 2019/3/7.
//  Copyright © 2019 吴文海. All rights reserved.
//

#define MsgMargin 10       //间隔
#define MsgIconWH 44       //头像宽高height、width
#define MsgPicWH 200       //图片宽高
#define MsgContentW 180    //内容宽度

#define MsgContentTopBottom 8 //文本内容与按钮上边缘间隔
#define MsgContentBiger 20         //文本内容带角的一端
#define MsgContentSmaller 8     //文本内容不带角的一端

#define MsgScreenW [UIScreen mainScreen].bounds.size.width
#define MsgScreenH [UIScreen mainScreen].bounds.size.height

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CDMessageModel;
@interface CDMessageFrame : NSObject

@property (nonatomic, assign, readonly) CGRect dateLableF;
@property (nonatomic, assign, readonly) CGRect headImageViewF;
@property (nonatomic, assign, readonly) CGRect nameLableF;
@property (nonatomic, assign, readonly) CGRect contentF;

@property (nonatomic, assign, readonly) CGFloat cellHeight;

@property (nonatomic, strong) CDMessageModel *message;
@end

NS_ASSUME_NONNULL_END
