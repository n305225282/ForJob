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

- (void)updateUserInfoWithParam:(NSDictionary *)param {
    NSMutableDictionary *paratems = [NSMutableDictionary dictionaryWithDictionary:param];
    [paratems setObject:GET_TOKEN forKey:@"token"];
    [paratems setObject:GET_UUID forKey:@"uuid"];
    [paratems setObject:@"1" forKey:@"submit"];
    [self.requestManager postRequestWithInterfaceName:@"member/eidtMemberInfo" parame:paratems success:^(id  _Nullable respDict, NSString * _Nullable message) {
        [self showInfoWithMessage:message];
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(id  _Nullable error) {
        [self showInfoWithMessage:error];
    }];
}

- (void)didChangedTextField:(UITextField *)textField {
    if (self.showType == 0) {
        if (textField.text.length > 10) {
            textField.text = textField.text;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.hidden = YES;
    [self.mainTextField addTarget:self action:@selector(didChangedTextField:) forControlEvents:(UIControlEventEditingChanged)];
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
            self.mainTextField.placeholder = @"输入您的位置";
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
    NSDictionary *param = nil;
    if (self.showType == 0) {
        if (self.mainTextField.text.length < 3) {
            [self showInfoWithMessage:@"请输入大于三个字符"];
            return;
        }
        param = @{@"key":@"nickname",@"value":self.mainTextField.text};
    } else if (self.showType == 2) {
        param = @{@"key":@"address",@"value":self.mainTextField.text};
    }
    if (param) {
        [self updateUserInfoWithParam:param];
    }
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



@end
