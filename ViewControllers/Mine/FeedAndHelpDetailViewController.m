//
//  FeedAndHelpDetailViewController.m
//  ForJob
//
//  Created by 宇宇宇哲 on 2019/7/2.
//  Copyright © 2019 Arther. All rights reserved.
//

#import "FeedAndHelpDetailViewController.h"

@interface FeedAndHelpDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation FeedAndHelpDetailViewController


- (void)fetchData {
    [self.requestManager postRequestWithInterfaceName:@"member/feedBackDetail" parame:@{@"id":@(self.idField)} success:^(id  _Nullable respDict, NSString * _Nullable message) {
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"%@",respDict[@"content"]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        self.contentLabel.attributedText = attrStr;
    } fail:^(id  _Nullable error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


@end
