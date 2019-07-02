//
//  ChangeInfoViewController.m
//  ForJob
//
//  Created by Mac on 2019/6/1.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "ChangeInfoViewController.h"
#import "JKCountDownButton.h"

@interface ChangeInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *mainTextField;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UITextField *vCodeTextField;
@property (weak, nonatomic) IBOutlet UIView *vCodeSepLine;
@property (weak, nonatomic) IBOutlet UIButton *vCodeButton;

@end

@implementation ChangeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.hidden = YES;
    switch (self.showType) {
        case 0:
            //姓名
        {
            self.titleLabel.text = @"你的姓名";
            self.mainTextField.placeholder = @"请输入姓名";
            self.descLabel.text = @"3/10个汉字";
            
            self.vCodeTextField.hidden = YES;
            self.vCodeButton.hidden = YES;
            self.vCodeSepLine.hidden = YES;
            
            self.locationButton.hidden = YES;
        }
            break;
            
        case 1: {
            //手机号
            self.titleLabel.text = @"绑定手机";
            self.mainTextField.placeholder = @"请输入您的手机号";
            self.mainTextField.keyboardType = UIKeyboardTypeNumberPad;
            self.descLabel.hidden = YES;
            
            [self.vCodeButton setTitle:@"发送验证码" forState:(UIControlStateNormal)];
            self.locationButton.hidden = YES;
        }
            break;
            
        case 2: {
            //位置
            self.titleLabel.text = @"你的位置";
            self.mainTextField.placeholder = @"输入您的位置或获取位置";
            self.descLabel.hidden = YES;
            
            self.vCodeTextField.hidden = YES;
            self.vCodeButton.hidden = YES;
            self.vCodeSepLine.hidden = YES;
        }
            break;
            
        default:
            break;
    }
}
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)vCodeAction:(JKCountDownButton *)sender {
    sender.enabled = NO;
    //button type要 设置成custom 否则会闪动
    [sender startCountDownWithSecond:60];
    
    [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
        NSString *title = [NSString stringWithFormat:@"%zd秒重新发送",second];
        return title;
    }];
    [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
        countDownButton.enabled = YES;
        return @"发送验证码";
        
    }];
}

- (IBAction)locationAction:(UIButton *)sender {
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
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
