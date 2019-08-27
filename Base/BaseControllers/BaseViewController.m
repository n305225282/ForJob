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
#import "LoginAndRegistViewController.h"

@interface BaseViewController () <UITabBarControllerDelegate>

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
    self.tabBarController.delegate = self;
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

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navVC = (UINavigationController *)viewController;
        for (UIViewController *vc in navVC.viewControllers) {
            if ([vc isKindOfClass:[MessageTableViewController class]] || [vc isKindOfClass:[MineViewController class]]) {
                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"token"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"uuid"]) {
                    
                    return TRUE;
                } else {
//                    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:[LoginAndRegistViewController new]];
                    [self.navigationController pushViewController:[LoginAndRegistViewController new] animated:YES];
                    return NO;
                }
            }
        }
    }
    return TRUE;
}

- (void)showLodingWithMessage:(NSString *)message {
    MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = message;
}

- (void)hideLoding {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)showInfoWithMessage:(NSString *)message {
    MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode=MBProgressHUDModeCustomView;
    
    hud.label.text = message;
    
    [hud hideAnimated:YES afterDelay:1.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AppDelegate *)appDelegate {
    if (!_appDelegate) {
        _appDelegate = myAppDelegate;
    }
    return _appDelegate;
}

- (void)setRightButtons:(NSArray<UIButton *> *)rightButtons {
    _rightButtons = rightButtons;
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < rightButtons.count; i++) {
        [tempArray addObject:[[UIBarButtonItem alloc] initWithCustomView:rightButtons[i]]];
    }
    if (tempArray.count > 0) {
        self.navigationItem.rightBarButtonItems = tempArray;
    }
}

@end
