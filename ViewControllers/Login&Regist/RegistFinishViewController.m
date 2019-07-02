//
//  RegistFinishViewController.m
//  ForJob
//
//  Created by 宇宇宇哲 on 2019/7/2.
//  Copyright © 2019 Arther. All rights reserved.
//

#import "RegistFinishViewController.h"
#import "LoginAndRegistViewController.h"

@interface RegistFinishViewController ()
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *rePasswordTextField;

@end

@implementation RegistFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.finishButton.alpha = 0.6;
    self.finishButton.enabled = NO;
}
- (IBAction)didChangedTextField:(UITextField *)sender {
    if (self.passwordTextField.text.length >= 6 && self.rePasswordTextField.text.length >= 6 && [self.passwordTextField.text isEqualToString:self.rePasswordTextField.text]) {
        self.finishButton.alpha = 1;
        self.finishButton.enabled = YES;
    } else {
        self.finishButton.alpha = 0.6;
        self.finishButton.enabled = NO;
    }
}


- (IBAction)finishAction:(UIButton *)sender {
    [self.requestManager postRequestWithInterfaceName:@"login/register" parame:@{@"mobile":self.phone,@"pwd":self.passwordTextField.text,@"code":self.code} success:^(id  _Nullable respDict, NSString * _Nullable message) {
        [self showInfoWithMessage:message];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } fail:^(id  _Nullable error) {
        [self showInfoWithMessage:error];
    }];
}


@end
