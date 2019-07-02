//
//  HttpHelper.h
//  ForJob
//
//  Created by Mac on 2019/5/25.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpHelper : NSObject
+ (instancetype _Nonnull )sharedHttpHelper;
- (void)getRequestWithInterfaceName:(NSString *_Nonnull)interfaceName parame:(NSDictionary *_Nullable)param success:(nullable void(^)(id _Nullable respDict,NSString * _Nullable message))success fail:(nullable void(^)(id _Nullable error))fail;

- (void)postRequestWithInterfaceName:(NSString *_Nonnull)interfaceName parame:(NSDictionary *_Nullable)param success:(nullable void(^)(id _Nullable respDict,NSString * _Nullable message))success fail:(nullable void(^)(id _Nullable error))fail;
@end
