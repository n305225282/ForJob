//
//  MapViewController.m
//  ForJob
//
//  Created by 宇宇宇哲 on 2019/7/25.
//  Copyright © 2019 Arther. All rights reserved.
//

#import "MapViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

@interface MapViewController ()<BMKMapViewDelegate>
@property (nonatomic, strong) BMKMapView *mapView;

@property (nonatomic, strong) UIButton *jumpButton;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.latitude = 34.302706;
    self.longitude = 108.977961;
    self.title = @"导航地址";
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    [_mapView setZoomLevel:19];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
    _mapView.centerCoordinate = coordinate;
    _mapView.userInteractionEnabled = NO;
    BMKPointAnnotation *point1 = [[BMKPointAnnotation alloc]init];
    point1.coordinate = coordinate;
    [_mapView addAnnotation:point1];
    
    [self.view addSubview:self.jumpButton];
    self.jumpButton.sd_layout.centerXEqualToView(self.view).bottomSpaceToView(self.view, 30).widthIs(60).heightIs(60);
    self.jumpButton.layer.cornerRadius = 30.f;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
}

- (void)jumpButtonAction {
    // 打开地图的优先级顺序：百度地图->高德地图->苹果地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        // 百度地图
        // 起点为“我的位置”，终点为后台返回的坐标
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=%f,%f&mode=riding&src=快健康快递", self.latitude, self.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }
}


- (UIButton *)jumpButton {
    if (!_jumpButton) {
        _jumpButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_jumpButton setTitle:@"导航" forState:(UIControlStateNormal)];
        [_jumpButton setBackgroundColor:[UIColor colorWithRed:31/255.0 green:118/255.0 blue:254/255.0 alpha:1]];
        [_jumpButton addTarget:self action:@selector(jumpButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _jumpButton;
}

@end
