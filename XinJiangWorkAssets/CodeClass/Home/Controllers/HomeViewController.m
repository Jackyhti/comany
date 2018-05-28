//
//  HomeViewController.m
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/6.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "HomeViewController.h"
#import "PersonalCenterViewController.h"
#import "NotifitationViewController.h"
#import "HomeTableViewCellOne.h"
#import "HomeTableViewCellThree.h"
#import "HomeTableViewCellTwo.h"
#import "GroupInfoMoel.h"
#import "DynamicViewController.h"  //工作动态
#import "OfficeVC.h"
#import "AppDelegate.h"
#import "BaseTabBarViewController.h"
#import "NotifDeaVC.h"
#import "MapViewController.h"
#import "ArrangeModel.h"
#import "HomeFooterView.h"

#import "TqbgVC.h"

#import "LdjbVC.h"

#import "TqPhotoUpVC.h"

#import "TqVoiceUpVC.h"

#import "TqVedioUpVC.h"

@interface HomeViewController ()<HomeMenuViewDelegate,UITableViewDelegate,UITableViewDataSource,HomeTableViewCellTwoDidSelectItemDelegate,HomeTableViewCellOneDelegate,WMPageControllerDelegate>
{
    //人数
    UILabel *_numLabel;
    //红点
    UILabel *_dotLabel;
    
    NSString *_state;
}

//侧边栏
@property (nonatomic ,strong)MenuView *menu;

@property (nonatomic, retain)UITableView *tableView;

//数据源
@property (nonatomic, retain)NSMutableArray *dataSource;

@property(nonatomic,strong)GroupInfoMoel *allModel;

@property(nonatomic,strong)LeftMenuView *leftView;

@property(nonatomic,strong)NSString *Type;


@end


@implementation HomeViewController

static NSString *const cellOneId = @"HomeTableViewCellOne";
static NSString *const cellThreeId = @"HomeTableViewCellThree";
static NSString *const cellTwoId = @"HomeTableViewCellTwo";


- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"首页";
        self.isHiddenBackBtn = YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self loadHomeData];
    _leftView = [[LeftMenuView alloc]initWithFrame:CGRectMake(Kscreen_width/2,64,Kscreen_width/2, Kscreen_height-64)];
    _leftView.customDelegate = self;
    
    self.menu = [[MenuView alloc]initWithDependencyView:self.view MenuView:_leftView isShowCoverView:NO];
    
    //初始化tableview
    [self setUpTableView];
    
    //    //设置刷新控件
    [self setUpRefresh];
    //修改状态后回调
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ac:) name:@"ty" object:_Type];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reload) name:@"tj" object:nil];
    
    //发布通知后
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reload) name:@"fb" object:nil];
    
    //更改工作态度后刷新
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reload) name:@"close" object:nil];
    
    //院部动态添加后刷新
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reload) name:@"reload" object:nil];

}



-(void)reload{
    [self loadHomeData];
}

-(void)ac:(NSNotification*)no{
    NSLog(@"%@",no.userInfo);
    if ([no.userInfo[@"type"]isEqualToString:@"0"]) {
    _state = @"在岗";
    }else if ([no.userInfo[@"type"]isEqualToString:@"1"]){
        _state = @"请假";

    }else if ([no.userInfo[@"type"]isEqualToString:@"2"]){
        _state = @"单位内开会/办事";

    }else if ([no.userInfo[@"type"]isEqualToString:@"3"]){
        _state = @"单位外开会/办事";

    }else if ([no.userInfo[@"type"]isEqualToString:@"4"]){
        _state = @"出差";

    }else if ([no.userInfo[@"type"]isEqualToString:@"5"]){
        _state = @"其他";
    }
    [self.tableView reloadData];
}

- (void)setupNav {
    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"chat"] style:UIBarButtonItemStylePlain target:self action:@selector(chatAction:)];
//    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"USERS"] style:UIBarButtonItemStylePlain target:self action:@selector(pushAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}


