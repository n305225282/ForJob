//
//  FilterViewController.m
//  ForJob
//
//  Created by Mac on 2019/5/25.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "FilterViewController.h"
#import "CFMacro.h"
#import <CFDropDownMenuView/CFDropDownMenuView.h>
#import "MainPageTableViewCell.h"
#import "MainPageModel.h"
#import "JobDetailViewController.h"


@interface FilterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) CFDropDownMenuView *multistageDropdownMenuView;
@property (nonatomic, strong) NSArray *classifyDataArray;
@property (nonatomic, strong) NSMutableArray *classfyTitleArray;
@property (nonatomic, strong) NSArray *salaryArray;
@property (nonatomic, strong) NSArray *lastArray;

@property (nonatomic, strong) NSNumber *classifyNumber;
@property (nonatomic, assign) NSInteger salarySelectIndex;
@property (nonatomic, assign) NSInteger lastSelectIndex;
@end

@implementation FilterViewController

- (void)fetchDataWithParam:(NSDictionary *)params {
    NSMutableDictionary *mParams = [NSMutableDictionary dictionaryWithDictionary:params];
    [mParams setObject:@(self.filterId) forKey:@"id"];
    NSNumber *aid = [[NSUserDefaults standardUserDefaults] objectForKey:@"cityId"];
    if (aid) {
        [mParams setObject:aid forKey:@"level_id"];
    } else {
        [mParams setObject:@(878) forKey:@"level_id"];
    }
    [[HttpHelper sharedHttpHelper] postRequestWithInterfaceName:@"index/getCategoryPost" parame:mParams success:^(id  _Nullable respDict, NSString * _Nullable message) {
        self.dataSource = [NSArray yy_modelArrayWithClass:[MainPageModel class] json:respDict[@"joblist"]];
        [self.tableView reloadData];
    } fail:^(id  _Nullable error) {
        
    }];
}

- (void)fetchtClassify {
    [self showLodingWithMessage:@""];
    [self.requestManager postRequestWithInterfaceName:@"index/postRange" parame:@{} success:^(id  _Nullable respDict, NSString * _Nullable message) {
        [self hideLoding];
        NSLog(@"%@",respDict);
        if (respDict) {
            self.classifyDataArray = respDict;
            if ([DataCheck isValidArray:self.classifyDataArray]) {
                self.classfyTitleArray = [NSMutableArray array];
                for (int i = 0; i < self.classifyDataArray.count; i++) {
                    NSDictionary *dict = self.classifyDataArray[i];
                    [self.classfyTitleArray addObject:dict[@"post_name"]];
                }
                self.multistageDropdownMenuView.dataSourceArr = @[
                                                                  self.classfyTitleArray,
                                                                  self.salaryArray,
                                                                  self.lastArray,
                                                                  ].mutableCopy;
                self.multistageDropdownMenuView.defaulTitleArray = @[@"行业分类",@"薪酬",@"排序"];
            }
            [self fetchDataWithParam:@{}];
        }
    } fail:^(id  _Nullable error) {
        
    }];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchDataWithParam:@{}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchtClassify];
    self.multistageDropdownMenuView = [[CFDropDownMenuView alloc] initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight, CFScreenWidth, 44)];
    [self.view addSubview:self.multistageDropdownMenuView];
    // 下拉列表 起始y
    self.multistageDropdownMenuView.startY = CGRectGetMaxY(self.multistageDropdownMenuView.frame);
    __weak typeof(self) weakSelf = self;
    self.multistageDropdownMenuView.chooseConditionBlock = ^(NSString *title, NSArray *titleArr,NSUInteger index) {
        NSUInteger selectIndex = -1;
        NSInteger titleIndex = -1;
        if ([weakSelf.classfyTitleArray containsObject:title]) {
            titleIndex = 0;
            selectIndex = [weakSelf.classfyTitleArray indexOfObject:title];
        } else if ([weakSelf.salaryArray containsObject:title]) {
            titleIndex = 1;
            selectIndex = [weakSelf.salaryArray indexOfObject:title];
        } else {
            titleIndex = 2;
            selectIndex = [weakSelf.lastArray indexOfObject:title];
        }
        NSDictionary *param = @{};
        if (titleIndex == 0) {
            NSNumber *id_field = weakSelf.classifyDataArray[selectIndex][@"idField"];
            weakSelf.classifyNumber = id_field;
            param = @{@"post_type":weakSelf.classifyNumber,@"wage":@(weakSelf.salarySelectIndex),@"desc":@(weakSelf.lastSelectIndex)};
            NSLog(@"哈哈%@",id_field);
        } else if (titleIndex == 1) {
            NSLog(@"嗯嗯嗯呃%ld",selectIndex);
            weakSelf.salarySelectIndex = selectIndex;
            if (weakSelf.classifyNumber) {
                param = @{@"post_type":weakSelf.classifyNumber,@"wage":@(weakSelf.salarySelectIndex),@"desc":@(weakSelf.lastSelectIndex)};
            } else {
                param = @{@"wage":@(weakSelf.salarySelectIndex),@"desc":@(weakSelf.lastSelectIndex)};
            }
        } else if (titleIndex == 2) {
            weakSelf.lastSelectIndex = selectIndex;
            if (weakSelf.classifyNumber) {
                param = @{@"post_type":weakSelf.classifyNumber,@"wage":@(weakSelf.salarySelectIndex),@"desc":@(weakSelf.lastSelectIndex)};
            } else {
                param = @{@"wage":@(weakSelf.salarySelectIndex),@"desc":@(weakSelf.lastSelectIndex)};
            }
        }
        [weakSelf fetchDataWithParam:param];
    };
    
    
    UIView *sepView = [UIView new];
    sepView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:sepView];
    sepView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.multistageDropdownMenuView, 0).heightIs(1);

    
    
    self.tableView = [[UITableView alloc] initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(sepView, 0).bottomEqualToView(self.view);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 148;
    [self.tableView registerNib:[UINib nibWithNibName:@"MainPageTableViewCell" bundle:nil] forCellReuseIdentifier:@"mainCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainCell" forIndexPath:indexPath];
    MainPageModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MainPageModel *model = self.dataSource[indexPath.row];
    JobDetailViewController *jobDetailVC = [JobDetailViewController new];
    jobDetailVC.jobId = model.idField;
    [self.navigationController pushViewController:jobDetailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)salaryArray {
    if (!_salaryArray) {
        _salaryArray = @[@"全部",@"3K以下",@"3-5K",@"5-10K",@"10K以上"];
    }
    return _salaryArray;
}

- (NSArray *)lastArray {
    if (!_lastArray) {
        _lastArray = @[@"最新",@"推荐"];
    }
    return _lastArray;
}
@end
