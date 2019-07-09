//
//  JobWebViewTableViewCell.m
//  ForJob
//
//  Created by 宇宇宇哲 on 2019/7/8.
//  Copyright © 2019 Arther. All rights reserved.
//

#import "JobWebViewTableViewCell.h"
#import "JobDetailModel.h"
#import <WebKit/WebKit.h>

@interface JobWebViewTableViewCell () <WKNavigationDelegate>
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, assign) CGFloat oldHeight;
@end

@implementation JobWebViewTableViewCell

- (instancetype)init {
    self = [super init];
    if (self) {
        self.label = [UILabel new];
        self.label.text = @"职位详情";
        self.label.font = [UIFont systemFontOfSize:16];
        
        [self.contentView sd_addSubviews:@[self.label,self.webView]];
        self.label.sd_layout.leftSpaceToView(self, 20).topSpaceToView(self, 10).heightIs(20).widthIs(120);
        
        self.webView.sd_layout.leftSpaceToView(self, 20).topSpaceToView(self.label, 10).rightSpaceToView(self, 10).bottomEqualToView(self);
        
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label = [UILabel new];
        self.label.text = @"职位详情";
        self.label.font = [UIFont systemFontOfSize:16];
        
        [self.contentView sd_addSubviews:@[self.label,self.webView]];
        
        self.label.sd_layout
        .leftSpaceToView(self.contentView, 20)
        .topSpaceToView(self.contentView, 10)
        .heightIs(20)
        .widthIs(120);
        
        self.webView.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.label, 10).rightSpaceToView(self.contentView, 10).bottomEqualToView(self.contentView);
        
    }
    return self;
}




- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (void)setJobDetailModel:(JobDetailModel *)jobDetailModel {
    _jobDetailModel = jobDetailModel;
    //    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[jobDetailModel.post_detail dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    //    self.job_remarkLabel.attributedText = attrStr;
    [self.webView loadHTMLString: [jobDetailModel.post_detail stringByReplacingOccurrencesOfString:@"\\" withString:@""] baseURL:nil];
}

/// 网页加载完成计算高度
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    __weak typeof(self) weakSelf = self;
    
    [self.webView evaluateJavaScript:@"document.body.scrollWidth"completionHandler:^(id _Nullable result,NSError * _Nullable error){
        
        CGFloat ratio =  kScreenWidth / [result floatValue];
        
        [weakSelf.webView evaluateJavaScript:@"document.body.scrollHeight"completionHandler:^(id _Nullable result,NSError * _Nullable error){
            
            CGFloat height = kScreenWidth * ratio;
            self.oldHeight = height;
            NSLog(@"页面高度:%f",height);
            
            [webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
            
            //            if (weakSelf.fb_delegate && [weakSelf.fb_delegate respondsToSelector:@selector(fb_getWebViewCellHeight:)]) {
            //
            //                [weakSelf.fb_delegate fb_getWebViewCellHeight:height];
            //            }
        }];
        
    }];
}


#pragma mark  - KVO回调
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    //更具内容的高重置webView视图的高度
    CGFloat newHeight = self.webView.scrollView.contentSize.height;
    if (newHeight > self.oldHeight) {
        self.oldHeight = newHeight;
        if (self.heightBlock) {
            self.heightBlock(newHeight);
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (WKWebView *)webView {
    
    if (!_webView) {
        //js脚本
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        //注入
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
        //配置对象
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        wkWebConfig.userContentController = wkUController;
        // 创建设置对象
        WKPreferences *preference = [[WKPreferences alloc]init];
        // 设置字体大小(最小的字体大小)
        preference.minimumFontSize = 15;
        // 设置偏好设置对象
        wkWebConfig.preferences = preference;
        
        _webView = [[WKWebView alloc] initWithFrame:(CGRectMake(0, 0, kScreenWidth, kScreenWidth)) configuration:wkWebConfig];
        _webView.navigationDelegate = self;
        _webView.scrollView.bounces = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.scrollEnabled = NO;
        _webView.userInteractionEnabled = NO;
        _webView.contentMode = UIViewContentModeScaleToFill;
        [_webView sizeToFit];
    }
    
    return _webView;
}

@end
