//
//  CDChatModel.m
//  CDChat
//
//  Created by 吴文海 on 2019/3/7.
//  Copyright © 2019 吴文海. All rights reserved.
//


#import <Foundation/Foundation.h>

@class CDMessageFrame;
@interface CDChatModel : NSObject

@property (nonatomic, strong) NSMutableArray<CDMessageFrame *> *dataSource;

@property (nonatomic) BOOL isGroupChat;

- (void)populateRandomDataSource;

- (void)addRandomItemsToDataSource:(NSInteger)number;

- (void)addSpecifiedItem:(NSDictionary *)dic;

- (void)recountFrame;

@end
