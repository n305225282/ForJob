//
//  TabbarViewController.m
//  ForJob
//
//  Created by Mac on 2019/5/24.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "TabbarViewController.h"
#import "MainPageViewController.h"
#import "MessageTableViewController.h"
#import "MineViewController.h"
#import "NavigationBaseViewController.h"

@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewControllers = @[[self creatChildControllerWithController:[MainPageViewController new] WithTitle:@"职位" Image:[UIImage imageNamed:@"zwwxz"] SelectImage:[UIImage imageNamed:@"zwxz"]],
                             
                             [self creatChildControllerWithController:[MessageTableViewController new] WithTitle:@"消息" Image:[UIImage imageNamed:@"xxwxz"] SelectImage:[UIImage imageNamed:@"xxxz"]],
                             
                             [self creatChildControllerWithController:[MineViewController new] WithTitle:@"我的" Image:[UIImage imageNamed:@"wdwxz"] SelectImage:[UIImage imageNamed:@"wdxz"]]];
    // Do any additional setup after loading the view.
}

- (UITabBarItem *)creatTabbarItemWithTitle:(NSString *)title image:(UIImage *)image selectImage:(UIImage *)selectImage {
    return [[UITabBarItem alloc] initWithTitle:title image:[image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] selectedImage:[selectImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
}

- (NavigationBaseViewController *)creatChildControllerWithController:(UIViewController *)controller WithTitle:(NSString *)title Image:(UIImage *)image SelectImage:(UIImage *)selectImage {
    NavigationBaseViewController *nav = [[NavigationBaseViewController alloc] initWithRootViewController:controller];
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectImage];
    return nav;
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
