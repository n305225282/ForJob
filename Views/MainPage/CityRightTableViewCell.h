//
//  CityRightTableViewCell.h
//  ForJob
//
//  Created by Mac on 2019/5/25.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityRightTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;

@property (nonatomic, assign) BOOL isSelected;

@end
