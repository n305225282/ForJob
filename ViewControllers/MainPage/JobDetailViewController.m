//
//  JobDetailViewController.m
//  ForJob
//
//  Created by Mac on 2019/5/25.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "JobDetailViewController.h"
#import "MapViewController.h"

#import "JobInfoTableViewCell.h"
#import "JobLocationTableViewCell.h"
#import "JobDetailTableViewCell.h"
#import "JobCompanyTableViewCell.h"
#import "JobWebViewTableViewCell.h"

#import "JobDetailModel.h"
#import "CDChatViewController.h"


@interface JobDetailViewController ()
@property (nonatomic, strong) JobDetailModel *jobDetailModel;

@property (nonatomic, assign) CGFloat detailHeight;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIButton *makePhoneCallButton;

@property (nonatomic, strong) UIButton *goChatButton;
@end

@implementation JobDetailViewController

- (void)fetchData {
    [[HttpHelper sharedHttpHelper] postRequestWithInterfaceName:@"index/jobDetail" parame:@{@"id":@(self.jobId)} success:^(id  _Nullable respDict, NSString * _Nullable message) {
        self.jobDetailModel = [JobDetailModel yy_modelWithJSON:respDict[@"joblist"][0]];
        [self.tableView reloadData];
    } fail:^(id  _Nullable error) {
        [self showInfoWithMessage:error];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchData];
    self.tableView.sd_resetLayout.leftEqualToView(self.view).topEqualToView(self.view).rightEqualToView(self.view).bottomSpaceToView(self.view,60+TabbarSafeBottomMargin);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"职位详情";
    
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:@"JobInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"jobInfoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"JobLocationTableViewCell" bundle:nil] forCellReuseIdentifier:@"locationCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"JobDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"detailCell"];
    [self.tableView registerClass:[JobWebViewTableViewCell class] forCellReuseIdentifier:@"webCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"JobCompanyTableViewCell" bundle:nil] forCellReuseIdentifier:@"companyCell"];
    self.tableView.tableFooterView = [UIView new];
    self.detailHeight = 375;
    
    
    [self.view addSubview:self.bottomView];
    [self.view bringSubviewToFront:self.bottomView];
    self.bottomView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomSpaceToView(self.view, TabbarSafeBottomMargin).heightIs(60);
    
}

- (void)makePhoneCallButtonAction {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",self.jobDetailModel.mobile]]];
}


- (void)goChatButtonAction {
    CDChatViewController *chatVC = [CDChatViewController new];
    chatVC.title = self.jobDetailModel.post_name;
    chatVC.post_id = [NSString stringWithFormat:@"%ld",self.jobId];
    self.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:chatVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 170;
            break;
        case 1:
            return 80;
            break;
        case 2: {
            return self.detailHeight;
        }
            break;
        case 3:
            return 80;
            break;
        default:
            break;
    }
    return 0;
}

- (NSInteger)hideLabelLayoutHeight:(NSString *)content withTextFontSize:(CGFloat)mFontSize
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineSpacing = 10;  // 段落高度
    
    NSMutableAttributedString *attributes = [[NSMutableAttributedString alloc] initWithString:content];
    
    [attributes addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:mFontSize] range:NSMakeRange(0, content.length)];
    [attributes addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, content.length)];
    
    CGSize attSize = [attributes boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    
    return attSize.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
        {
            JobInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jobInfoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.jobDetailModel) {
                cell.jobDetailModel = self.jobDetailModel;
            }
            return cell;
        }
            break;
            
        case 1:
        {
            JobLocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locationCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.jobDetailModel) {
                cell.jobDetailModel = self.jobDetailModel;
            }
            return cell;
        }
            break;
            
        case 2:
        {
//            JobDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
            JobWebViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"webCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.jobDetailModel) {
                cell.jobDetailModel = self.jobDetailModel;
                cell.heightBlock = ^(CGFloat height) {
                    if (self.detailHeight < height) {
                        self.detailHeight = height;
                        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
                    }
                };
            }
            return cell;
        }
            break;
            
        case 3:
        {
            JobCompanyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"companyCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.jobDetailModel) {
                cell.jobDetailModel = self.jobDetailModel;
            }
            return cell;
        }
            break;
            
        default:
            return [UITableViewCell new];
            break;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        [self.navigationController pushViewController:[MapViewController new] animated:YES];
    }
}


- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = UIColor.whiteColor;
        [_bottomView sd_addSubviews:@[self.makePhoneCallButton,self.goChatButton]];
        self.makePhoneCallButton.sd_layout.centerYEqualToView(self.bottomView).leftSpaceToView(self.bottomView, 10).topSpaceToView(self.bottomView, 10).bottomSpaceToView(self.bottomView, 10).widthRatioToView(self.bottomView, 0.3);
        
        self.goChatButton.sd_layout.centerYEqualToView(self.bottomView).heightRatioToView(self.makePhoneCallButton, 1).leftSpaceToView(self.makePhoneCallButton, 10).rightSpaceToView(self.bottomView, 10);
    }
    return _bottomView;
}

- (UIButton *)makePhoneCallButton {
    if (!_makePhoneCallButton) {
        _makePhoneCallButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_makePhoneCallButton setTitle:@"打电话" forState:(UIControlStateNormal)];
        _makePhoneCallButton.layer.cornerRadius = 5;
        _makePhoneCallButton.layer.borderColor = [UIColor colorWithRed:27/255.0 green:118/255.0 blue:255/255.0 alpha:1].CGColor;
        _makePhoneCallButton.layer.borderWidth = .5f;
        [_makePhoneCallButton addTarget:self action:@selector(makePhoneCallButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _makePhoneCallButton;
}

- (UIButton *)goChatButton {
    if (!_goChatButton) {
        _goChatButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_goChatButton setTitle:@"开始聊天" forState:(UIControlStateNormal)];
        [_goChatButton setBackgroundColor:[UIColor colorWithRed:27/255.0 green:118/255.0 blue:255/255.0 alpha:1]];
        _goChatButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _goChatButton.layer.cornerRadius = 5;
        _goChatButton.layer.borderWidth = .5f;
        [_goChatButton addTarget:self action:@selector(goChatButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _goChatButton;
}

@end
