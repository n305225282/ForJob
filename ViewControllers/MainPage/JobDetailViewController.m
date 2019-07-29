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


@interface JobDetailViewController ()
@property (nonatomic, strong) JobDetailModel *jobDetailModel;

@property (nonatomic, assign) CGFloat detailHeight;
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
