//
//  LoginViewController.m
//  ForJob
//
//  Created by 宇宇宇哲 on 2019/7/2.
//  Copyright © 2019 Arther. All rights reserved.
//

#import "LoginViewController.h"
#import "ResetPasswordViewController.h"
#import "TabbarViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginButton.alpha = 0.6;
    self.loginButton.enabled = NO;
    [self.phoneTextField addTarget:self action:@selector(didEditingTextField:) forControlEvents:(UIControlEventEditingChanged)];
    [self.passwordTextField addTarget:self action:@selector(didEditingTextField:) forControlEvents:(UIControlEventEditingChanged)];
    self.title = @"手机号登录";
}

- (void)didEditingTextField:(UITextField *)textField {
    if (self.phoneTextField.text.length == 11 && self.passwordTextField.text.length >= 6 && [DataCheck isMobile:self.phoneTextField.text]) {
        self.loginButton.alpha = 1;
        self.loginButton.enabled = YES;
    } else {
        self.loginButton.alpha = 0.6;
        self.loginButton.enabled = NO;
    }
}

- (IBAction)loginAction:(UIButton *)sender {
    [self login];
}

- (void)login {
    [self.requestManager postRequestWithInterfaceName:@"login/signIn" parame:@{@"mobile":self.phoneTextField.text,@"password":self.passwordTextField.text} success:^(id  _Nullable respDict, NSString * _Nullable message) {
        if ([DataCheck isValidDictionary:respDict]) {
            [[NSUserDefaults standardUserDefaults] setObject:respDict[@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] setObject:respDict[@"uuid"] forKey:@"uuid"];
            [UIApplication sharedApplication].keyWindow.rootViewController = [TabbarViewController new];
        }
    } fail:^(id  _Nullable error) {
        [self showInfoWithMessage:error];
    }];
}


- (IBAction)resetPwdAction:(UIButton *)sender {
    [self.navigationController pushViewController:[ResetPasswordViewController new] animated:YES];
}

@end
