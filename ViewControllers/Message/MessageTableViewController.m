//
//  MessageTableViewController.m
//  ForJob
//
//  Created by Mac on 2019/5/24.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "MessageTableViewController.h"
#import "MessageMainTableViewCell.h"
#import "CDChatViewController.h"
#import "MessageListModel.h"

@interface MessageTableViewController ()
@property (nonatomic, strong) UIView *seachView;

@property (nonatomic, strong) NSArray<MessageListModel *> *dataSource;
@end

@implementation MessageTableViewController


- (void)creatSeachView {
    self.seachView = [[UIView alloc] init];
    self.seachView.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:self.seachView];
    self.seachView.sd_layout.leftEqualToView(self.navigationController.navigationBar).topSpaceToView(self.navigationController.navigationBar,5).rightEqualToView(self.navigationController.navigationBar).heightIs(40);
    
    UIView *seachBGView = [UIView new];
    seachBGView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    seachBGView.layer.cornerRadius = 20;
    [self.seachView addSubview:seachBGView];
    seachBGView.sd_layout.leftSpaceToView(self.seachView, 10).topEqualToView(self.seachView).bottomEqualToView(self.seachView).widthRatioToView(self.seachView, 0.8);
    
    UIButton *cancleButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [cancleButton setTitle:@"取消" forState:(UIControlStateNormal)];
    [self.seachView addSubview:cancleButton];
    cancleButton.sd_layout.leftSpaceToView(seachBGView, 10).rightSpaceToView(self.seachView, 10).topEqualToView(self.seachView).bottomEqualToView(self.seachView);
    [cancleButton addTarget:self action:@selector(cancleAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void)cancleAction:(id)sender {
    [self.seachView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
//    [self creatSeachView];
    [self.tableView registerNib:[UINib nibWithNibName:@"MessageMainTableViewCell" bundle:nil] forCellReuseIdentifier:@"messageMainCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 100;
 
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchDataSource];
}

- (void)fetchDataSource {
    [self.requestManager postRequestWithInterfaceName:@"index/getOneInfo" parame:@{@"uid":self.appDelegate.userInfoModel.member_id} success:^(id  _Nullable respDict, NSString * _Nullable message) {
        if (![respDict isEqual:[NSNull null]]) {
            NSLog(@"哈哈哈哈");
            self.dataSource = [NSArray yy_modelArrayWithClass:[MessageListModel class] json:respDict];
            [self.tableView reloadData];
        } else {
            NSLog(@"oh no");
        }
    } fail:^(id  _Nullable error) {
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageMainCell" forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self cancleAction:nil];
    self.hidesBottomBarWhenPushed = YES;
    CDChatViewController *chatVC = [CDChatViewController new];
    chatVC.title = self.dataSource[indexPath.row].nickname;
    [self.navigationController pushViewController:chatVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
