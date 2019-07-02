//
//  CDMessageCell.h
//  CDChat
//
//  Created by 吴文海 on 2019/3/7.
//  Copyright © 2019 吴文海. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CDMessageFrame, CDMessageCell;

@protocol CDMessageCellDelegate <NSObject>

@optional
- (void)chatCell:(CDMessageCell *)cell headImageDidClick:(NSString *)userId;
@end


@interface CDMessageCell : UITableViewCell

@property (nonatomic, strong) CDMessageFrame *messageFrame;

@property (nonatomic, weak) id <CDMessageCellDelegate>delegate;

@end

