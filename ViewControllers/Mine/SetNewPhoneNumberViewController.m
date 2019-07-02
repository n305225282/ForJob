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
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *vTextField;
@property (weak, nonatomic) IBOutlet JKCountDownButton *vCodeButton;

@end

@implementation SetNewPhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)vCodeButtonAction:(JKCountDownButton *)sender {
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

- (IBAction)finishAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
