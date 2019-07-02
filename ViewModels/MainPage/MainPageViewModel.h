//
//  MainPageViewModel.h
//  ForJob
//
//  Created by Mac on 2019/5/25.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import "BaseViewModel.h"

@interface MainPageViewModel : BaseViewModel
@property (nonatomic, strong) UITableView *bindView;
@property (nonatomic, strong) NSArray *dataSource;
@end
