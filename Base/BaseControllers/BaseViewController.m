//
//  BaseViewController.m
//  ForJob
//
//  Created by Mac on 2019/5/24.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "BaseViewController.h"
#import "MainPageViewController.h"
#import "MessageTableViewController.h"
#import "MineViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@",[self class]);
    if ([self isKindOfClass:[MainPageViewController class]] || [self isKindOfClass:[MessageTableViewController class]] || [self isKindOfClass:[MineViewController class]] ) {
        self.tabBarController.tabBar.hidden = NO;
    } else {
        self.tabBarController.tabBar.hidden = YES;
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.requestManager = [HttpHelper sharedHttpHelper];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    barItem.tintColor = [UIColor blackColor];
    self.navigationItem.backBarButtonItem = barItem;
    // Do any additional setup after loading the view.
}

- (void)showInfoWithMessage:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:[UIApplication sharedApplication].keyWindow];
    hud.label.text = message;
    [hud setMinShowTime:2];
    [hud showAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
