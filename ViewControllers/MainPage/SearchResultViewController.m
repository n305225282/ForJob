//
//  SearchResultViewController.m
//  ForJob
//
//  Created by 宇宇宇哲 on 2019/7/6.
//  Copyright © 2019 Arther. All rights reserved.
//

#import "SearchResultViewController.h"
#import "MainPageTableViewCell.h"
#import "JobDetailViewController.h"
#import "MainPageModel.h"


@interface SearchResultViewController ()
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"MainPageTableViewCell" bundle:nil] forCellReuseIdentifier:@"mainCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 148;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.dataSource.count;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainCell" forIndexPath:indexPath];
//    MainPageModel *model = self.dataSource[indexPath.row];
//    cell.model = model;
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    self.hidesBottomBarWhenPushed = YES;
//    MainPageModel *model = self.dataSource[indexPath.row];
//    JobDetailViewController *jobDetailVC = [JobDetailViewController new];
//    jobDetailVC.jobId = model.idField;
//    [self.navigationController pushViewController:jobDetailVC animated:YES];
//    self.hidesBottomBarWhenPushed = NO;
}
@end
