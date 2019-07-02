//
//  CDImageTool.m
//  CDChat
//
//  Created by 吴文海 on 2019/3/7.
//  Copyright © 2019 吴文海. All rights reserved.
//

#import "CDImageTool.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

static UIImageView *_cdOrginImageView;

@implementation CDImageTool

- (void)showFullScrenImage:(UIImageView *)showImageView {
	
    UIImage *image = showImageView.image;
    if (!image) { return; }
    
    _cdOrginImageView = showImageView;
    _cdOrginImageView.alpha = 0;
    
    CGFloat const screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat const screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    backgroundView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[showImageView convertRect:showImageView.bounds toView:window]];
    imageView.image = image;
    imageView.tag = 1;
    imageView.contentMode = showImageView.contentMode;
    imageView.clipsToBounds = YES;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    window.userInteractionEnabled = YES;
    backgroundView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longSaveImage:)];
    [backgroundView addGestureRecognizer:longGesture];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat rate = screenWidth / image.size.width;
        imageView.frame = CGRectMake(0, (screenHeight - image.size.height * rate)/2, screenWidth, image.size.height * rate);
//        backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
    }];
}

- (void)hideImage:(UITapGestureRecognizer *)tap {
	
    UIView *backgroundView = tap.view;
    UIImageView *imageView = [tap.view viewWithTag:1];
	
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = [_cdOrginImageView convertRect:_cdOrginImageView.bounds
												  toView:[UIApplication sharedApplication].keyWindow];
		backgroundView.backgroundColor = [UIColor clearColor];
		
	} completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
        _cdOrginImageView.alpha = 1;
    }];
}

- (void)longSaveImage:(UILongPressGestureRecognizer *)longGesture {
    if (longGesture.state == UIGestureRecognizerStateBegan) {
      
        NSLog(@"长按%@",_cdOrginImageView.image);
        
        [[self class] savePictureWithImage:_cdOrginImageView.image success:^{
            
        }];
    }
}


// 保存图片到相机胶卷
+ (void)savePictureWithImage: (UIImage *)image success: (void(^)(void))success {
    
    // 保存相片到相机胶卷
    NSError *error = nil;
    __block PHObjectPlaceholder *createdAsset = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        
        // iOS9 后才能使用
        if (@available(iOS 9.0, *)) {
            createdAsset = [PHAssetCreationRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset;
        } else {
            createdAsset = (PHObjectPlaceholder *)[PHAssetChangeRequest creationRequestForAssetFromImage:image];
        }
    } error: &error];
    if (error) {
        NSLog(@"保存相册失败");
    } else {
        success();
    }
}

@end