- (void)setUpTableView {
    
    UITableView *tabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height-64-49) style:UITableViewStylePlain];
    self.tableView = tabV;
    tabV.backgroundColor = [UIColor whiteColor];
    
    tabV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabV.dataSource = self;
    tabV.delegate = self;
    [self.view addSubview:tabV];
    
    
    //注册cell
    [tabV registerNib:[UINib nibWithNibName:cellOneId bundle:nil] forCellReuseIdentifier:cellOneId];
    [tabV registerNib:[UINib nibWithNibName:cellThreeId bundle:nil] forCellReuseIdentifier:cellThreeId];
    [tabV registerClass:[HomeTableViewCellTwo class] forCellReuseIdentifier:cellTwoId];

    [self setheaderView];
    [self setFooterView];
 
}

- (void)setheaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, SCALE(150))];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(screen_width/2-SCALE(380)/2, SCALE(180) * 0.2, SCALE(380), SCALE(180) * 0.6)];
    [btn setTitle:@"通知通告" forState:UIControlStateNormal];
    [btn setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.8] forState:UIControlStateNormal];
    btn.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    btn.titleLabel.font = [UIFont systemFontOfSize:SCALE(50)];
    btn.layer.cornerRadius = SCALE(55);
    btn.layer.masksToBounds = YES;
    
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:btn];
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView = [UIView new];
}


#pragma mark 返回一个WMPageController对象
- (WMPageController *)pageVC{
    //WMPageController中包含的页面数组
    NSArray *controllers = [NSArray arrayWithObjects:[LdjbVC class],[LdjbVC class],[LdjbVC class],[LdjbVC class],[LdjbVC class],[LdjbVC class], nil];
    
    //WMPageController控件的标题数组
    NSArray *titles = [NSArray arrayWithObjects:@"全部(9)",@"进展(2)",@"问询(2)",@"问责(1)",@"逾期未完成(2)",@"已完成(2)", nil];
    //用上面两个数组初始化WMPageController对象
    WMPageController *pageController = [[WMPageController alloc] initWithViewControllerClasses:controllers andTheirTitles:titles];
    pageController.delegate = self;
    pageController.menuViewStyle = WMMenuViewStyleLine;
    //设置WMPageController每个标题的宽度
    pageController.itemsWidths = @[@70,@70,@70,@70,@110,@80];
    //设置WMPageController标题栏的高度
    pageController.menuHeight = 50;
    //设置WMPageController选中的标题的颜色
    pageController.titleColorSelected = [UIColor blueColor];
    pageController.titleColorNormal = [UIColor colorWithHexString:@"#666666"];
    pageController.titleSizeSelected = 18;
    pageController.titleSizeNormal = 17;
    return pageController;
}

- (WMPageController *)page2VC{
    //WMPageController中包含的页面数组
    NSArray *controllers = [NSArray arrayWithObjects:[TqbgVC class],[TqbgVC class],nil];
    
    //WMPageController控件的标题数组
    NSArray *titles = [NSArray arrayWithObjects:@"已读",@"未读", nil];
    //用上面两个数组初始化WMPageController对象
    WMPageController *pageController = [[WMPageController alloc] initWithViewControllerClasses:controllers andTheirTitles:titles];
    pageController.delegate = self;
    pageController.menuViewStyle = WMMenuViewStyleLine;
    //设置WMPageController每个标题的宽度
//    pageController.itemsWidths = @[@70,@70,@70,@70,@110,@80];
    //设置WMPageController标题栏的高度
    pageController.menuHeight = 50;
    //设置WMPageController选中的标题的颜色
    pageController.titleColorSelected = [UIColor blueColor];
    pageController.titleColorNormal = [UIColor colorWithHexString:@"#666666"];
    pageController.titleSizeSelected = 18;
    pageController.titleSizeNormal = 17;
    return pageController;
}



- (void)pageController:(WMPageController *)pageController lazyLoadViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    NSNotification *not = [[NSNotification alloc]initWithName:@"cc" object:nil userInfo:info];
    
    [[NSNotificationCenter defaultCenter] postNotification:not];

}




