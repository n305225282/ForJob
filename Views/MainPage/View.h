//
//  View.h
//  ForJob
//
//  Created by 宇宇宇哲 on 2019/8/1.
//  Copyright © 2019 Arther. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface View : UIView
@property (nonatomic, copy) void(^shareBlock)(void);
@end

NS_ASSUME_NONNULL_END
