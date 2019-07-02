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

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重设密码";
    self.nextButton.alpha = 0.6;
    self.nextButton.enabled = NO;
    [self.phoneTextField addTarget:self action:@selector(didChangedTextField:) forControlEvents:(UIControlEventEditingChanged)];
    [self.vCodeTextField addTarget:self action:@selector(didChangedTextField:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didChangedTextField:(UITextField *)textField {
    if (self.phoneTextField.text.length > 0 && self.vCodeTextField.text.length > 0) {
        self.nextButton.alpha = 1;
        self.nextButton.enabled = YES;
    } else {
        self.nextButton.alpha = 0.6;
        self.nextButton.enabled = NO;
    }
}


- (IBAction)fetchVCodeAction:(JKCountDownButton *)sender {
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
}


- (IBAction)nextAction:(UIButton *)sender {
    [self.navigationController pushViewController:[ResetPasswordOverViewController new] animated:YES];
}

@end