-(void)setFooterView{
    HomeFooterView *FooterView = [[[NSBundle mainBundle]loadNibNamed:@"HomeFooterView" owner:self options:nil] firstObject];
    FooterView.sendBtn = ^(int n) {
        switch (n) {
            case 2000:
            {
                WMPageController *page = [self pageVC];
                page.title = @"交办事项";
                [self.navigationController pushViewController:page animated:YES];
            }
                break;
            case 2001:
            {
                TqbgVC *vc = [[TqbgVC alloc]init];

//                WMPageController *page = [self page2VC];
//                UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(NavAc)];
//                page.navigationItem.rightBarButtonItem = item;
//                vc.title = @"特情报告";
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2002:
            {
                NSLog(@"培训中心");

            }
                break;
            case 2003:
            {
                NSLog(@"会议管理");

            }
                break;
            case 2004:
            {
                NSLog(@"舆情动态");

            }
                break;
            case 2005:
            {
                NSLog(@"政策法规");

            }
                break;
             default:
                break;
        }
        
    };
    self.tableView.tableFooterView = FooterView;
}

//-(void)NavAc{
//    UIAlertController *ale = [UIAlertController alertControllerWithTitle:@"提示" message:@"发布内容" preferredStyle:1];
//    UIAlertAction *A = [UIAlertAction actionWithTitle:@"文字图片" style:0 handler:^(UIAlertAction * _Nonnull action) {
//        TqPhotoUpVC *vc = [[TqPhotoUpVC alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//      }];
//    UIAlertAction *B = [UIAlertAction actionWithTitle:@"语音" style:0 handler:^(UIAlertAction * _Nonnull action) {
//        TqVoiceUpVC *soundvc = [[TqVoiceUpVC alloc]init];
//        [self.navigationController pushViewController:soundvc animated:YES];
//    }];
//    UIAlertAction *C = [UIAlertAction actionWithTitle:@"视频" style:0 handler:^(UIAlertAction * _Nonnull action) {
//        TqVedioUpVC *vedioVc = [[TqVedioUpVC alloc]init];
//        [self.navigationController pushViewController:vedioVc animated:YES];
//
//    }];
//    UIAlertAction *D = [UIAlertAction actionWithTitle:@"取消" style:1 handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    [ale addAction:A];
//    [ale addAction:B];
//    [ale addAction:C];
//    [ale addAction:D];
//    [self presentViewController:ale animated:YES completion:nil];
//
//}


- (void)setUpRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHomeData)];

//    [self.tableView.mj_header beginRefreshing];

}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == 0) {
        HomeTableViewCellOne *oneCell = [tableView dequeueReusableCellWithIdentifier:cellOneId forIndexPath:indexPath];
        oneCell.model = _allModel;
        oneCell.state = _state;
        oneCell.delegate = self;
        return oneCell;
    }else if(indexPath.row == 1) {
        HomeTableViewCellTwo * cell = [tableView dequeueReusableCellWithIdentifier:cellTwoId];
        if (cell == nil) {
            cell = [[HomeTableViewCellTwo alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTwoId];
        }
        cell.model = _allModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.homeTableViewCellTwoDidSelectItemDelegate = self;
        return cell;
    }else {
        HomeTableViewCellThree *threeCell = [tableView dequeueReusableCellWithIdentifier:cellThreeId forIndexPath:indexPath];
        if (indexPath.row == 2) {
            threeCell.bumenModel = _allModel;
        }
        if(indexPath.row == 3) {
            threeCell.titelLabel.text = @"院工作动态";
            threeCell.yuanBuModel = _allModel;
        }
        return threeCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        return SCALE(500);
    }else if(indexPath.row == 1){
        return SCALE(380) ;
    }else {
        return SCALE(400);
    }
}

#pragma mark  请求数据

- (void)loadHomeData {
   [self showLoadingMinView];
    NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
    NSString *LeaderID = [NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]];
//    NSLog(@"%@",userDic);
    NSDictionary *dic = @{@"LeaderID":LeaderID};
    [[NetworkSingleton sharedManager] postDataToResult:dic url:kHomecon successBlock:^(ModelRequestResult *responseBody) {
        if(responseBody.succWDJH) {
            [self hiddenLoadingMinView];
            [self.tableView.mj_header endRefreshing];
            NSDictionary *responDic = responseBody.responseObject;
//            NSLog(@"%@",responDic);
            _allModel = [GroupInfoMoel mj_objectWithKeyValues:responDic];
        }
        [self.tableView reloadData];
    } failureBlock:^(ModelRequestResult *error) {
        [self hiddenLoadingMinView];
        [LToast showWithText:error.errorMsg];
    }];
    
    [[NetworkSingleton sharedManager] postDataToResult:dic url:kWorkState successBlock:^(ModelRequestResult *responseBody) {
        if(responseBody.succWDJH) {
            [self hiddenLoadingMinView];
            [self.tableView.mj_header endRefreshing];
            NSDictionary *responDic = responseBody.responseObject;
            _state = responDic[@"data"][@"State"];
        }
        [self.tableView reloadData];
    } failureBlock:^(ModelRequestResult *error) {
        [self hiddenLoadingMinView];
        [LToast showWithText:error.errorMsg];
    }];
    
}

