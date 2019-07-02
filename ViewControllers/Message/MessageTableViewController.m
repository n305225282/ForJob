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

@interface MessageTableViewController ()
@property (nonatomic, strong) UIView *seachView;
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
    [self creatSeachView];
    [self.tableView registerNib:[UINib nibWithNibName:@"MessageMainTableViewCell" bundle:nil] forCellReuseIdentifier:@"messageMainCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 100;
    
    
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageMainCell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self cancleAction:nil];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[CDChatViewController new] animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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
