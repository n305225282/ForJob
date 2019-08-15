//
//  ChangePasswordViewController.m
//  ForJob
//
//  Created by Mac on 2019/6/1.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *rePasswordTextField;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)finishAction:(UIButton *)sender {
    if ([self.passwordTextField.text isEqualToString:self.rePasswordTextField.text] && self.passwordTextField.text.length >= 6) {
        [self updateUserInfoWithParam:@{@"key":@"pwd",@"value":self.passwordTextField.text}];
    } else {
        [self showInfoWithMessage:@"请输入大于6位的密码,并确认两次密码输入是否一致"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateUserInfoWithParam:(NSDictionary *)param {
    NSMutableDictionary *paratems = [NSMutableDictionary dictionaryWithDictionary:param];
    [paratems setObject:GET_TOKEN forKey:@"token"];
    [paratems setObject:GET_UUID forKey:@"uuid"];
    [paratems setObject:@"1" forKey:@"submit"];
    [self.requestManager postRequestWithInterfaceName:@"member/eidtMemberInfo" parame:paratems success:^(id  _Nullable respDict, NSString * _Nullable message) {
        [self showInfoWithMessage:message];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } fail:^(id  _Nullable error) {
        [self showInfoWithMessage:error];
    }];
}


@end
