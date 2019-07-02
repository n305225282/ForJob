//
//  JobDetailModel.h
//  ForJob
//
//  Created by 宇宇宇哲 on 2019/7/1.
//  Copyright © 2019 Arther. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JobDetailModel : NSObject
@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * company_name;
@property (nonatomic, strong) NSString * manage_name;
@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * post_detail;
@property (nonatomic, strong) NSString * post_name;
@property (nonatomic, strong) NSString * scale;
@property (nonatomic, copy) NSString *experience_name;
@property (nonatomic, copy) NSString *education_name;
@property (nonatomic, copy) NSString *type_name;
@end

NS_ASSUME_NONNULL_END
