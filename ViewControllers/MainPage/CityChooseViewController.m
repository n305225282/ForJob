//
//  CityChooseViewController.m
//  ForJob
//
//  Created by Mac on 2019/5/25.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "CityChooseViewController.h"
#import "CityRightTableViewCell.h"
#import <AFHTTPSessionManager.h>

@interface CityChooseViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;

@property (nonatomic, strong) NSArray *leftDataSourceArray;
@property (nonatomic, strong) NSArray *rightDataSourceArray;

@property (nonatomic, strong) NSNumber *selectAid;
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

/// 获取左侧省份接口
- (void)fetchCityDatasource {
    [self.requestManager postRequestWithInterfaceName:@"index/getCity" parame:nil success:^(id  _Nullable respDict, NSString * _Nullable message) {
        if([DataCheck isValidArray:respDict]) {
            self.leftDataSourceArray = respDict;
            [self.leftTableView reloadData];
        } else {
            [self showInfoWithMessage:@"获取城市信息失败"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(id  _Nullable error) {
        [self showInfoWithMessage:@"获取城市信息失败"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

/// 增加热门城市接口
- (void)addCityFindNumWithId:(NSString *)idParams {
    [self.requestManager postRequestWithInterfaceName:@"index/addCityFindNum" parame:@{@"id":idParams} success:^(id  _Nullable respDict, NSString * _Nullable message) {
        
    } fail:^(id  _Nullable error) {
        
    }];
}


- (void)fetchCityWithId:(NSString *)cityId {
    [self.rightTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self.requestManager postRequestWithInterfaceName:@"index/getAddress" parame:@{@"id":cityId} success:^(id  _Nullable respDict, NSString * _Nullable message) {
        if([DataCheck isValidArray:respDict]) {
            self.selectAid = respDict[0][@"aid"];
            self.rightDataSourceArray = respDict;
            [self.rightTableView reloadData];
        } else {
            [self showInfoWithMessage:@"获取城市信息失败"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(id  _Nullable error) {
        [self showInfoWithMessage:@"获取城市信息失败"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择城市";
    
    
    [self.view sd_addSubviews:@[self.leftTableView,self.rightTableView]];
    self.leftTableView.sd_layout.leftEqualToView(self.view).topEqualToView(self.view).bottomEqualToView(self.view).widthRatioToView(self.view, 0.34);
    self.rightTableView.sd_layout.leftSpaceToView(self.leftTableView, 0).rightEqualToView(self.view).topEqualToView(self.view).bottomEqualToView(self.view);
    
    [self fetchCityDatasource];
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
        return self.leftDataSourceArray.count + 1;
    } else if (tableView == self.rightTableView) {
        return self.rightDataSourceArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell" forIndexPath:indexPath];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        if (indexPath.row == 0) {
            cell.textLabel.text = @"热门";
        } else {
            cell.textLabel.text = self.leftDataSourceArray[indexPath.row - 1][@"name"];
        }
        return cell;
    } else if (tableView == self.rightTableView) {
        CityRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell" forIndexPath:indexPath];
        cell.cityNameLabel.text = self.rightDataSourceArray[indexPath.row][@"name"];
        if ([self.rightDataSourceArray[indexPath.row][@"aid"] isEqual:self.selectAid]) {
            cell.isSelected = YES;
        } else {
            cell.isSelected = NO;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.leftTableView) {
        NSLog(@"左边点击了：%ld",indexPath.row);
        if (indexPath.row > 0) {
            [self fetchCityWithId:self.leftDataSourceArray[indexPath.row - 1][@"cid"]];
        }
    } else if (tableView == self.rightTableView) {
        NSLog(@"右边点击了:%ld",indexPath.row);
        self.selectAid = self.rightDataSourceArray[indexPath.row][@"aid"];
        [[NSUserDefaults standardUserDefaults] setObject:self.rightDataSourceArray[indexPath.row][@"name"] forKey:@"city"];
        [tableView reloadData];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
