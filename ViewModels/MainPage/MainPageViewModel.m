//
//  MainPageViewModel.m
//  ForJob
//
//  Created by Mac on 2019/5/25.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "MainPageViewModel.h"
#import "HttpHelper.h"
#import "MainPageModel.h"

@implementation MainPageViewModel
- (void)fetchDataWithParams:(NSDictionary *)params {
    [[HttpHelper sharedHttpHelper] postRequestWithInterfaceName:@"index/index" parame:params success:^(id _Nullable respDict,NSString *message) {
        NSLog(@"%@",respDict);
        if (respDict) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[MainPageModel class] json:respDict[@"joblist"]];
            [self.bindView reloadData];
        }
    } fail:^(id _Nullable error) {
        NSLog(@"%@",error);
    }];
}

- (void)loadMoreData {
    
}
@end
