//
//  NavigationBaseViewController.m
//  ForJob
//
//  Created by Mac on 2019/5/24.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "NavigationBaseViewController.h"

@interface NavigationBaseViewController ()

@end

@implementation NavigationBaseViewController



- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationBar.translucent = NO;
//    self.navigationBar.clipsToBounds = YES;
    self.navigationBar.backgroundColor = [UIColor whiteColor];
    
    [self.navigationBar setShadowImage:[UIImage new]];
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];

    // Do any additional setup after loading the view.
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
