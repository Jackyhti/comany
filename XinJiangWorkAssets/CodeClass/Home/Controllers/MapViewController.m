//
//  MapViewController.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/4/2.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "MapViewController.h"
#import "MapAddressModel.h"

@interface MapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property(nonatomic,strong)BMKMapView *mapView;

@property (weak, nonatomic) IBOutlet UIView *mapbc;

@property(nonatomic,strong)NSMutableArray *addressArr;
@property (weak, nonatomic) IBOutlet UILabel *cityLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;

@end

@implementation MapViewController
{
BMKLocationService *_locService;
    
BMKGeoCodeSearch *_geoCodeSearch;
    
BMKReverseGeoCodeOption *_reverseGeoCodeOption;

BMKUserLocation *_userLocation;
    
BMKLocationViewDisplayParam *_displayParam;
    
int _num;
    
}

-(NSMutableArray *)addressArr{
    if (!_addressArr) {
        _addressArr = [NSMutableArray array];
    }
    return _addressArr;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUI];
    
    _num = 0;
    // Do any additional setup after loading the view from its nib.
}


-(void)setUI{
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, Kscreen_width, 250)];
    [self.mapbc addSubview: self.mapView];
    //自定义标记
    _displayParam = [[BMKLocationViewDisplayParam alloc]init];
    _displayParam.isRotateAngleValid = true;//跟随态旋转角度是否生效
    _displayParam.isAccuracyCircleShow = false;//精度圈是否显示
    _displayParam.locationViewImgName= @"icon_center_point";//定位图标名称
    _displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
    _displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
    [_mapView updateLocationViewWithParam:_displayParam];

    [self initLocation];
    
    //优化体验，预防及个别情况下定位不到
    [self afterTimeAgainLocation];

}

-(void)afterTimeAgainLocation{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self afterLocation];
    });
}


-(void)afterLocation{
    if ([_cityLab.text isEqualToString:@"搜索中"]) {
        [_locService startUserLocationService];
    }

}

-(void)initLocation{
    //以下_mapView为BMKMapView对象
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态为普通定位模式
    _mapView.minZoomLevel = 17;

    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];

    _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
    
}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    
    [_mapView updateLocationData:userLocation];
    //NSLog(@"heading is %@",userLocation.heading);
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    _mapView.showsUserLocation = YES;//显示定位图层
    //设置地图中心为用户经纬度
    [_mapView updateLocationData:userLocation];

    _userLocation = userLocation;
    
    _mapView.centerCoordinate = userLocation.location.coordinate;

    [_locService stopUserLocationService];
    
}

/**
 *在停止定位后，会调用此函数
 */
- (void)didStopLocatingUser{
    //屏幕坐标转地图经纬度
    CLLocationCoordinate2D MapCoordinate=[_mapView convertPoint:_mapView.center toCoordinateFromView:_mapView];
    
    if (_geoCodeSearch==nil) {
        //初始化地理编码类
        _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
        _geoCodeSearch.delegate = self;
        
    }
    
    if (_reverseGeoCodeOption==nil) {
        
        //初始化反地理编码类
        _reverseGeoCodeOption= [[BMKReverseGeoCodeOption alloc] init];
    }
    
    //需要逆地理编码的坐标位置
    _reverseGeoCodeOption.reverseGeoPoint =MapCoordinate;
    [_geoCodeSearch reverseGeoCode:_reverseGeoCodeOption];
}

#pragma mark BMKMapViewDelegate
//视图改变时调用
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
}

#pragma mark BMKGeoCodeSearchDelegate
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    //获取周边用户信息
    if (error == BMK_SEARCH_NO_ERROR) {
        [self.addressArr removeAllObjects];
        for (BMKPoiInfo *poiInfo in result.poiList) {
           NSLog(@"%@",poiInfo.address);
            MapAddressModel *model = [[MapAddressModel alloc]init];
            model.name = poiInfo.name;
            model.city = poiInfo.city;
            model.address = poiInfo.address;
            [self.addressArr addObject:model];
        }
        if (self.addressArr.count>0) {
            MapAddressModel *model = [[MapAddressModel alloc]init];
            model = self.addressArr[0];
            
            self.cityLab.text = [NSString stringWithFormat:@"%@%@",model.city,model.address];
            self.addressLab.text = [NSString stringWithFormat:@"%@",model.name];
        }
    }
}

#pragma mark -再次获取位置-
- (IBAction)againGetAddressBtn:(id)sender {
    [_locService startUserLocationService];
}

#pragma mark -改变地址-
- (IBAction)changeAddressBtn:(id)sender {
    if (self.addressArr.count > 0&& _num < self.addressArr.count-1) {
        _num++;
    }else{
        _num = 0;
    }
    MapAddressModel *model = [[MapAddressModel alloc]init];
    model = self.addressArr[_num];
    self.cityLab.text = [NSString stringWithFormat:@"%@%@",model.city,model.address];
    self.addressLab.text = [NSString stringWithFormat:@"%@",model.name];
}
- (IBAction)tj:(id)sender {
    MapAddressModel *model = [[MapAddressModel alloc]init];

    model = self.addressArr[_num];
    [self sendData:model];
}


-(void)sendData:(MapAddressModel*)model{
    [self showLoadingMinView];
    NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
    NSString *LeaderID = [NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]];
    //    NSLog(@"%@",userDic);
    NSDictionary *dic = @{@"LeaderID":LeaderID,@"Location":self.cityLab.text,@"X":@"",@"Y":@"",@"Province":@"",@"City":model.city,@"County":@"",@"Remark":@""};
    [[NetworkSingleton sharedManager] postDataToResult:dic url:kSendMap successBlock:^(ModelRequestResult *responseBody) {
        if(responseBody.succWDJH) {
            [self hiddenLoadingMinView];
            [LToast showWithText:@"签到成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failureBlock:^(ModelRequestResult *error) {
        [self hiddenLoadingMinView];
        [LToast showWithText:error.errorMsg];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    _geoCodeSearch.delegate = self;

}

-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _geoCodeSearch.delegate = nil;

}

- (void)dealloc {
    
    if (_geoCodeSearch != nil) {
        _geoCodeSearch = nil;
    }
    if (_mapView) {
        _mapView = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
