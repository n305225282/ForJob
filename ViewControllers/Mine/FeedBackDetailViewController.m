//
//  FeedBackDetailViewController.m
//  ForJob
//
//  Created by Mac on 2019/6/1.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "FeedBackDetailViewController.h"
#import "FSTextView.h"

@interface FeedBackDetailViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *addPicButton;
@property (weak, nonatomic) IBOutlet FSTextView *feedBackTextView;

@end

@implementation FeedBackDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈与建议";
    self.addPicButton.layer.borderWidth = 0.5f;
    self.addPicButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.feedBackTextView.placeholder = @"请简要描写您的问题和意见,以便我们更好的提供帮助";
    self.feedBackTextView.maxLength = 200;
    self.feedBackTextView.returnKeyType = UIReturnKeyDone;
    self.feedBackTextView.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (IBAction)submitAction:(UIButton *)sender {
    NSLog(@"%@",self.feedBackTextView.text);
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
