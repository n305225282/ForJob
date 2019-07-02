//
//  LoginViewController.m
//  ForJob
//
//  Created by 宇宇宇哲 on 2019/7/2.
//  Copyright © 2019 Arther. All rights reserved.
//

#import "LoginViewController.h"
#import "ResetPasswordViewController.h"

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
}

- (void)didEditingTextField:(UITextField *)textField {
    if (self.phoneTextField.text.length > 0 && self.passwordTextField.text.length > 0) {
        self.loginButton.alpha = 1;
        self.loginButton.enabled = YES;
    } else {
        self.loginButton.alpha = 0.6;
        self.loginButton.enabled = NO;
    }
}

- (IBAction)loginAction:(UIButton *)sender {
    
}

- (IBAction)resetPwdAction:(UIButton *)sender {
    [self.navigationController pushViewController:[ResetPasswordViewController new] animated:YES];
}

@end
