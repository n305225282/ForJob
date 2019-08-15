
//
//  SetPasswordViewController.m
//  ForJob
//
//  Created by Mac on 2019/6/1.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "JKCountDownButton.h"
#import "ChangePasswordViewController.h"


@interface SetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UITextField *vCodeTextField;
@property (nonatomic, copy) NSString *code;
@end

@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mobileLabel.text = self.appDelegate.userInfoModel.mobile;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)vCodeAction:(JKCountDownButton *)sender {
    [self.requestManager postRequestWithInterfaceName:@"login/sendCode" parame:@{@"mobile":self.mobileLabel.text,@"type":@"2"} success:^(id  _Nullable respDict, NSString * _Nullable message) {
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
    }];}

- (IBAction)nextAction:(UIButton *)sender {
    if ([self.code isEqualToString:self.vCodeTextField.text]) {
        
        [self.navigationController pushViewController:[ChangePasswordViewController new] animated:YES];
    }
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
