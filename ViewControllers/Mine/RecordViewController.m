//
//  RecordViewController.m
//  ForJob
//
//  Created by Mac on 2019/5/26.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "RecordViewController.h"
#import "MainPageTableViewCell.h"
#import "JobDetailViewController.h"
#import "MainPageModel.h"

@interface RecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *zhaopinButton;
@property (weak, nonatomic) IBOutlet UIButton *endButton;
@property (weak, nonatomic) IBOutlet UIView *zhaopinSelectView;
@property (weak, nonatomic) IBOutlet UIView *endSelectView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation RecordViewController


- (void)fetchDataList {
    if ([self.title containsString:@"浏览"]) {
        [self.requestManager postRequestWithInterfaceName:@"member/browseList" parame:@{@"uuid":GET_UUID,@"token":GET_TOKEN,@"type":self.zhaopinButton.isSelected ? @"1" : @"2"} success:^(id  _Nullable respDict, NSString * _Nullable message) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[MainPageModel class] json:respDict];
            [self.tableView reloadData];
        } fail:^(id  _Nullable error) {
            
        }];
    } else {
        [self.requestManager postRequestWithInterfaceName:@"member/collectList" parame:@{@"uuid":GET_UUID,@"token":GET_TOKEN,@"type":self.zhaopinButton.isSelected ? @"1" : @"2"} success:^(id  _Nullable respDict, NSString * _Nullable message) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[MainPageModel class] json:respDict];
            [self.tableView reloadData];
        } fail:^(id  _Nullable error) {
            
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchDataList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zhaopinButton.selected = YES;
    self.zhaopinSelectView.hidden = NO;
    self.endButton.selected = NO;
    self.endSelectView.hidden = YES;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MainPageTableViewCell" bundle:nil] forCellReuseIdentifier:@"mainCell"];
}
- (IBAction)zhaopinAction:(UIButton *)sender {
    sender.selected = YES;
    self.zhaopinSelectView.hidden = NO;
    self.endButton.selected = NO;
    self.endSelectView.hidden = YES;
    [self fetchDataList];
}
- (IBAction)endAction:(UIButton *)sender {
    sender.selected = YES;
    self.endSelectView.hidden = NO;
    self.zhaopinButton.selected = NO;
    self.zhaopinSelectView.hidden = YES;
    [self fetchDataList];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 148;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.hidesBottomBarWhenPushed = YES;
    JobDetailViewController *jobDetailVC = [JobDetailViewController new];
    MainPageModel *model = self.dataSource[indexPath.row];
    jobDetailVC.jobId = model.idField;
    [self.navigationController pushViewController:jobDetailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
