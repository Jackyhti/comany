//
//  NotifitationViewController.m
//  XinJiangWorkAssets
//
//  Created by mac on 2017/8/17.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "NotifitationViewController.h"
#import "NotiTableViewCell.h"
#import "ReleaseViewController.h"
#import "NotifiationListModel.h"
#import "NoticeModel.h"
#import "NotifDeaVC.h"
@interface NotifitationViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSInteger _offset;
    NSInteger ListPage;                                 //当前列表页
    
    
}


@property (nonatomic, retain)UITableView *tableView;

//数据源
@property (nonatomic, retain)NSMutableArray *dataSource;

@end

@implementation NotifitationViewController

static NSString *const cellId = @"NotiTableViewCell";


- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    
    [self loadFirstData];
    
    //初始化tableview
    [self setUpTableView];
    
    //    //设置刷新控件
    [self setUpRefresh];
    
    //发布通知后
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reload) name:@"fb" object:nil];
    
}

-(void)reload{
    [self loadFirstData];
}

- (void)setupNav {
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"addP"] style:UIBarButtonItemStylePlain target:self action:@selector(publicAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}


- (void)setUpTableView {
    
    UITableView *tabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height-64) style:UITableViewStylePlain];
    self.tableView = tabV;
    tabV.backgroundColor = kColor(237, 238, 239, 1);
    
    tabV.separatorInset = UIEdgeInsetsZero;
    tabV.layoutMargins = UIEdgeInsetsZero;
    tabV.dataSource = self;
    tabV.delegate = self;
    tabV.tableFooterView = [UIView new];
    [self.view addSubview:tabV];
    
    
    //注册cell
    [tabV registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
    
}

- (void)setUpRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFirstData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadListMoreData)];
    
//    [self.tableView.mj_header beginRefreshing];
    
}


#pragma mark - <UICollectionViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NotiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCALE(190);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NoticeModel *model = self.dataSource[indexPath.row];

    NotifDeaVC *vc = [[NotifDeaVC alloc]init];
    vc.backReload = ^(NSString *a) {
        [self loadFirstData];
    };
    vc.title = @"通知详情";
    vc.model = model;
    
    [self setRead:model];

    [self.navigationController pushViewController:vc animated:YES];
    

}

-(void)setRead:(NoticeModel*)model{
    NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
    //    self.dataSource = [NSMutableArray array];
    
    
    NSDictionary *dic = @{@"LeaderId":[NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]],
                          @"NoticeId":[NSString stringWithFormat:@"%@",model.ID]};
    
    [[NetworkSingleton sharedManager] postDataToResult:dic url:kSetNoticeRead successBlock:^(ModelRequestResult *responseBody) {
        if(responseBody.succWDJH) {
            [self loadFirstData];
        }
    } failureBlock:^(ModelRequestResult *error) {
        [LToast showWithText:error.errorMsg];
    }];

}



#pragma mark 请求数据
- (void)loadFirstData {
    
    _offset = 0;
    ListPage = 1;
    
    
    [self refreshData];
    
}


-(void)loadListMoreData {
    _offset = _offset + 10;
    
    [self refreshData];
    
}

-(void)refreshData{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        //
        [self requestListData];
        dispatch_async(dispatch_get_main_queue(), ^{
            //update UI
            //            [_myTableView reloadData];
        });
    });
}


- (void)requestListData {
    NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
    //    self.dataSource = [NSMutableArray array];
    
    
    NSDictionary *dic = @{@"LeaderID":[NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]],
                          @"Page":[NSString stringWithFormat:@"%ld",(long)ListPage]};
    
    
    [self showLoadingMinView];
    
    [[NetworkSingleton sharedManager]postDataToResult:dic url:kNotiListUrl successBlock:^(ModelRequestResult *responseBody) {
        [self hiddenLoadingMinView];
        [self.tableView.mj_header endRefreshing];
        
        if (responseBody.succWDJH) {
            NSDictionary *dataDic = responseBody.responseObject;
            
            if (_offset == 0) {
                [self.dataSource removeAllObjects];
            }
            
            NSArray *arr = dataDic[@"list"][0][@"NoticeList"];
            
            
            for (NSDictionary *dic in arr) {
                NotifiationListModel *modle = [NotifiationListModel mj_objectWithKeyValues:dic];
                [self.dataSource addObject:modle];
            }
            
            if (self.dataSource.count > (K_List_limit_Count - 1)) {
                
                [self.tableView.mj_footer endRefreshing];
                
                ListPage ++;
            }else{
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            if(dataDic.count == 0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        }else{
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
//        [LToast showWithText:responseBody.msgWDJH bottomOffset:100];
        
        [_tableView reloadData];
        
    } failureBlock:^(ModelRequestResult *error) {
        [self hiddenLoadingMinView];
        [LToast showWithText:error.errorMsg];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark  跳转public界面

- (void)publicAction:(UIBarButtonItem *)item {
    ReleaseViewController *releaseVC = [[ReleaseViewController alloc]init];
 
    releaseVC.title = @"发布";
    [self.navigationController pushViewController:releaseVC animated:YES];
 //   [LToast showWithText:@"跳转public界面"];
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
