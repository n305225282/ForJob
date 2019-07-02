//
//  CDMessageModel.m
//  CDChat
//
//  Created by 吴文海 on 2019/3/7.
//  Copyright © 2019 吴文海. All rights reserved.
//

#import "CDMessageModel.h"
#import "NSDate+Utils.h"

@implementation CDMessageModel
// 数据初始化
- (void)setWithDict:(NSDictionary *)dict{
    
    self.userIcon = dict[@"strIcon"];
    self.userName = dict[@"strName"];
    self.msgId = dict[@"strId"];
    self.msgTime = [self changeTheDateString:dict[@"strTime"]];
    self.from = [dict[@"from"] intValue];
    
    switch ([dict[@"type"] integerValue]) {
            
        case 0:
            self.type = CDMessageTypeText;
            self.msgContent = dict[@"strContent"];
            break;
            
        case 1:
            self.type = CDMessageTypePicture;
            self.msgPicture = dict[@"picture"];
            break;
            
        case 2:
            self.type = CDMessageTypeVoice;
            self.msgVoiceData = dict[@"voice"];
            self.msgVoiceTime = dict[@"strVoiceTime"];
            break;
            
        default:
            break;
    }
}

// 显示时间
// "08-10 晚上08:09:41.0" ->
// "昨天 上午10:09"或者"2018-08-10 凌晨07:09"
- (NSString *)changeTheDateString:(NSString *)Str {
    
    NSString *subString = [Str substringWithRange:NSMakeRange(0, 19)];
    NSDate *lastDate = [NSDate dateFromString:subString withFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:lastDate];
    lastDate = [lastDate dateByAddingTimeInterval:interval];

    NSString *dateStr;  //年月日
    NSString *period;   //时间段
    NSString *hour;     //时

    if ([lastDate year] == [[NSDate date] year]) {
        NSInteger days = [NSDate daysOffsetBetweenStartDate:lastDate endDate:[NSDate date]];
        if (days <= 2) {
            dateStr = [lastDate stringYearMonthDayCompareToday];
        } else {
            dateStr = [lastDate stringMonthDay];
        }
    } else {
        
        dateStr = [lastDate stringYearMonthDay];
    }


    if ([lastDate hour] >= 5 && [lastDate hour] < 12) {
        period = @"早上";
        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour]];
    }else if ([lastDate hour] >= 12 && [lastDate hour] <= 18){
        period = @"下午";
        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour] - 12];
    }else if ([lastDate hour] > 18 && [lastDate hour] <= 23){
        period = @"晚上";
        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour] - 12];
    } else {
        period = @"凌晨";
        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour]];
    }
    return [NSString stringWithFormat:@"%@ %@ %@:%02d",dateStr,period,hour,(int)[lastDate minute]];
}

- (void)showDateTimeOffSetStart:(NSString *)start end:(NSString *)end {
    if (!start) {
        self.showDateLable = YES;
        return;
    }
    
    NSString *subStart = [start substringWithRange:NSMakeRange(0, 19)];
    NSDate *startDate = [NSDate dateFromString:subStart withFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *subEnd = [end substringWithRange:NSMakeRange(0, 19)];
    NSDate *endDate = [NSDate dateFromString:subEnd withFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //这个是相隔的秒数
    NSTimeInterval timeInterval = [startDate timeIntervalSinceDate:endDate];
    
    //相距5分钟显示时间Label
    if (fabs (timeInterval) > 5*60) {
        self.showDateLable = YES;
    }else{
        self.showDateLable = NO;
    }
    
}
@end
