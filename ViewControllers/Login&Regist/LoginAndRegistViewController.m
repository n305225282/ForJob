//
//  LoginAndRegistViewController.m
//  ForJob
//
//  Created by 宇宇宇哲 on 2019/7/2.
//  Copyright © 2019 Arther. All rights reserved.
//

#import "LoginAndRegistViewController.h"
#import "LoginViewController.h"
#import "RegistFirstViewController.h"

@interface LoginAndRegistViewController ()
@property (weak, nonatomic) IBOutlet UIButton *registButton;

@end

@implementation LoginAndRegistViewController

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
    self.registButton.layer.borderColor = [UIColor.blueColor colorWithAlphaComponent:0.6].CGColor;
    self.registButton.layer.borderWidth = .5f;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


- (IBAction)loginAction:(UIButton *)sender {
    [self.navigationController pushViewController:[LoginViewController new] animated:YES];
}


- (IBAction)registAction:(UIButton *)sender {
    [self.navigationController pushViewController:[RegistFirstViewController new] animated:YES];
}

@end
