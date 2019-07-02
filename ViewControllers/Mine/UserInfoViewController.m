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
#import "LoginAndRegistViewController.h"


@interface UserInfoViewController ()
@property (nonatomic, strong) NSDictionary *rootDict;
@end

@implementation UserInfoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.requestManager postRequestWithInterfaceName:@"member/eidtMemberInfo" parame:@{@"uuid":GET_UUID,@"token":GET_TOKEN} success:^(id  _Nullable respDict, NSString * _Nullable message) {
        if ([DataCheck isValidDictionary:respDict]) {
            self.rootDict = respDict;
            [self.tableView reloadData];
        } else
            [self showInfoWithMessage:@"获取信息失败"];
    } fail:^(id  _Nullable error) {
        [self showInfoWithMessage:error];
    }];
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
    [button addTarget:self action:@selector(logOutAction) forControlEvents:(UIControlEventTouchUpInside)];
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
            if (self.rootDict) {
                [cell.headImageVIew sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.rootDict[@"header_src"]]]];
            }
            return cell;
        }
            break;
        case 1:
        {
            UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.nameLabel.text = @"昵称";
            if (self.rootDict) {
                cell.detailLabel.text = [NSString stringWithFormat:@"%@",self.rootDict[@"nickname"]];
            }
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            break;
        case 2:
        {
            UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.nameLabel.text = @"生日";
            if (self.rootDict) {
                cell.detailLabel.text = [NSString stringWithFormat:@"%@",self.rootDict[@"birthday"]];
            }
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            break;
        case 3:
        {
            UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.nameLabel.text = @"性别";
            if (self.rootDict) {
                NSString *sex = [NSString stringWithFormat:@"%@",self.rootDict[@"sex"]];
                                 cell.detailLabel.text = sex.integerValue == 1 ? @"男" : @"女";
            }
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            break;
        case 4:
        {
            UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.nameLabel.text = @"电话";
            if (self.rootDict) {
                cell.detailLabel.text = [NSString stringWithFormat:@"%@",self.rootDict[@"mobile"]];
            }
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            break;
        case 5:
        {
            UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.nameLabel.text = @"现居";
            if (self.rootDict) {
                cell.detailLabel.text = [NSString stringWithFormat:@"%@",self.rootDict[@"address"]];
            }
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
    if (showType != -1 && showType != 1) {
        [self.navigationController pushViewController:changeVC animated:YES];
    }
}

- (void)logOutAction {
    [self.requestManager postRequestWithInterfaceName:@"login/signOut" parame:@{@"uuid":[[NSUserDefaults standardUserDefaults] objectForKey:@"uuid"],@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]} success:^(id  _Nullable respDict, NSString * _Nullable message) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"uuid"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
        [UIApplication sharedApplication].keyWindow.rootViewController = [[UINavigationController alloc] initWithRootViewController: [LoginAndRegistViewController new]		];
    } fail:^(id  _Nullable error) {
        [self showInfoWithMessage:error];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
