//
//  CDChatViewController.m
//  CDChat
//
//  Created by 吴文海 on 2019/3/7.
//  Copyright © 2019 吴文海. All rights reserved.
//

#import "CDChatViewController.h"

#import "CDChatDefine.h"

#import "CDMessageCell.h"
#import "CDChatInputView.h"

#import "CDChatModel.h"

#import "MJRefresh.h"

#import "VideoInputView.h"

@interface CDChatViewController ()<CDMessageCellDelegate,UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CDChatInputView *inputView;

@property (nonatomic, strong) CDChatModel *chatModel;
@end

@implementation CDChatViewController

#pragma mark - Life Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.tableView];
    CGFloat y = [UIDevice cd_isIPhoneX] ? 88 : 64;
    self.tableView.frame = CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - y - 50);
    
    [self.view addSubview:self.inputView];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(input:)];
//    [self.inputView addGestureRecognizer:tap];
    [self.tableView reloadData];
    
    VideoInputView *view = [[VideoInputView alloc] initWithFrame:(CGRectMake(0, self.view.size.height - 60, self.view.size.width, 60))];
    __weak typeof(self) weakSelf;
    view.audioRecordeBlock = ^(id  _Nonnull data) {
        [self sendData:@{@"type":@(CDMessageTypeVoice),
                             @"voice":data,
                             @"strVoiceTime":@"2s"
                             }];
    };
    [self.view addSubview:view];
    
    
}
#pragma mark - Intial Methods

#pragma mark - Network Methods

#pragma mark - Target Methods
- (void)input: (UIGestureRecognizer *)tap {
    
//    NSDictionary *dic = @{@"strContent": @"乌俄水电费黄金时代粉红色",
//                          @"type": @(CDMessageTypeText)};
    NSDictionary *dic = @{@"voice":@"爱上啊啊啊",@"strVoiceTime":@"4s"};
    [self sendData:dic];
    
}
#pragma mark - Public Methods

#pragma mark - Private Method
- (void)sendData:(NSDictionary *)dic {
    
    [self.chatModel addSpecifiedItem:dic];
    [self.tableView reloadData];
    [self tableViewScrollToBottom];
}

- (void)tableViewScrollToBottom {
    
    if (self.chatModel.dataSource.count == 0) { return; }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chatModel.dataSource.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}
#pragma mark - External Delegate

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.chatModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CDMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CDMessageCell class])];
    cell.delegate = self;
    cell.messageFrame = self.chatModel.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    return [self.chatModel.dataSource[indexPath.row] cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.view endEditing:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

#pragma mark - CDMessageCellDelegate -


#pragma mark - Setter Getter Methods
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame: CGRectZero];
        if (@available(iOS 11, *)) {
            
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        [_tableView registerClass:[CDMessageCell class] forCellReuseIdentifier:NSStringFromClass([CDMessageCell class])];
    }
    return _tableView;
}

- (CDChatModel *)chatModel {
    if (!_chatModel) {
        _chatModel = [[CDChatModel alloc] init];
        [_chatModel populateRandomDataSource];
        [_chatModel addRandomItemsToDataSource:10];
    }
    return _chatModel;
}

- (CDChatInputView *)inputView {
    if (!_inputView) {
        
        _inputView = [[CDChatInputView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, [UIScreen mainScreen].bounds.size.width, 50)];
    }
    return _inputView;
}
@end
