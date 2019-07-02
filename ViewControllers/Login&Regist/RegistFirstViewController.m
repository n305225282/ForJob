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

@end

@implementation RegistFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.nextButton.alpha = 0.6;
    self.nextButton.enabled = NO;
}

- (IBAction)didChangeTextField:(UITextField *)sender {
    if (self.phoneTextField.text.length == 11 && self.vCodeTextField.text.length > 0) {
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
    [self.navigationController pushViewController:[RegistFinishViewController new] animated:YES];
}

@end
