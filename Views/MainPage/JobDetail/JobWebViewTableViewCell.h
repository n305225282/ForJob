//
//  JobWebViewTableViewCell.h
//  ForJob
//
//  Created by 宇宇宇哲 on 2019/7/8.
//  Copyright © 2019 Arther. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class JobDetailModel;
@interface JobWebViewTableViewCell : UITableViewCell
@property (nonatomic, strong) JobDetailModel *jobDetailModel;
@property (nonatomic, copy) void(^heightBlock)(CGFloat height);
@end

NS_ASSUME_NONNULL_END
