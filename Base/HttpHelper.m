//
//  HttpHelper.m
//  ForJob
//
//  Created by Mac on 2019/5/25.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "HttpHelper.h"
#import "AFNetworking.h"
@interface HttpHelper()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation HttpHelper

+ (instancetype)sharedHttpHelper {
    static HttpHelper *httpHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpHelper = [[HttpHelper alloc] init];
    });
    return httpHelper;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForRequest = 100;
        
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil sessionConfiguration:config];
        
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type" ];
        
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _manager.securityPolicy.validatesDomainName = NO;
        _manager.securityPolicy.allowInvalidCertificates = YES;
        
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"image/jpeg",@"image/png", @"application/octet-stream",@"text/json",@"text/html",nil];
    }
    return self;
}

- (void)getRequestInterfaceName:(NSString *_Nonnull)interfaceName parame:(NSDictionary *)param success:(void (^)(id _Nullable respDict,NSString *message))success fail:(void (^)(__autoreleasing id _Nullable error))fail {
    [_manager GET:kHost(interfaceName) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = responseObject;
        if ([dict[@"status"] isEqualToString:@"ok"]) {
            NSDictionary *data = dict[@"data"];
            NSString *message = dict[@"message"];
            success(data,message);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
}



- (void)postRequestWithInterfaceName:(NSString *)interfaceName parame:(NSDictionary *)param success:(void (^)(id _Nullable respDict,NSString *message))success fail:(void (^)(id _Nullable error))fail {
    [_manager POST:kHost(interfaceName) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = responseObject;
        NSLog(@"%@接口返回的数据\n%@",interfaceName,dict);
        if ([dict[@"status"] isEqualToString:@"ok"]) {
            NSDictionary *data = dict[@"data"];
            NSString *message = dict[@"message"];
            success(data,message);
        } else {
            NSString *message = dict[@"message"];
            fail(message);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error.description);
    }];
}



@end
