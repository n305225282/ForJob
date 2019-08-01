//
//  MessageListModel.h
//  ForJob
//
//  Created by 宇宇宇哲 on 2019/7/30.
//  Copyright © 2019 Arther. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageListModel : NSObject
@property (nonatomic, assign) NSInteger buid;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy) NSString *dt;
@property (nonatomic, copy) NSString *headImg;
@property (nonatomic, copy) NSString *message_content;
@property (nonatomic, assign) NSInteger mid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) NSInteger state;
@end

NS_ASSUME_NONNULL_END
