//
//  FilterViewController.m
//  ForJob
//
//  Created by Mac on 2019/5/25.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "FilterViewController.h"
#import "CFMacro.h"
#import "CFMultistageDropdownMenuView.h"
#import "MainPageTableViewCell.h"
#import "MainPageModel.h"


@interface FilterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) CFMultistageDropdownMenuView *multistageDropdownMenuView;
@end

@implementation FilterViewController

- (void)fetchData {
    [[HttpHelper sharedHttpHelper] postRequestWithInterfaceName:@"index/getCategoryPost" parame:@{@"id":@(self.filterId)} success:^(id  _Nullable respDict, NSString * _Nullable message) {
        self.dataSource = [NSArray yy_modelArrayWithClass:[MainPageModel class] json:respDict[@"joblist"]];
        [self.tableView reloadData];
    } fail:^(id  _Nullable error) {
        
    }];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 配置CFDropDownMenuView
    [self.view addSubview:self.multistageDropdownMenuView];
    
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








/* 配置CFDropDownMenuView */
- (CFMultistageDropdownMenuView *)multistageDropdownMenuView
{
    // DEMO
    _multistageDropdownMenuView = [[CFMultistageDropdownMenuView alloc] initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight, CFScreenWidth, 44)];
    
    _multistageDropdownMenuView.defaulTitleArray = [NSArray arrayWithObjects:@"行业分类",@"金额", @"排序", nil];
    
    // 注:  数据源一般由网络请求
    // 格式参照如下 - 一般后台返回的格式如此
    NSArray *leftArr = @[
                         // 二级菜单 的 一级菜单
                         @[@"全部分类", @"前端", @"后台", @"设计"],
                         // 一级菜单
                         @[],
                         // 一级菜单
                         @[]
                         ];
    NSArray *rightArr = @[
                          // 对应dataSourceLeftArray
                          @[
                              // 二级菜单 的 二级菜单
                              // 全部分类
                              @[@"全部"],
                              // 特色餐饮
                              @[@"iOS",@"Android",@"web"],
                              // 服装鞋包
                              @[@"Java", @"PHP"],
                              // 美容养生
                              @[@"UI设计师", @"美工"]
                              ],
                          @[
                              // 一级菜单
                              // 金额
                              @[@"全部", @"一万以下", @"1-5万", @"5-10万", @"10-15万", @"15-20万", @"20万以上"]
                              ],
                          @[
                              // 一级菜单
                              // 排序
                              @[@"全部", @"最新发布"]
                              ]
                          
                          ];
    
    [_multistageDropdownMenuView setupDataSourceLeftArray:leftArr.mutableCopy rightArray:rightArr.mutableCopy];
    
    _multistageDropdownMenuView.delegate = self;
    
    // 下拉列表 起始y
    _multistageDropdownMenuView.startY = CGRectGetMaxY(_multistageDropdownMenuView.frame);
    
    //    _multistageDropdownMenuView.maxRowCount = 3;
    _multistageDropdownMenuView.stateConfigDict = @{
                                                    //                                         @"selected" : @[[UIColor purpleColor], @"测试紫箭头"],
                                                    //                                         @"normal" : @[[UIColor redColor], @"测试红箭头"]
                                                    };
    
    
    
    
    return _multistageDropdownMenuView;
    
}

#pragma mark - CFMultistageDropdownMenuViewDelegate
- (void)multistageDropdownMenuView:(CFMultistageDropdownMenuView *)multistageDropdownMenuView selecteTitleButtonIndex:(NSInteger)titleButtonIndex conditionLeftIndex:(NSInteger)leftIndex conditionRightIndex:(NSInteger)rightIndex
{
    
    
    NSString *str = [NSString stringWithFormat:@"(都是从0开始)\n 当前选中是 第%zd个title按钮, 一级条件索引是%zd,  二级条件索引是%zd",titleButtonIndex, leftIndex, rightIndex];
    
    NSString *titleStr = [multistageDropdownMenuView.defaulTitleArray objectAtIndex:titleButtonIndex];
    NSArray *leftArr = [multistageDropdownMenuView.dataSourceLeftArray objectAtIndex:titleButtonIndex];
    NSArray *rightArr = [multistageDropdownMenuView.dataSourceRightArray objectAtIndex:titleButtonIndex];
    NSString *leftStr = @"";
    NSString *rightStr = @"";
    NSString *str2 = @"";
    if (leftArr.count>0) { // 二级菜单
        leftStr = [leftArr objectAtIndex:leftIndex];
        NSArray *arr = [rightArr objectAtIndex:leftIndex];
        rightStr = [arr objectAtIndex:rightIndex];
        str2 = [NSString stringWithFormat:@"当前选中的是 \"%@\" 分类下的 \"%@\"-\"%@\"", titleStr, leftStr, rightStr];
    } else {
        rightStr = [rightArr[0] objectAtIndex:rightIndex];
        str2 = [NSString stringWithFormat:@"当前选中的是 \"%@\" 分类下的 \"%@\"", titleStr, rightStr];
    }
    
    NSMutableString *mStr22 = [NSMutableString stringWithFormat:@" "];
    NSArray *btnArr = multistageDropdownMenuView.titleButtonArray;
    for (UIButton *btn in btnArr) {
        [mStr22 appendString:[NSString stringWithFormat:@"\"%@\"", btn.titleLabel.text]];
        [mStr22 appendString:@" "];
    }
    NSString *str22 = [NSString stringWithFormat:@"当前展示的所有条件是:\n (%@)", mStr22];
    
    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注: 当下拉菜单选项为一级菜单时, 一级条件索引肯定是0" message:str preferredStyle:UIAlertControllerStyleAlert];
//    [self presentViewController:alertController animated:NO completion:^{
//        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//            UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:str22 message:str2 preferredStyle:UIAlertControllerStyleAlert];
//            [self presentViewController:alertController2 animated:NO completion:^{
//                UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//                }];
//                [alertController2 addAction:alertAction2];
//            }];
//
//        }];
//        [alertController addAction:alertAction];
//    }];
    
    
}

- (void)multistageDropdownMenuView:(CFMultistageDropdownMenuView *)multistageDropdownMenuView selectTitleButtonWithCurrentTitle:(NSString *)currentTitle currentTitleArray:(NSArray *)currentTitleArray
{
    NSMutableString *mStr = [NSMutableString stringWithFormat:@" "];
    
    for (NSString *str in currentTitleArray) {
        [mStr appendString:[NSString stringWithFormat:@"\"%@\"", str]];
        [mStr appendString:@" "];
    }
    NSString *str = [NSString stringWithFormat:@"当前选中的是 \"%@\" \n 当前展示的所有条件是:\n (%@)",currentTitle, mStr];
    
    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"第二个代理方法" message:str preferredStyle:UIAlertControllerStyleAlert];
//    [self presentViewController:alertController animated:NO completion:^{
//        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//            
//        }];
//        [alertController addAction:alertAction];
//    }];
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
