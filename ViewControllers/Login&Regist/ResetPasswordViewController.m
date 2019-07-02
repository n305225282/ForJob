//
//  ResetPasswordViewController.m
//  ForJob
//
//  Created by 宇宇宇哲 on 2019/7/2.
//  Copyright © 2019 Arther. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "ResetPasswordOverViewController.h"
#import "JKCountDownButton.h"

@interface ResetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *vCodeTextField;
@property (weak, nonatomic) IBOutlet JKCountDownButton *vButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (nonatomic, copy) NSString *code;
@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重设密码";
    self.nextButton.alpha = 0.6;
    self.nextButton.enabled = NO;
    self.vButton.enabled = NO;
    [self.phoneTextField addTarget:self action:@selector(didChangedTextField:) forControlEvents:(UIControlEventEditingChanged)];
    [self.vCodeTextField addTarget:self action:@selector(didChangedTextField:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didChangedTextField:(UITextField *)textField {
    if ([DataCheck isMobile:self.phoneTextField.text]) {
        self.vButton.enabled = YES;
    } else {
        self.vButton.enabled = NO;
    }
    
    if ([DataCheck isMobile:self.phoneTextField.text] && self.vCodeTextField.text.length > 0 && [self.vCodeTextField.text isEqualToString:self.code]) {
        self.nextButton.alpha = 1;
        self.nextButton.enabled = YES;
    } else {
        self.nextButton.alpha = 0.6;
        self.nextButton.enabled = NO;
    }
}


- (IBAction)fetchVCodeAction:(JKCountDownButton *)sender {
    [self.requestManager postRequestWithInterfaceName:@"login/sendCode" parame:@{@"mobile":self.phoneTextField.text,@"type":@"2"} success:^(id  _Nullable respDict, NSString * _Nullable message) {
        if ([DataCheck isValidString:[NSString stringWithFormat:@"%@", respDict[@"code"]]]) {
            self.code = [NSString stringWithFormat:@"%@",respDict[@"code"]];
            sender.enabled = NO;
            //button type要 设置成custom 否则会闪动
            [sender startCountDownWithSecond:60];
            
            [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
                NSString *title = [NSString stringWithFormat:@"%zds后重新获取",second];
                return title;
            }];
            [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                countDownButton.enabled = YES;
                return @"获取验证码";
                
            }];
        } else {
            [self showInfoWithMessage:@"获取验证码失败"];
        }
    } fail:^(id  _Nullable error) {
        [self showInfoWithMessage:error];
    }];
}


- (IBAction)nextAction:(UIButton *)sender {
    ResetPasswordOverViewController *resetOverVC = [ResetPasswordOverViewController new];
    resetOverVC.phone = self.phoneTextField.text;
    resetOverVC.code = self.code;
    [self.navigationController pushViewController:resetOverVC animated:YES];
}

@end
