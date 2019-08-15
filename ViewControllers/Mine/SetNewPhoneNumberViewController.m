//
//  SetNewPhoneNumberViewController.m
//  ForJob
//
//  Created by Mac on 2019/6/1.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "SetNewPhoneNumberViewController.h"
#import "JKCountDownButton.h"

@interface SetNewPhoneNumberViewController ()
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *vTextField;
@property (weak, nonatomic) IBOutlet JKCountDownButton *vCodeButton;
@property (nonatomic, strong) NSString *code;

@end

@implementation SetNewPhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.phoneNumberLabel.text = self.appDelegate.userInfoModel.mobile;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)vCodeButtonAction:(JKCountDownButton *)sender {
    
    [self.requestManager postRequestWithInterfaceName:@"login/sendCode" parame:@{@"mobile":self.phoneNumberLabel.text,@"type":@"2"} success:^(id  _Nullable respDict, NSString * _Nullable message) {
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

- (IBAction)finishAction:(UIButton *)sender {
    if (self.phoneTextField.text.length != 11) {
        [self showInfoWithMessage:@"请检查手机号"];
        return;
    }
    if (![self.vTextField.text isEqualToString:self.code]) {
        [self showInfoWithMessage:@"请检查验证码"];
        return;
    }
    [self updateUserInfoWithParam:@{@"key":@"mobile",@"value":self.phoneTextField.text}];
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
