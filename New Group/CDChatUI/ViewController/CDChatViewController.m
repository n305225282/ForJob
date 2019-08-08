//
//  CDChatViewController.m
//  CDChat
//
//

#import "CDChatViewController.h"

#import "CDChatDefine.h"

#import "CDMessageCell.h"

#import "CDChatModel.h"

#import "MJRefresh.h"

#import "VideoInputView.h"

#import "DKSTextView.h"

#import "DKSKeyboardView.h"

#import "MessageJobDetailTableViewCell.h"

#import <TZImagePickerController.h>

#import <AFNetworking/AFNetworking.h>

@interface CDChatViewController ()<CDMessageCellDelegate,UITableViewDelegate, UITableViewDataSource,DKSKeyboardDelegate,WebSocketManagerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DKSKeyboardView *inputView;
@property (nonatomic, strong) CDChatModel *chatModel;

@property (nonatomic, strong) NSDictionary *jobInfoDict;
@end

@implementation CDChatViewController

#pragma mark - Life Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *loginDic = @{
                               @"type":@"login",
                               @"room_id":@(1),
                               @"client_name":GET_TOKEN
                               };
     [[WebSocketManager shared] sendDataToServer:[loginDic yy_modelToJSONString]];

    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.tableView];
    CGFloat y = [UIDevice cd_isIPhoneX] ? 88 : 64;
    self.tableView.frame = CGRectMake(0, y + 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - y - TabbarSafeBottomMargin - 80);
    [self fetchHistoryList];
    [self.view addSubview:self.inputView];
    __weak typeof(self) weakSelf = self;
//    self.inputView.videoInputView.audioRecordeBlock = ^(id  _Nonnull data, NSInteger count) {
//        [weakSelf sendData:@{@"type":@(CDMessageTypeVoice),
//                             @"voice":data,
//                             @"strVoiceTime":[NSString stringWithFormat:@"%lds",(long)count]
//                             }];
//
//    };
    [self.tableView reloadData];
    [WebSocketManager shared].delegate = self;
    [WebSocketManager shared].connectBrokenBlock = ^{
        [self hideLoding];
        NSLog(@"控制器里监听到断开");
        [self showLodingWithMessage:@"正在连接聊天服务..."];
    };
    [WebSocketManager shared].didReConnected = ^{
        NSLog(@"控制器接收到数据,重连了");
        NSDictionary *loginDic = @{
                                   @"type":@"login",
                                   @"room_id":@(1),
                                   @"client_name":GET_TOKEN
                                   };
        [[WebSocketManager shared] sendDataToServer:[loginDic yy_modelToJSONString]];
        [self hideLoding];
        [self fetchHistoryList];
    };
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - Intial Methods

