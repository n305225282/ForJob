//
//  MessageMainTableViewCell.h
//  ForJob
//
//  Created by Mac on 2019/5/25.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageListModel;
@interface MessageMainTableViewCell : UITableViewCell
@property (nonatomic, strong) MessageListModel *model;
@end
