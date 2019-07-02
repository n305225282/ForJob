//
//  FeedBackViewController.m
//  ForJob
//
//  Created by Mac on 2019/6/1.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "FeedBackViewController.h"
#import "FeedBackDetailViewController.h"
#import "FeedAndHelpDetailViewController.h"

@interface FeedBackViewController ()
@property (nonatomic, strong) UIButton *feedBackButton;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation FeedBackViewController

- (void)fetchDataList {
    [self.requestManager postRequestWithInterfaceName:@"member/feedBackList" parame:@{} success:^(id  _Nullable respDict, NSString * _Nullable message) {
        self.dataSource = respDict;
        [self.tableView reloadData];
    } fail:^(id  _Nullable error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchDataList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈与帮助";
    self.feedBackButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.feedBackButton setTitle:@"反馈与建议" forState:(UIControlStateNormal)];
    [self.feedBackButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.feedBackButton setBackgroundColor:[UIColor colorWithRed:26/255.0 green:91/255.0 blue:255/255.0 alpha:1]];
    [self.view addSubview:self.feedBackButton];
    self.feedBackButton.layer.cornerRadius = 8;
    [self.feedBackButton addTarget:self action:@selector(feedBackAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.feedBackButton.sd_layout.leftSpaceToView(self.view, 20).rightSpaceToView(self.view, 20).bottomSpaceToView(self.view, 40).heightIs(40);
    self.tableView.sd_layout.topEqualToView(self.view).leftEqualToView(self.view).rightEqualToView(self.view).bottomSpaceToView(self.view, 100);
    self.tableView.rowHeight = (CGRectGetHeight(self.view.frame) - 100) / 8;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [UIView new];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict = self.dataSource[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dataSource[indexPath.row];
    FeedAndHelpDetailViewController *fAhVC = [FeedAndHelpDetailViewController new];
    fAhVC.idField = [[NSString stringWithFormat:@"%@",dict[@"idField"]] integerValue];
    [self.navigationController pushViewController:fAhVC animated:YES];
}


- (void)feedBackAction {
    [self.navigationController pushViewController:[FeedBackDetailViewController new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
