//
//  CDMessageModel.m
//  CDChat
//
//  Created by 吴文海 on 2019/3/7.
//  Copyright © 2019 吴文海. All rights reserved.
//


#import "CDChatModel.h"

#import "CDMessageModel.h"
#import "CDMessageFrame.h"

@implementation CDChatModel

- (void)populateRandomDataSource {
    self.dataSource = [NSMutableArray array];
    [self.dataSource addObjectsFromArray:[self additems:5]];
}

- (void)addRandomItemsToDataSource:(NSInteger)number{
    
    for (int i=0; i<number; i++) {
        [self.dataSource insertObject:[[self additems:1] firstObject] atIndex:0];
    }
}

- (void)recountFrame
{
	[self.dataSource enumerateObjectsUsingBlock:^(CDMessageFrame * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		obj.message = obj.message;
	}];
}

// 添加自己的item
- (void)addSpecifiedItem:(NSDictionary *)dic
{
    CDMessageFrame *messageFrame = [[CDMessageFrame alloc]init];
    CDMessageModel *message = [[CDMessageModel alloc] init];
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    NSString *URLStr = @"http://img0.bdstatic.com/img/image/shouye/xinshouye/mingxing16.jpg";
    [dataDic setObject:@(CDMessageFromMe) forKey:@"from"];
    [dataDic setObject:[[NSDate date] description] forKey:@"strTime"];
	[dataDic setObject:@"就是我" forKey:@"strName"];
    [dataDic setObject:URLStr forKey:@"strIcon"];
    
    [message setWithDict:dataDic];
    [message showDateTimeOffSetStart:previousTime end:dataDic[@"strTime"]];
    [messageFrame setMessage:message];
    
    if (message.showDateLable) {
        previousTime = dataDic[@"strTime"];
    }
    [self.dataSource addObject:messageFrame];
}

// 添加聊天item（一个cell内容）
static NSString *previousTime = nil;
- (NSArray<CDMessageFrame *> *)additems:(NSInteger)number
{
    NSMutableArray<CDMessageFrame *> *result = [NSMutableArray array];
    
    for (int i=0; i<number; i++) {
        
        NSDictionary *dataDic = [self getDic];
        CDMessageFrame *messageFrame = [[CDMessageFrame alloc]init];
        CDMessageModel *message = [[CDMessageModel alloc] init];
        [message setWithDict:dataDic];
        [message showDateTimeOffSetStart:previousTime end:dataDic[@"strTime"]];
        [messageFrame setMessage:message];
        
        if (message.showDateLable) {
            previousTime = dataDic[@"strTime"];
        }
        [result addObject:messageFrame];
    }
    return result;
}

// 如下:群聊（groupChat）
static int dateNum = 10;
- (NSDictionary *)getDic {
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    int randomNum = arc4random() % 5;
    if (randomNum == CDMessageTypePicture) {
//        [dictionary setObject:[UIImage imageNamed:[NSString stringWithFormat:@"%u",arc4random() % 4]] forKey:@"picture"];
        [dictionary setObject:[UIImage imageNamed:@"wdxz"] forKey:@"picture"];
    } else {
        // 文字出现概率4倍于图片（暂不出现Voice类型）
        randomNum = CDMessageTypeText;
        [dictionary setObject:[self getRandomString] forKey:@"strContent"];
    }
    NSDate *date = [[NSDate date]dateByAddingTimeInterval:arc4random() % 1000 * (dateNum++)];
    [dictionary setObject:@(CDMessageFromOther) forKey:@"from"];
    [dictionary setObject:@(randomNum) forKey:@"type"];
    [dictionary setObject:[date description] forKey:@"strTime"];
    // 这里判断是否是私人会话、群会话
    int index = _isGroupChat ? arc4random() % 6 : 0;
    [dictionary setObject:[self getName:index] forKey:@"strName"];
    [dictionary setObject:[self getImageStr:index] forKey:@"strIcon"];
    
    return dictionary;
}

- (NSString *)getRandomString {
    
    NSString *lorumIpsum = @"婷 婷 姐 姐 唱 古 文 很 厉 害 是 绝 代 风 华 开 始 的 繁 华 开 始 的 繁 华 开 始 的 繁 华开 始 的 繁 华 开 始 的 繁 华 开 始 的 繁 华 开 始 的 繁 华 开 始 的 繁 华开 始 的 繁 华 华 开 始 的 繁 华 开 始 的 繁 华 开 始 的 繁 华 开 始 的 繁 华 开 始 的 繁 华 开 始 的 繁 华 开 始 的 繁 华 开 始 的 繁 华 开 始 的 繁";
    
    NSArray *lorumIpsumArray = [lorumIpsum componentsSeparatedByString:@" "];
    
    int r = arc4random() % [lorumIpsumArray count];
    r = MAX(6, r); // no less than 6 words
    NSArray *lorumIpsumRandom = [lorumIpsumArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, r)]];
    
    return [NSString stringWithFormat:@"%@!!", [lorumIpsumRandom componentsJoinedByString:@" "]];
}

- (NSString *)getImageStr:(NSInteger)index{
    NSArray *array = @[@"http://www.120ask.com/static/upload/clinic/article/org/201311/201311061651418413.jpg",
                       @"http://p1.qqyou.com/touxiang/uploadpic/2011-3/20113212244659712.jpg",
                       @"http://www.qqzhi.com/uploadpic/2014-09-14/004638238.jpg",
                       @"http://e.hiphotos.baidu.com/image/pic/item/5ab5c9ea15ce36d3b104443639f33a87e950b1b0.jpg",
                       @"http://ts1.mm.bing.net/th?&id=JN.C21iqVw9uSuD2ZyxElpacA&w=300&h=300&c=0&pid=1.9&rs=0&p=0",
                       @"http://ts1.mm.bing.net/th?&id=JN.7g7SEYKd2MTNono6zVirpA&w=300&h=300&c=0&pid=1.9&rs=0&p=0"];
    return array[index];
}

- (NSString *)getName:(NSInteger)index{
    NSArray *array = @[@"吴文海",@"小曹",@"王乾",@"小淘"];
    return array[index];
}
@end
