//
//  ResetPasswordOverViewController.m
//  ForJob
//
//  Created by 宇宇宇哲 on 2019/7/2.
//  Copyright © 2019 Arther. All rights reserved.
//

#import "ResetPasswordOverViewController.h"
#import "LoginViewController.h"


@interface ResetPasswordOverViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *rePasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;

@end

@implementation ResetPasswordOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重设密码";
    self.finishButton.alpha = 0.6;
    self.finishButton.enabled = NO;
}

- (IBAction)didChangedEditing:(UITextField *)sender {
    if (self.passwordTextField.text.length >= 6 && self.rePasswordTextField.text.length >= 6) {
        self.finishButton.alpha = 1;
        self.finishButton.enabled = YES;
    } else {
        self.finishButton.alpha = 0.6;
        self.finishButton.enabled = NO;
    }
    
}

- (IBAction)finishAction:(id)sender {
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[LoginViewController class]]) {
            
            [self.navigationController popToViewController:vc animated:YES];
            [self showInfoWithMessage:@"密码重置成功"];
        }
    }
}

@end
