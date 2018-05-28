//
//  YuanBuDynamicVC.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/3/9.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "YuanBuDynamicVC.h"
#import "YBDynamicTableViewCell.h"
#import "NewsEditViewController.h"
#import "photoModel.h"
#import "HeaderModel.h"
#import "AuditViewController.h"

@interface YuanBuDynamicVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property(nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation YuanBuDynamicVC
{
    NSInteger _offset;
    NSInteger ListPage;                                 //当前列表页
    
}

-(NSMutableArray*)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUI];
    [self setNavBtn];
    [self setUpRefresh];
    [self  loadFirstData];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadData) name:@"reload" object:nil];
}


-(void)reloadData{
    [self loadFirstData];
}

- (void)setUpRefresh {
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFirstData)];
    
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadListMoreData)];
    
    //    [self.tableView.mj_header beginRefreshing];
    
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
    NSString *LeaderID = [NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]];
    
    NSDictionary *dic = @{@"LeaderId":LeaderID,@"Type":@"0",@"Page":[NSString stringWithFormat:@"%ld",ListPage]};

    
    [self showLoadingMinView];
    
    [[NetworkSingleton sharedManager]postDataToResult:dic url:kchenkList successBlock:^(ModelRequestResult *responseBody) {
        [self hiddenLoadingMinView];
        [self.myTableView.mj_header endRefreshing];
        
        if (responseBody.succWDJH) {
            NSDictionary *dataDic = responseBody.responseObject;
            
            if (_offset == 0) {
                [self.dataSource removeAllObjects];
            }
            
            for (NSDictionary *dic in dataDic[@"list"]) {
                HeaderModel *model = [HeaderModel mj_objectWithKeyValues:dic];
                NSArray *dics = dic[@"imgUrls:"];
                NSMutableArray *ptodataSource = [NSMutableArray array];
                
                for (NSDictionary *dic in dics) {
                    NSLog(@"%@",dic);
                    photoModel *model = [photoModel mj_objectWithKeyValues:dic];
                    [ptodataSource  addObject:model];
                }
                
                
                model.imgUrls = ptodataSource;
                [self.dataSource addObject:model];
            }
//            NSArray *arr = dataDic[@"list"][0][@"NoticeList"];
            
            
//            for (NSDictionary *dic in arr) {
//                NotifiationListModel *modle = [NotifiationListModel mj_objectWithKeyValues:dic];
//                [self.dataSource addObject:modle];
//            }
            
            if (self.dataSource.count > (K_List_limit_Count - 1)) {
                
                [self.myTableView.mj_footer endRefreshing];
                
                ListPage ++;
            }else{
                [self.myTableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            if(dataDic.count == 0) {
                [self.myTableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        }else{
            [self.myTableView.mj_header endRefreshing];
            [self.myTableView.mj_footer endRefreshing];
        }
        //        [LToast showWithText:responseBody.msgWDJH bottomOffset:100];
        
        [_myTableView reloadData];
        
    } failureBlock:^(ModelRequestResult *error) {
        [self hiddenLoadingMinView];
        [LToast showWithText:error.errorMsg];
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    }];
}




-(void)setNavBtn{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(itemAct)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)itemAct{
    NewsEditViewController *editVC = [[NewsEditViewController alloc] init];
    editVC.backReolad = ^(int a) {
        [self reloadData];
    };
    [self.navigationController pushViewController:editVC animated:YES];
}

-(void)setUI{
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YBDynamicTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([YBDynamicTableViewCell class])];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YBDynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YBDynamicTableViewCell class]) forIndexPath:indexPath];
    
    cell.model = self.dataSource[indexPath.row];
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HeaderModel *model = [[HeaderModel alloc]init];
    model = self.dataSource[indexPath.row];
        AuditViewController *vc =[[AuditViewController alloc]init];
        vc.title = @"院部动态-审核";
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 70;
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