#pragma mark - Network Methods
- (void)fetchHistoryList {
    [self.requestManager postRequestWithInterfaceName:@"index/getContent" parame:@{@"uid":self.appDelegate.userInfoModel.member_id} success:^(id  _Nullable respDict, NSString * _Nullable message) {
        self.jobInfoDict = respDict[@"jobInfo"];
        if ([DataCheck isValidArray:respDict[@"messageList"]]) {
            self.chatModel.bindView = self.tableView;
            [self.chatModel addItemsWithDataSource:respDict[@"messageList"]];
        }
    } fail:^(id  _Nullable error) {
        
    }];
}


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
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chatModel.dataSource.count - 1 inSection:1];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}
#pragma mark - External Delegate
- (void)webSocketDidReceiveMessage:(NSString *)string {
    NSLog(@"这里面收到的是%@",string);
    NSDictionary *dict = [NSDictionary yy_modelWithJSON:string];
    for (NSString *keys in dict.allKeys) {
        if ([keys isEqualToString:@"type"]) {
            if ([dict[keys] isEqualToString:@"say"]) {
                [self fetchHistoryList];
            }
        }
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.chatModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MessageJobDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mCell" forIndexPath:indexPath];
        cell.modelDic = self.jobInfoDict;
        return cell;
    }
    CDMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CDMessageCell class])];
    cell.delegate = self;
    cell.messageFrame = self.chatModel.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 126;
    }
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
        _tableView.backgroundColor = UIColor.groupTableViewBackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame: CGRectZero];
        if (@available(iOS 11, *)) {
            
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        [_tableView registerClass:[CDMessageCell class] forCellReuseIdentifier:NSStringFromClass([CDMessageCell class])];
        [_tableView registerNib:[UINib nibWithNibName:@"MessageJobDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"mCell"];
    }
    return _tableView;
}

#pragma mark ====== DKSKeyboardDelegate ======
//发送的文案
- (void)textViewContentText:(NSString *)textStr {
    NSLog(@"%@",textStr);
    NSDictionary *dic = @{@"strContent": textStr,
                          @"type": @(CDMessageTypeText),
                          @"strIcon":self.appDelegate.userInfoModel.header_src,
                          @"client_name":GET_TOKEN
                          };
    NSLog(@"%@",[dic yy_modelToJSONString]);
    NSMutableDictionary *serverDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [serverDic setObject:@"say" forKey:@"type"];
    [serverDic setObject:@"0" forKey:@"image_type"];
    [serverDic setObject:self.post_id.length > 0 ? self.post_id : @"1" forKey:@"post_id"];
    [[WebSocketManager shared] sendDataToServer:[serverDic yy_modelToJSONString]];
    [self sendData:dic];
}


- (void)uploadImageToFetchUrl:(UIImage *)image {
    NSDictionary * body = @{@"image":@"HeadImg"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //ContentType设置
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
    
    
    
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    
    
    [self showLodingWithMessage:@"正在发送图片..."];
    [manager POST:@"http://sp.xijitech.com/api/index/uploadImg" parameters:body constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //把image  转为data , POST上传只能传data
        
        NSData *data = UIImagePNGRepresentation([self imageCompressWithSimple:image]);
        
        //上传的参数(上传图片，以文件流的格式)
        
        [formData appendPartWithFileData:data
         
         
         
                                    name:@"image"
         
         
         
                                fileName:@"chat.png"
         
         
         
                                mimeType:@"image/png"];
        
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self hideLoding];
        　　//请求成功的block回调
        
        NSDictionary * resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"上传成功%@",resultDic);
        if ([resultDic[@"status"] isEqualToString:@"ok"]) {
            NSLog(@"%@",image);
            NSDictionary *dic = @{@"strContent": resultDic[@"data"][@"imagePath"],
                                  @"type": @(CDMessageTypePicture),
                                  @"strIcon":self.appDelegate.userInfoModel.header_src,
                                  @"client_name":GET_TOKEN
                                  };
            NSLog(@"%@",[dic yy_modelToJSONString]);
            NSMutableDictionary *serverDic = [NSMutableDictionary dictionaryWithDictionary:dic];
            [serverDic setObject:@"say" forKey:@"type"];
            [serverDic setObject:@"1" forKey:@"image_type"];
            [serverDic setObject:self.post_id.length > 0 ? self.post_id : @"1" forKey:@"post_id"];
            [[WebSocketManager shared] sendDataToServer:[serverDic yy_modelToJSONString]];
            [self sendData:dic];

        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hideLoding];
        [self showInfoWithMessage:@"发送失败,请重试..."];
        NSLog(@"上传失败%@",error);
        
    }];
}

- (UIImage*)imageCompressWithSimple:(UIImage*)image{
    CGSize size = image.size;
    CGFloat scale = 1.0;
    //TODO:KScreenWidth屏幕宽
    
    CGFloat KScreenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat KScreenHeight = [UIScreen mainScreen].bounds.size.height;
    
    if (size.width > KScreenWidth || size.height > KScreenHeight) {
        if (size.width > size.height) {
            scale = KScreenWidth / size.width;
        }else {
            scale = KScreenHeight / size.height;
        }
    }
    CGFloat width = size.width;
    CGFloat height = size.height;
    CGFloat scaledWidth = width * scale;
    CGFloat scaledHeight = height * scale;
    CGSize secSize =CGSizeMake(scaledWidth, scaledHeight);
    //TODO:设置新图片的宽高
    UIGraphicsBeginImageContext(secSize); // this will crop
    [image drawInRect:CGRectMake(0,0,scaledWidth,scaledHeight)];
    UIImage* newImage= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)photoClickButtonDelegate {
    NSLog(@"点击照片");
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        UIImage *image = photos[0];
        [self uploadImageToFetchUrl:image];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

//keyboard的frame改变
- (void)keyboardChangeFrameWithMinY:(CGFloat)minY {
//     获取对应cell的rect值（其值针对于UITableView而言）
    [self tableViewScrollToBottom];
    NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:self.chatModel.dataSource.count - 1 inSection:1];
    CGRect rect = [self.tableView rectForRowAtIndexPath:lastIndex];
    CGFloat lastMaxY = rect.origin.y + rect.size.height;
    //如果最后一个cell的最大Y值大于tableView的高度
    if (lastMaxY <= self.tableView.height) {
        if (lastMaxY >= minY) {
            self.tableView.y = minY - lastMaxY;
        } else {
            self.tableView.y = StatusBarAndNavigationBarHeight;
        }
    } else {
        self.tableView.y += minY - CGRectGetMaxY(self.tableView.frame);
    }
}

- (CDChatModel *)chatModel {
    if (!_chatModel) {
        _chatModel = [[CDChatModel alloc] init];
//        [_chatModel populateRandomDataSource];
//        [_chatModel addRandomItemsToDataSource:10];
    }
    return _chatModel;
}

- (DKSKeyboardView *)inputView {
    if (!_inputView) {
        
        _inputView = [[DKSKeyboardView alloc] initWithFrame:CGRectMake(0,  kScreenHeight- TabbarSafeBottomMargin - 52, kScreenWidth, 52)];
        //设置代理方法
        _inputView.delegate = self;

    }
    return _inputView;
}
@end
