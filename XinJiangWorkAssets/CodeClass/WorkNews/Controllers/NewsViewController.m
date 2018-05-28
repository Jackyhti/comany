//
//  NewsViewController.m
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/6.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsHeaderView.h"
#import "photoModel.h"
#import "HeaderFrame.h"
#import "HeaderModel.h"
#import "ReplyModel.h"
#import "ReplyCell.h"
#import "YYLabel.h"
#import "NewsFooterView.h"
#import "YuanBuDynamicVC.h"
#import "NSAttributedString+YYText.h"
#import "YYLabel+MessageHeight.h"
#import "NSString+SimpleModifier.h"
#import "ReplyYBVC.h"
#import "ZanTableViewCell.h"
@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UISegmentedControl *segmentView;

@property(nonatomic,strong)NSMutableArray *dataSource;

@property(nonatomic,strong)NSArray *replyArr;

@end

@implementation NewsViewController
{
    NSInteger _offset;
    NSInteger ListPage;                                 //当前列表页
    NSInteger _segNum;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"院部动态";
        self.isHiddenBackBtn = YES;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.myTableView.estimatedRowHeight = 30;

    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    [self initData];
    [self setNavBtn];
    [self.view addSubview:self.segmentView];
    //    //设置刷新控件
    [self setUpRefresh];
    
    [self loadFirstData];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadFirstData) name:@"reload" object:nil];

}

-(void)initData{

    _segNum = 0;
    [self.myTableView registerNib:[UINib nibWithNibName:@"ReplyCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"ZanTableViewCell" bundle:nil] forCellReuseIdentifier:@"zancell"];

}

-(void)setNavBtn{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"管理" style:2 target:self action:@selector(itemAct)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)itemAct{
    YuanBuDynamicVC *vc = [[YuanBuDynamicVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = @"院部动态管理";
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)setUpRefresh {
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFirstData)];
    
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadListMoreData)];
    
    //    [self.tableView.mj_header beginRefreshing];
}

-(UISegmentedControl*)segmentView{
    if (!_segmentView) {
        NSArray *arr = @[@"全部",@"中心动态",@"部门动态"];
        _segmentView = [[UISegmentedControl alloc]initWithItems:arr];
        //2.配置属性
        _segmentView.frame = CGRectMake(Kscreen_width/5, 15, Kscreen_width/5*3, 35);
        _segmentView.layer.cornerRadius = 35/2;
        _segmentView.layer.masksToBounds = YES;
        _segmentView.layer.borderColor = kColor(237, 238, 239, 1).CGColor;
        _segmentView.layer.borderWidth = 1;
        //1.)设置默认选中的分段
        _segmentView.selectedSegmentIndex = 0;
        _segmentView.tintColor = [UIColor whiteColor];
        _segmentView.backgroundColor = kColor(237, 238, 239, 1);
        NSDictionary *dic = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]};
        [_segmentView setTitleTextAttributes:dic forState:UIControlStateNormal];
        [_segmentView setTitleTextAttributes:dic forState:UIControlStateSelected];
        [_segmentView addTarget:self action:@selector(handleSegment:) forControlEvents:UIControlEventValueChanged];
    
    }
    return _segmentView;
}


-(NSMutableArray*)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
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
                          @"Page":[NSString stringWithFormat:@"%ld",(long)ListPage],
                          @"Type":[NSString stringWithFormat:@"%ld",(long)_segNum]
                          };
    
    
    [self showLoadingMinView];
    
    [[NetworkSingleton sharedManager]postDataToResult:dic url:kYBDynamicList successBlock:^(ModelRequestResult *responseBody) {
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
                
                NSArray *repdic =dic[@"comments:"];
                NSMutableArray *repDataSource = [NSMutableArray array];
                for (NSDictionary *dic in repdic) {
                    ReplyModel *model = [ReplyModel mj_objectWithKeyValues:dic];
                    [repDataSource addObject:model];
                }
                model.imgUrls = ptodataSource;
                model.comments = repDataSource;
                [self.dataSource addObject:model];
            }
            

            
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






-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    HeaderModel *model = self.dataSource[section];
  HeaderFrame *FrameModel = [[HeaderFrame alloc]initWithModel:model];
    return FrameModel.headerHight;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *arr = [[NSBundle mainBundle]loadNibNamed:@"NewsHeaderView" owner:self options:nil];
    NewsHeaderView *view = [arr  objectAtIndex:0];
    
    HeaderModel *model = self.dataSource[section];
    view.FrameModel = [[HeaderFrame alloc]initWithModel:model];
    
    return view;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    NewsFooterView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NewsFooterView class]) owner:self options:nil] firstObject];
    
    view.repllyBtn.tag = 100+section;
    
    [view.repllyBtn addTarget:self action:@selector(replyAct:) forControlEvents:UIControlEventTouchUpInside];
    
    return view;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

 HeaderModel *model = self.dataSource[section];
 return  model.comments.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    ReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.indexPath = indexPath;
        HeaderModel *model = self.dataSource[indexPath.section];
        cell.model = model.comments[indexPath.row];
        return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}

-(void)replyAct:(UIButton*)btn{
    
//    NSLog(@"%ld",btn.tag - 100);
    ReplyYBVC *vc = [[ReplyYBVC alloc]init];
    
    vc.backReolad = ^(int a) {
        [self loadFirstData];
    };
    vc.title = @"院部动态-回复";
    vc.model = self.dataSource[btn.tag-100];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)handleSegment:(UISegmentedControl*)seg{
    NSInteger Index = seg.selectedSegmentIndex;
    switch (Index) {
        case 0:
        {
            _segNum = 0;
            [self.myTableView.mj_header beginRefreshing];

        }
            break;
        case 1:
        {
            _segNum = 1;
            [self.myTableView.mj_header beginRefreshing];

        }
            break;
        default:{
            _segNum = 2;
            [self.myTableView.mj_header beginRefreshing];

        }
            break;
    }
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NewsEditViewController *editVC = [[NewsEditViewController alloc] init];
//    [self.navigationController pushViewController:editVC animated:YES];
//}

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
