//
//  JobDetailTableViewCell.m
//  ForJob
//
//  Created by Mac on 2019/5/25.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "JobDetailTableViewCell.h"
#import "JobDetailModel.h"

@interface JobDetailTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *job_remarkLabel;

@end

@implementation JobDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setJobDetailModel:(JobDetailModel *)jobDetailModel {
    _jobDetailModel = jobDetailModel;
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[jobDetailModel.post_detail dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.job_remarkLabel.attributedText = attrStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
