//
//  SharedRecordsViewController.m
//  ForJob
//
//  Created by 宇宇宇哲 on 2019/8/14.
//  Copyright © 2019 Arther. All rights reserved.
//

#import "SharedRecordsViewController.h"

@interface SharedRecordsViewController ()
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation SharedRecordsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.requestManager postRequestWithInterfaceName:@"index/getShareList" parame:@{@"member_id":self.appDelegate.userInfoModel.member_id} success:^(id  _Nullable respDict, NSString * _Nullable message) {
        NSLog(@"%@",respDict);
        self.dataSource = respDict;
        if (self.dataSource.count > 0) {
            [self.tableView reloadData];
        }
    } fail:^(id  _Nullable error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分享收益";
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 50;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    // Do any additional setup after loading the view.
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    NSDictionary *modelDic = self.dataSource[indexPath.row];
    cell.textLabel.text = modelDic[@"dt"];
    UILabel *label = [UILabel new];
    [cell.contentView addSubview:label];
    label.sd_layout.rightSpaceToView(cell.contentView, 20).centerYEqualToView(cell.contentView).widthIs(80).heightIs(20);
    label.text = modelDic[@"state"];
    return cell;
}
@end
