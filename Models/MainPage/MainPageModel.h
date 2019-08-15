//
//  MainPageModel.h
//  ForJob
//
//  Created by Mac on 2019/5/25.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainPageModel : NSObject
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * post_name;
@property (nonatomic, strong) NSString * start_end_time;
@property (nonatomic, strong) NSString * update_time;
@property (nonatomic, strong) NSString * company_name;
@property (nonatomic, copy) NSString *education_name;
@property (nonatomic, copy) NSString *experience_name;
@property (nonatomic, copy) NSString *type_name;
@property (nonatomic, copy) NSString *wage;
@end
