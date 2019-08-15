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
    [MBProgressHUD showHUDAddedTo:UIApplication.sharedApplication.keyWindow animated:YES];
    [[HttpHelper sharedHttpHelper] postRequestWithInterfaceName:@"index/index" parame:params success:^(id _Nullable respDict,NSString *message) {
        [MBProgressHUD hideHUDForView:UIApplication.sharedApplication.keyWindow animated:YES];
        NSLog(@"%@",respDict);
        if (respDict) {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                NSDictionary *shareDic = respDict[@"share"];
                if ([DataCheck isValidDictionary:shareDic]) {
                    if (self.HandleBlock) {
                        self.HandleBlock(shareDic);
                    }
                }
            });
            self.dataSource = [NSArray yy_modelArrayWithClass:[MainPageModel class] json:respDict[@"joblist"]];
            if (self.dataSource.count < 1) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:UIApplication.sharedApplication.keyWindow animated:YES];
                hud.label.text = @"暂无记录...";
                hud.mode=MBProgressHUDModeCustomView;
                [hud hideAnimated:YES afterDelay:3];
            }
            [self.bindView reloadData];
        }
    } fail:^(id _Nullable error) {
        NSLog(@"%@",error);
        [MBProgressHUD hideHUDForView:UIApplication.sharedApplication.keyWindow animated:YES];
    }];
}

- (void)loadMoreData {
    
}
@end
