//
//  MineViewController.m
//  ForJob
//
//  Created by Mac on 2019/5/24.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeaderView.h"
#import "MineTableViewCell.h"
#import "RecordViewController.h"
#import "UserInfoViewController.h"
#import "FeedBackViewController.h"
#import "AccountSafeViewController.h"
@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    MineHeaderView *contentView = [[NSBundle mainBundle] loadNibNamed:@"MineHeaderView" owner:self options:nil].firstObject;
    __weak MineViewController *weakSelf = self;
  
    UIView *headerView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, self.view.frame.size.width, 300))];
    [headerView addSubview:contentView];
    contentView.sd_layout.leftEqualToView(headerView).rightEqualToView(headerView).topEqualToView(headerView).bottomEqualToView(headerView);
    
    contentView.mineHeadBlock = ^(NSUInteger type) {
        RecordViewController *recordVC = [RecordViewController new];
        if (type == 1) {
            recordVC.title = @"浏览记录";
            NSLog(@"点击了浏览记录");
        } else if (type == 2) {
            recordVC.title = @"收藏记录";
            NSLog(@"点击了收藏记录");
        } else if (type == 0) {
            NSLog(@"点击用户信息");
            UserInfoViewController *userInfoVC = [UserInfoViewController new];
            [weakSelf.navigationController pushViewController:userInfoVC animated:YES];
            return;
        }
        [weakSelf.navigationController pushViewController:recordVC animated:YES];
    };
    self.tableView.tableHeaderView = headerView;
    self.tableView.rowHeight = 80;
    [self.tableView registerNib:[UINib nibWithNibName:@"MineTableViewCell" bundle:nil] forCellReuseIdentifier:@"mineCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineCell" forIndexPath:indexPath];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 1:
        {
            cell.cellTitleLabel.text = @"反馈与帮助";
            cell.iconImageView.image = [UIImage imageNamed:@"fkybz"];
        }
            break;
        case 2:
        {
            cell.cellTitleLabel.text = @"分享收益";
            cell.iconImageView.image = [UIImage imageNamed:@"fxqy"];
        }
            break;
            
        default:
        {
            cell.cellTitleLabel.text = @"安全中心";
            cell.iconImageView.image = [UIImage imageNamed:@"aqzx"];
        }
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 1:
            {
                [self.navigationController pushViewController:[FeedBackViewController new] animated:YES];
            }
            break;
        case 2: {
            
        }
            break;
            
        default:
            [self.navigationController pushViewController:[AccountSafeViewController new] animated:YES];
            break;
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
