//
//  AccountSafeViewController.m
//  ForJob
//
//  Created by Mac on 2019/6/1.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "AccountSafeViewController.h"
#import "SetNewPhoneNumberViewController.h"
#import "SetPasswordViewController.h"

@interface AccountSafeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AccountSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.bounces = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 60;
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"我的账号";
        UILabel *phoneNumberLabel = [UILabel new];
        [cell addSubview:phoneNumberLabel];
        phoneNumberLabel.text = [NSString stringWithFormat:@"%@xxxxxxxx",[self.appDelegate.userInfoModel.mobile substringToIndex:3]];
        phoneNumberLabel.font = [UIFont systemFontOfSize:14];
        phoneNumberLabel.textColor = [UIColor lightGrayColor];
        phoneNumberLabel.sd_layout.rightSpaceToView(cell, 20).heightIs(30).widthIs(100).centerYEqualToView(cell);
    } else {
        cell.textLabel.text = @"设置密码";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[SetNewPhoneNumberViewController new] animated:YES];
    } else {
        [self.navigationController pushViewController:[SetPasswordViewController new] animated:YES];
    }
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
