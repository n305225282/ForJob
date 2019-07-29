//
//  UserInfoViewController.m
//  ForJob
//
//  Created by Mac on 2019/5/26.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoHeadIconTableViewCell.h"
#import "UserInfoTableViewCell.h"
#import "ChangeInfoViewController.h"
#import "LoginAndRegistViewController.h"
#import "WSDatePickerView.h"


@interface UserInfoViewController ()
@property (nonatomic, strong) NSDictionary *rootDict;
@end

@implementation UserInfoViewController



- (void)fetchData {
    [self.requestManager postRequestWithInterfaceName:@"member/eidtMemberInfo" parame:@{@"uuid":GET_UUID,@"token":GET_TOKEN} success:^(id  _Nullable respDict, NSString * _Nullable message) {
        [self.tableView tab_endAnimation];
        if ([DataCheck isValidDictionary:respDict]) {
            self.rootDict = respDict;
            [self.tableView reloadData];
        } else
            [self showInfoWithMessage:@"获取信息失败"];
    } fail:^(id  _Nullable error) {
        [self.tableView tab_endAnimation];
        [self showInfoWithMessage:error];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self fetchData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    self.tableView.tabAnimated = [TABTableAnimated animatedWithCellClassArray:@[[UserInfoHeadIconTableViewCell class],[UserInfoTableViewCell class]] cellHeightArray:@[@(70)] animatedCountArray:@[@(0)]];
    self.tableView.tabAnimated.categoryBlock = ^(UIView * _Nonnull view) {
        view.animation(1).down(3).height(12).toShortAnimation();
        view.animation(2).height(12).width(110).toLongAnimation();
        view.animation(3).down(-5).height(12);
    };
    [self.tableView tab_startAnimation];
    [self.tableView registerNib:[UINib nibWithNibName:@"UserInfoHeadIconTableViewCell" bundle:nil] forCellReuseIdentifier:@"headCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"UserInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"otherCell"];
    self.tableView.rowHeight = 70;
    self.tableView.sd_layout.bottomSpaceToView(self.view, 100);
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [button setTitle:@"退出登录" forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(logOutAction) forControlEvents:(UIControlEventTouchUpInside)];
    [bgView addSubview:button];
    button.sd_layout.centerXEqualToView(self.view).heightIs(35).topSpaceToView(bgView, 10).widthIs(100);
    [self.view addSubview:bgView];
    bgView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.tableView,0).bottomEqualToView(self.view);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            UserInfoHeadIconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            if (self.rootDict) {
                [cell.headImageVIew sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.rootDict[@"header_src"]]]];
            }
            return cell;
        }
            break;
        case 1:
        {
            UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.nameLabel.text = @"昵称";
            if (self.rootDict) {
                cell.detailLabel.text = [NSString stringWithFormat:@"%@",self.rootDict[@"nickname"]];
            }
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            break;
        case 2:
        {
            UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.nameLabel.text = @"生日";
            if (self.rootDict) {
                cell.detailLabel.text = [NSString stringWithFormat:@"%@",self.rootDict[@"birthday"]];
            }
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            break;
        case 3:
        {
            UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.nameLabel.text = @"性别";
            if (self.rootDict) {
                NSString *sex = [NSString stringWithFormat:@"%@",self.rootDict[@"sex"]];
                                 cell.detailLabel.text = sex.integerValue == 1 ? @"男" : @"女";
            }
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            break;
        case 4:
        {
            UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.nameLabel.text = @"电话";
            if (self.rootDict) {
                cell.detailLabel.text = [NSString stringWithFormat:@"%@",self.rootDict[@"mobile"]];
            }
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            break;
        case 5:
        {
            UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.nameLabel.text = @"现居";
            if (self.rootDict) {
                cell.detailLabel.text = [NSString stringWithFormat:@"%@",self.rootDict[@"address"]];
            }
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            break;
            
        default:
            return [UITableViewCell new];
            break;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:nil];
        }
        return;
    }
    
    if (indexPath.row == 2) {
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
            
            NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
            NSLog(@"选择的日期：%@",date);
            [self updateUserInfoWithParam:@{@"birthday":date}];
        }];
        datepicker.dateLabelColor = [UIColor orangeColor];//年-月-日-时-分 颜色
        datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
        datepicker.doneButtonColor = [[UIColor blueColor] colorWithAlphaComponent:0.6];//确定按钮的颜色
        datepicker.maxLimitDate = [NSDate dateYesterday];
        [datepicker show];
        return;
    }
    
    if (indexPath.row == 3) {
        UIAlertController *alertContrller = [UIAlertController alertControllerWithTitle:@"选择性别" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        [alertContrller addAction:[UIAlertAction actionWithTitle:@"男" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [self updateUserInfoWithParam:@{@"sex":@"1"}];
        }]];
        [alertContrller addAction:[UIAlertAction actionWithTitle:@"女" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [self updateUserInfoWithParam:@{@"sex":@"2"}];
        }]];
        [alertContrller addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
        [self presentViewController:alertContrller animated:YES completion:nil];
    }
    NSInteger showType = -1;
    ChangeInfoViewController *changeVC = [ChangeInfoViewController new];
    switch (indexPath.row) {
        case 1:
        {
            showType = 0;
        }
            break;
        case 4:
        {
            showType = 1;
        }
            break;
        case 5:
        {
            showType = 2;
        }
            break;
            
        default:
            break;
    }
    changeVC.showType = showType;
    if (showType != -1 && showType != 1) {
        [self.navigationController pushViewController:changeVC animated:YES];
    }
}

//获取到图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSData *data = UIImageJPEGRepresentation(image, 1.0f);
        NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [self updateUserInfoWithParam:@{@"header_src":encodedImageStr}];
    }];
}



//取消获取照片
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)logOutAction {
    [self.requestManager postRequestWithInterfaceName:@"login/signOut" parame:@{@"uuid":[[NSUserDefaults standardUserDefaults] objectForKey:@"uuid"],@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]} success:^(id  _Nullable respDict, NSString * _Nullable message) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"uuid"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
        [[WebSocketManager shared] webSocketClose];
        [UIApplication sharedApplication].keyWindow.rootViewController = [[UINavigationController alloc] initWithRootViewController: [LoginAndRegistViewController new]		];
    } fail:^(id  _Nullable error) {
        [self showInfoWithMessage:error];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateUserInfoWithParam:(NSDictionary *)param {
    [self.requestManager postRequestWithInterfaceName:@"member/eidtMemberInfo" parame:param success:^(id  _Nullable respDict, NSString * _Nullable message) {
        [self showInfoWithMessage:message];
        [self fetchData];
    } fail:^(id  _Nullable error) {
        [self showInfoWithMessage:error];
    }];
}

@end
