//
//  RegistFirstViewController.m
//  ForJob
//
//  Created by 宇宇宇哲 on 2019/7/2.
//  Copyright © 2019 Arther. All rights reserved.
//

#import "RegistFirstViewController.h"
#import "RegistFinishViewController.h"
#import "JKCountDownButton.h"

@interface RegistFirstViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *vCodeTextField;
@property (weak, nonatomic) IBOutlet JKCountDownButton *vCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (nonatomic, copy) NSString *code;
@end

@implementation RegistFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.nextButton.alpha = 0.6;
    self.nextButton.enabled = NO;
    self.vCodeButton.enabled = NO;
}

- (IBAction)didChangeTextField:(UITextField *)sender {
    if ([DataCheck isMobile:self.phoneTextField.text]) {
        self.vCodeButton.enabled = YES;
    } else {
        self.vCodeButton.enabled = NO;
    }
    
    if (self.vCodeTextField.text.length > 0 && [DataCheck isMobile:self.phoneTextField.text] && [self.code isEqualToString:self.vCodeTextField.text]) {
        self.nextButton.alpha = 1;
        self.nextButton.enabled = YES;
    } else {
        self.nextButton.alpha = 0.6;
        self.nextButton.enabled = NO;
    }
}

- (IBAction)fetchVCodeAction:(JKCountDownButton *)sender {
    [self.requestManager postRequestWithInterfaceName:@"login/sendCode" parame:@{@"mobile":self.phoneTextField.text,@"type":@"1"} success:^(id  _Nullable respDict, NSString * _Nullable message) {
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
    if ([self.code isEqualToString:self.vCodeTextField.text]) {
        RegistFinishViewController *rfVC = [RegistFinishViewController new];
        rfVC.code = self.code;
        rfVC.phone = self.phoneTextField.text;
        [self.navigationController pushViewController:rfVC animated:YES];
    }
}

@end
