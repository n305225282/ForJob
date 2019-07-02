//
//  CityChooseViewController.m
//  ForJob
//
//  Created by Mac on 2019/5/25.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "CityChooseViewController.h"
#import "CityRightTableViewCell.h"

@interface CityChooseViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@end

@implementation CityChooseViewController

- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
        _leftTableView.backgroundColor = [UIColor whiteColor];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        [_leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"leftCell"];
        _leftTableView.tableFooterView = [UIView new];
    }
    return _leftTableView;
}

- (UITableView *)rightTableView {
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
        _rightTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_rightTableView registerNib:[UINib nibWithNibName:@"CityRightTableViewCell" bundle:nil] forCellReuseIdentifier:@"rightCell"];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.tableFooterView = [UIView new];
    }
    return _rightTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择城市";
    
    
    [self.view sd_addSubviews:@[self.leftTableView,self.rightTableView]];
    self.leftTableView.sd_layout.leftEqualToView(self.view).topEqualToView(self.view).bottomEqualToView(self.view).widthRatioToView(self.view, 0.34);
    self.rightTableView.sd_layout.leftSpaceToView(self.leftTableView, 0).rightEqualToView(self.view).topEqualToView(self.view).bottomEqualToView(self.view);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (tableView == self.leftTableView) {
        return 60;
    }
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return 10;
    } else if (tableView == self.rightTableView) {
        return 20;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell" forIndexPath:indexPath];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.text = @"热门";
        return cell;
    } else if (tableView == self.rightTableView) {
        CityRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell" forIndexPath:indexPath];
        return cell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.leftTableView) {
        NSLog(@"左边点击了：%ld",indexPath.row);
    } else if (tableView == self.rightTableView) {
        NSLog(@"右边点击了:%ld",indexPath.row);
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
