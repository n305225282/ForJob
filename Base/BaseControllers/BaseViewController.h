//
//  BaseViewController.h
//  ForJob
//
//  Created by Mac on 2019/5/24.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
- (void)showInfoWithMessage:(NSString *)message;

@property (nonatomic, strong) HttpHelper *requestManager;
@end
