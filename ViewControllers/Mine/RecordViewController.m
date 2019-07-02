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

@interface RecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *zhaopinButton;
@property (weak, nonatomic) IBOutlet UIButton *endButton;
@property (weak, nonatomic) IBOutlet UIView *zhaopinSelectView;
@property (weak, nonatomic) IBOutlet UIView *endSelectView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RecordViewController

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
}
- (IBAction)endAction:(UIButton *)sender {
    sender.selected = YES;
    self.endSelectView.hidden = NO;
    self.zhaopinButton.selected = NO;
    self.zhaopinSelectView.hidden = YES;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 148;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[JobDetailViewController new] animated:YES];
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
