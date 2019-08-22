//
//  FeedBackDetailViewController.m
//  ForJob
//
//  Created by Mac on 2019/6/1.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "FeedBackDetailViewController.h"
#import "FSTextView.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import <AFNetworking.h>

@interface FeedBackDetailViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *addPicButton;
@property (weak, nonatomic) IBOutlet FSTextView *feedBackTextView;
@property (nonatomic, strong) NSString *fb_image;

@end

@implementation FeedBackDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈与建议";
    self.addPicButton.layer.borderWidth = 0.5f;
    self.addPicButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.feedBackTextView.placeholder = @"请简要描写您的问题和意见,以便我们更好的提供帮助";
    self.feedBackTextView.maxLength = 200;
    self.feedBackTextView.returnKeyType = UIReturnKeyDone;
    self.feedBackTextView.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (IBAction)imageButtonAction:(UIButton *)sender {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        UIImage *image = photos[0];
        [self uploadImageToFetchUrl:image];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}

- (IBAction)submitAction:(UIButton *)sender {
    NSLog(@"%@",self.feedBackTextView.text);
    
    [self.requestManager postRequestWithInterfaceName:@"index/feedBack" parame:@{@"member_id":self.appDelegate.userInfoModel.member_id,@"content":self.feedBackTextView.text.length > 0 ? self.feedBackTextView.text : @"",@"fb_img":self.fb_image.length > 0 ? self.fb_image:@""} success:^(id  _Nullable respDict, NSString * _Nullable message) {
        if (respDict) {
            [self showInfoWithMessage:@"提交成功,感谢您的反馈"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } fail:^(id  _Nullable error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            self.fb_image = resultDic[@"data"][@"imagePath"];
            [self.addPicButton setImage:image forState:(UIControlStateNormal)];
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
@end
