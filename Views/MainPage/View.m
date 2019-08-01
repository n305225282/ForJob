//
//  View.m
//  ForJob
//
//  Created by 宇宇宇哲 on 2019/8/1.
//  Copyright © 2019 Arther. All rights reserved.
//

#import "View.h"

@implementation View

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)sharedAction:(id)sender {
    if (self.shareBlock) {
        self.shareBlock();
    }
}

@end
