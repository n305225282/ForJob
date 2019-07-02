//
//  MainPageViewController.m
//  ForJob
//
//  Created by Mac on 2019/5/24.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "MainPageViewController.h"
#import "MainPageViewModel.h"
#import "MainPageTableViewCell.h"
#import "MainHeaderView.h"
#import "FilterViewController.h"
#import "JobDetailViewController.h"
#import "CityChooseViewController.h"
#import "MainPageModel.h"

@interface MainPageViewController ()
@property (nonatomic, strong) MainPageViewModel *viewModel;
@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"职位";
    self.viewModel = [[MainPageViewModel alloc] init];
    self.viewModel.bindView = self.tableView;
    MainHeaderView *contentView = [[NSBundle mainBundle] loadNibNamed:@"MainHeaderView" owner:self options:nil].firstObject;
    __weak MainPageViewController *weakSelf = self;
    
    //点击求职类型
    contentView.clickFilterButtonBlock = ^(NSString *title) {
        FilterViewController *filterVC = [FilterViewController new];
        if ([title containsString:@"民企"]) {
            filterVC.filterId = 1;
        } else if ([title containsString:@"日结"]) {
            filterVC.filterId = 2;
        } else if ([title containsString:@"兼职"]) {
            filterVC.filterId = 3;
        } else {
            filterVC.filterId = 4;
        }
        filterVC.title = title;
        weakSelf.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:filterVC animated:YES];
        weakSelf.hidesBottomBarWhenPushed = NO;
    };
    
    //点击左上角城市
    contentView.clickLocationButtonBlock = ^(NSString *title) {
        CityChooseViewController *chooseVC = [CityChooseViewController new];
        weakSelf.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:chooseVC animated:YES];
        weakSelf.hidesBottomBarWhenPushed = NO;
    };
    UIView *headerView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, self.view.frame.size.width, 200))];
    headerView.backgroundColor = contentView.backgroundColor;
    [self setStatusBarBackgroundColor:contentView.backgroundColor];
    [headerView addSubview:contentView];
    contentView.sd_layout.leftEqualToView(headerView).rightEqualToView(headerView).topEqualToView(headerView).bottomEqualToView(headerView);
    self.tableView.tableHeaderView = headerView;
    [self.tableView registerNib:[UINib nibWithNibName:@"MainPageTableViewCell" bundle:nil] forCellReuseIdentifier:@"mainCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}
/**
 设置状态栏背景颜色
 
 @param color 设置颜色
 */
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self setStatusBarBackgroundColor:[UIColor whiteColor]];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self setStatusBarBackgroundColor:self.tableView.tableHeaderView.backgroundColor];
    [self.viewModel fetchData];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    UILabel *label = [UILabel new];
    label.text = @"推荐职位";
    [view addSubview:label];
    label.sd_layout.leftSpaceToView(view, 23).centerYEqualToView(view).autoHeightRatio(0).widthIs(80);
    UIView *sepView = [UIView new];
    sepView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [view addSubview:sepView];
    sepView.sd_layout.leftEqualToView(view).rightEqualToView(view).bottomEqualToView(view).heightIs(0.5);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 148;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainCell" forIndexPath:indexPath];
    MainPageModel *model = self.viewModel.dataSource[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.hidesBottomBarWhenPushed = YES;
    MainPageModel *model = self.viewModel.dataSource[indexPath.row];
    JobDetailViewController *jobDetailVC = [JobDetailViewController new];
    jobDetailVC.jobId = model.idField;
    [self.navigationController pushViewController:jobDetailVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        if (scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= 30) {
            
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            
        }else if (scrollView.contentOffset.y >= 30){
            
            scrollView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
            
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