- (void)btnAction:(UIButton *)btn {
    NotifitationViewController *notiVC = [[NotifitationViewController alloc] init];
//    NotifDeaVC *notiVC = [[NotifDeaVC alloc]init];
    notiVC.title = @"通知通告";
    [self.navigationController pushViewController:notiVC animated:YES];
}

#pragma mark onedelegate

- (void)pushToPersonalCenterVC {
    PersonalCenterViewController *personalVC = [[PersonalCenterViewController alloc] initWithNibName:@"PersonalCenterViewController" bundle:nil];
    personalVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:personalVC animated:YES];
}

-(void)tapCell:(int)Tag{
//    if (Tag == 101) {
//        NotifDeaVC *notiVC = [[NotifDeaVC alloc]init];
//        notiVC.title = @"通知通告";

//        [self.navigationController pushViewController:notiVC animated:YES];

//    }
}

- (void)pushToqingjiaVC {
//    [LToast showWithText:@"跳转请假界面"];

//    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    BaseTabBarViewController *tab = (BaseTabBarViewController *)delegate.window.rootViewController;
//    tab.selectedIndex = 2;
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:2];
}

- (void)pushSignMapVC {
    MapViewController *map = [[MapViewController alloc]init];
    map.title = @"签到";
    [self.navigationController pushViewController:map animated:YES];
}


#pragma mark twodelegate
- (void)homeTableViewCellTwoDidSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

//聊天点击
- (void)chatAction:(UIBarButtonItem *)item {
    
}

//用户点击
- (void)pushAction:(UIBarButtonItem *)item {
    [self.menu show];
}

#pragma mark menuViewdelegate 

-(void)LeftMenuViewClick:(NSDictionary*)dic{
//    [self.menu hidenWithAnimation];
    if (dic.allKeys.count>2) {
        DynamicViewController *vc = [[DynamicViewController alloc]init];
        vc.title = @"工作动态";
        vc.leftView = self.leftView;
        vc.LeaderID  = [NSString stringWithFormat:@"%@",dic[@"leaderID"]];
        [self.navigationController pushViewController:vc  animated:YES];
    }else{
        
    }
}

-(void)LeftMenuViewSectionClick:(NSDictionary *)dic{
    OfficeVC *vc = [[OfficeVC alloc]init];
    vc.groupID = [NSString stringWithFormat:@"%@",dic[@"groupID"]];
    vc.leftView= self.leftView;
    vc.menu = self.menu;
    vc.title = [NSString stringWithFormat:@"%@",dic[@"name"]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

//    [self setNavLabel];
    self.leftView.customDelegate = self;

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self clearNavLabel];
    self.leftView.customDelegate = nil;
}

-(void)dealloc{

}

- (void)clearNavLabel {
    [_numLabel removeFromSuperview];
    [_dotLabel removeFromSuperview];
}

- (void)setNavLabel {
    //几人在线
    UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(48, 0, 100, 44)];
    _numLabel = numLab;
    numLab.text = @"(215人在线)";
    numLab.textColor = [UIColor whiteColor];
    numLab.font = [UIFont systemFontOfSize:13.0];
    [self.navigationController.navigationBar addSubview:numLab];
    //点点
    CGFloat dotheight = 6;
    UILabel *dotLab = [[UILabel alloc] initWithFrame:CGRectMake(43,6,dotheight,dotheight)];
    _dotLabel = dotLab;
    dotLab.backgroundColor = [UIColor redColor];
    dotLab.layer.cornerRadius = dotheight/2;
    dotLab.layer.masksToBounds = YES;
    [self.navigationController.navigationBar addSubview:dotLab];
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
