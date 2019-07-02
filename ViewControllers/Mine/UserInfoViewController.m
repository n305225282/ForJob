//
//  UserInfoViewController.m
//  ForJob
//
//  Created by Mac on 2019/5/26.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoHeadIconTableViewCell.h"
#import "UserInfoTableViewCell.h"
#import "ChangeInfoViewController.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"UserInfoHeadIconTableViewCell" bundle:nil] forCellReuseIdentifier:@"headCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"UserInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"otherCell"];
    self.tableView.rowHeight = 70;
    self.tableView.sd_layout.bottomSpaceToView(self.view, 100);
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [button setTitle:@"退出登录" forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [bgView addSubview:button];
    button.sd_layout.centerXEqualToView(self.view).heightIs(35).topSpaceToView(bgView, 10).widthIs(100);
    [self.view addSubview:bgView];
    bgView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.tableView,0).bottomEqualToView(self.view);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            UserInfoHeadIconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            return cell;
        }
            break;
        case 1:
        {
            UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.nameLabel.text = @"昵称";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            break;
        case 2:
        {
            UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.nameLabel.text = @"生日";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            break;
        case 3:
        {
            UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.nameLabel.text = @"性别";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            break;
        case 4:
        {
            UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.nameLabel.text = @"电话";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            break;
        case 5:
        {
            UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.nameLabel.text = @"现居";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            break;
            
        default:
            return [UITableViewCell new];
            break;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger showType = -1;
    ChangeInfoViewController *changeVC = [ChangeInfoViewController new];
    switch (indexPath.row) {
        case 1:
        {
            showType = 0;
        }
            break;
        case 4:
        {
            showType = 1;
        }
            break;
        case 5:
        {
            showType = 2;
        }
            break;
            
        default:
            break;
    }
    changeVC.showType = showType;
    if (showType != -1) {
        [self.navigationController pushViewController:changeVC animated:YES];
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
