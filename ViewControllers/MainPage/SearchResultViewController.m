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
#import "MainPageViewModel.h"


@interface SearchResultViewController ()
@property (nonatomic, strong) MainPageViewModel *mainPageVM;
@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.keyWords;
    [self.tableView registerNib:[UINib nibWithNibName:@"MainPageTableViewCell" bundle:nil] forCellReuseIdentifier:@"mainCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self fetchSearchResult];
}

- (void)fetchSearchResult {
    [self.mainPageVM fetchDataWithParams:@{@"name_like":self.keyWords}];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 148;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mainPageVM.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainCell" forIndexPath:indexPath];
    MainPageModel *model = self.mainPageVM.dataSource[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.hidesBottomBarWhenPushed = YES;
    MainPageModel *model = self.mainPageVM.dataSource[indexPath.row];
    JobDetailViewController *jobDetailVC = [JobDetailViewController new];
    jobDetailVC.jobId = model.idField;
    [self.navigationController pushViewController:jobDetailVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


- (MainPageViewModel *)mainPageVM {
    if (!_mainPageVM) {
        _mainPageVM = [MainPageViewModel new];
        _mainPageVM.bindView = self.tableView;
    }
    return _mainPageVM;
}
@end
