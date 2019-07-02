//
//  RegistFinishViewController.m
//  ForJob
//
//  Created by 宇宇宇哲 on 2019/7/2.
//  Copyright © 2019 Arther. All rights reserved.
//

#import "RegistFinishViewController.h"
#import "LoginAndRegistViewController.h"

@interface RegistFinishViewController ()
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *rePasswordTextField;

@end

@implementation RegistFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.finishButton.alpha = 0.6;
    self.finishButton.enabled = NO;
}
- (IBAction)didChangedTextField:(UITextField *)sender {
    if (self.passwordTextField.text.length >= 6 && self.rePasswordTextField.text.length >= 6) {
        self.finishButton.alpha = 1;
        self.finishButton.enabled = YES;
    } else {
        self.finishButton.alpha = 0.6;
        self.finishButton.enabled = NO;
    }
}


- (IBAction)finishAction:(UIButton *)sender {
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[LoginAndRegistViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}


@end
