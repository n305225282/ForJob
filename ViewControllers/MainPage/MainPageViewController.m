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
#import <PYSearch/PYSearch.h>
#import "SearchResultViewController.h"
#import <GKCover/GKCover.h>
#import "View.h"
#import "LoginAndRegistViewController.h"
#import "WechatShareManager.h"

@interface MainPageViewController ()
@property (nonatomic, strong) MainPageViewModel *viewModel;
@property (nonatomic, strong) MainHeaderView *contentView;
@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"职位";
    __weak MainPageViewController *weakSelf = self;
    
    self.viewModel = [[MainPageViewModel alloc] init];
    self.viewModel.bindView = self.tableView;
    self.contentView = [[NSBundle mainBundle] loadNibNamed:@"MainHeaderView" owner:self options:nil].firstObject;
    
    
    self.contentView.seachBlock = ^{
        PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:nil searchBarPlaceholder:@"搜索职位" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
            if (searchText.length > 0) {
                SearchResultViewController *searchResultVC = [SearchResultViewController new];
                searchResultVC.keyWords = searchText;
//                self.keywords = searchText;
                [weakSelf.navigationController pushViewController:searchResultVC animated:YES];
            }
            [searchViewController dismissViewControllerAnimated:YES completion:nil];
            
        }];
        [searchViewController setShowHotSearch:NO];
        [searchViewController setSearchHistoryStyle:(PYSearchHistoryStyleBorderTag)];
        // 3. present the searchViewController
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
        [weakSelf presentViewController:nav  animated:NO completion:nil];
    };
    
    
    //点击求职类型
    self.contentView.clickFilterButtonBlock = ^(NSString *title) {
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
    self.contentView.clickLocationButtonBlock = ^(NSString *title) {
        CityChooseViewController *chooseVC = [CityChooseViewController new];
        weakSelf.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:chooseVC animated:YES];
        weakSelf.hidesBottomBarWhenPushed = NO;
    };
    UIView *headerView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, self.view.frame.size.width, 200))];
    headerView.backgroundColor = self.contentView.backgroundColor;
    [self setStatusBarBackgroundColor:self.contentView.backgroundColor];
    [headerView addSubview:self.contentView];
    self.contentView.sd_layout.leftEqualToView(headerView).rightEqualToView(headerView).topEqualToView(headerView).bottomEqualToView(headerView);
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
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"token"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"uuid"]) {
        [self.requestManager postRequestWithInterfaceName:@"member/getUsInfo" parame:@{@"uuid":GET_UUID,@"token":GET_TOKEN} success:^(id  _Nullable respDict, NSString * _Nullable message) {
            if ([DataCheck isValidDictionary:respDict]) {
                self.appDelegate.userInfoModel = [UserInfoModel yy_modelWithJSON:respDict];
                if (self.appDelegate.userInfoModel.member_id == nil || self.appDelegate.userInfoModel.member_id.length < 1) {
                    
                    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:[LoginAndRegistViewController new]];
                    UIApplication.sharedApplication.keyWindow.rootViewController = navC;
                    
                }
            } else {
                [self showInfoWithMessage:@"获取用户信息失败"];
            }
        } fail:^(id  _Nullable error) {
            [self showInfoWithMessage:error];
        }];
    }
    
    
    [self setStatusBarBackgroundColor:self.tableView.tableHeaderView.backgroundColor];
    NSNumber *aid = [[NSUserDefaults standardUserDefaults] objectForKey:@"cityId"];
    NSDictionary *param = @{};
    if (aid) {
        param = @{@"level_id":aid};
    } else {
        param = @{@"level_id":@(878)};
    }
    [self.viewModel fetchDataWithParams:param];
    NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
    [self.contentView.cityButton setTitle:city.length > 0 ? city : @"上海市" forState:(UIControlStateNormal)];
    
    __weak MainPageViewController *weakSelf = self;
    self.viewModel.HandleBlock = ^(NSDictionary *modelDic) {
        View *view = [[NSBundle mainBundle] loadNibNamed:@"View" owner:weakSelf options:nil].lastObject;
        view.shareBlock = ^{
            if ([WechatShareManager isWXAppInstalled]) {
                [weakSelf.requestManager postRequestWithInterfaceName:@"index/addShare" parame:@{@"member_id":weakSelf.appDelegate.userInfoModel.member_id} success:^(id  _Nullable respDict, NSString * _Nullable message) {
                    [WechatShareManager shareToWechatWithWebTitle:@"蓝帝好工作" description:modelDic[@"content"] thumbImage:[UIImage imageNamed:@"logo"] webpageUrl:modelDic[@"link"] type:0];
                } fail:^(id  _Nullable error) {
                    
                }];
            } else {
                [weakSelf showInfoWithMessage:@"未检测到微信"];
            }
            [GKCover hide];
        };
        
        [GKCover coverFrom:weakSelf.view contentView:view style:(GKCoverStyleTranslucent) showStyle:(GKCoverShowStyleCenter) showAnimStyle:(GKCoverShowAnimStyleCenter) hideAnimStyle:(GKCoverHideAnimStyleCenter) notClick:NO showBlock:^{
            
        } hideBlock:^{
            
        }];
    };
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
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"token"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"uuid"]) {
        self.hidesBottomBarWhenPushed = YES;
        MainPageModel *model = self.viewModel.dataSource[indexPath.row];
        JobDetailViewController *jobDetailVC = [JobDetailViewController new];
        jobDetailVC.jobId = model.idField;
        [self.navigationController pushViewController:jobDetailVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    } else {
        [self.navigationController pushViewController:[LoginAndRegistViewController new] animated:YES];
    }
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
