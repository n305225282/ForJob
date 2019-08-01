//
//  BaseViewModel.h
//  ForJob
//
//  Created by Mac on 2019/5/25.
//  Copyright © 2019年 Arther. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseViewModel : NSObject
- (void)fetchDataWithParams:(NSDictionary *)params;

- (void)loadMoreData;
@end
