//
//  DynamicViewController.m
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/14.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "DynamicViewController.h"
#import "JudgeViewController.h"
#import "WorkHeaderView.h"
#import "WorkHeaderSectionView.h"
#import "testTableViewCell.h"
#import "GroupInfoMoel.h"
#import "MyArrangeModel.h"
#import "HeaderSectionView.h"
#import "JudgeModel.h"
#import "ZanWorkTableViewCell.h"
#import "DYHeaderSectionView.h"
@interface DynamicViewController ()<UITableViewDelegate,UITableViewDataSource,HomeMenuViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *dTableView;

@property(nonatomic,strong)UIWebView *webView;


@property (nonatomic, retain)WorkHeaderView  *headerView;

@property(nonatomic,strong)GroupInfoMoel *allModel;

@property (nonatomic, retain)NSMutableArray *workDataArr;
@property (nonatomic, retain)NSMutableArray *workJudgeArr;
//侧边栏
@property (nonatomic ,strong)MenuView *menu;

@property(nonatomic,strong)NSString *dateStr;

@property(nonatomic,strong)NSMutableArray *judgeArr;

@end

@implementation DynamicViewController
{
    int _n;
    int _type; //判断显示自己的弹框，还是别人的弹框
}

-(void)reload{
    [self getFirstPageData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _n = 0;
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *now = [formatter stringFromDate:date];
    
    self.dateStr = now;

    LeftMenuView *leftView = [[LeftMenuView alloc]initWithFrame:CGRectMake(Kscreen_width/2,64,Kscreen_width/2, Kscreen_height-64)];
    leftView.customDelegate = self;
    self.menu = [[MenuView alloc]initWithDependencyView:self.view MenuView:leftView isShowCoverView:NO];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reload) name:@"tj" object:nil];
    
    //更改个人信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloads) name:@"change" object:nil];
    
    //刷新
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloads) name:@"close" object:nil];
    
    [self setupNav];
    [self configureTableView];
    [self setupFreshTableView];
    [self getFirstPageData];
}


-(void)reloads{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getFirstPageData];
    });
}

- (void)configureTableView {
    
    self.dTableView.estimatedRowHeight = 50;//Cell自适应高度
    self.dTableView.estimatedSectionHeaderHeight = 50;
    //cell高度自己计算
    self.dTableView.rowHeight =UITableViewAutomaticDimension;
    __weak DynamicViewController *weakSelf = self;

    [self.dTableView registerNib:[UINib nibWithNibName:@"testTableViewCell" bundle:nil] forCellReuseIdentifier:TestViewCell];
    [self.dTableView registerNib:[UINib nibWithNibName:@"ZanWorkTableViewCell" bundle:nil] forCellReuseIdentifier:@"zancell"];
    
    [self.dTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.dTableView.tableFooterView = [UIView new];
    WorkHeaderView *headerView = [[[NSBundle mainBundle]loadNibNamed:@"WorkHeaderView" owner:nil options:nil] firstObject];
    
//    _headerDic = headerDic;
//    _phoneNum = headerDic[@"Phone"];
//    _myTelNum = headerDic[@"Tel"];
//    self.nameLab1.text = headerDic[@"Name"];
//    self.nameLab2.text = headerDic[@"PostName"];
//    self.nameLab3.text = headerDic[@"DeptName"];
//    
//    [self.avtorImgView sd_setImageWithURL:[NSURL URLWithString:headerDic[@"ImgUrl"]] placeholderImage:[UIImage imageNamed:@"default_icon2"]];
    self.headerView = headerView;
    headerView.frame = CGRectMake(0, 0, self.dTableView.frame.size.width, 213);
    
    [headerView setPhoneBlock:^(NSString *str) {
        [weakSelf takeTelephoneThreeWithPhone:str];
    }];
    
   headerView.change = ^(NSString *btn) {
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:2];
   };
    
    [headerView setNetworkBlock:^(NSString *date){
        _dateStr = date;
        _judgeArr  = [NSMutableArray array];

        [weakSelf getFirstPageData];
    }];
    self.dTableView.tableHeaderView = headerView;
    
    
    self.dTableView.separatorInset = UIEdgeInsetsZero;
    self.dTableView.layoutMargins = UIEdgeInsetsZero;
    
}



- (void)setupFreshTableView {
    //添加下拉的动画图片
    //设置下拉刷新回调
    self.dTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getFirstPageData)];
    //马上进入刷新状态
//    [self.dTableView.mj_header beginRefreshing];
}


-(void)getFirstPageData{
    [self showLoadingMinView];
    NSString *leaderID;
    NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];

    if (self.LeaderID) {
        leaderID = self.LeaderID;
       
        
    }else{
        leaderID = [NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]];
    }
    
    if (![leaderID isEqualToString:userDic[@"data"][@"LeaderID"] ]) {
        _type = 0;
    }else{
        _type = 1;
    }
    self.workDataArr = [NSMutableArray array];
   
    if ([_dateStr isEqualToString:@""]) {
        
    }
    
    NSDictionary *dic = @{@"LeaderID":leaderID,@"isLeader":@"1",@"Date":_dateStr,@"keyword":@"",@"pagesize":@"20",@"currentpageIndex":@"0",@"AppID":@"0"};
    [[NetworkSingleton sharedManager] postDataToResult:dic url:MYDYNAMIC successBlock:^(ModelRequestResult *responseBody) {
        if(responseBody.succWDJH) {
            [self hiddenLoadingMinView];
            NSDictionary *responDic = responseBody.responseObject;
            _allModel = [GroupInfoMoel mj_objectWithKeyValues:responDic];
            NSDictionary *dataDic = _allModel.data;
            self.headerView.headerDic = @{@"Tel":dataDic[@"Tel"],@"Phone":dataDic[@"Phone"],@"Name":dataDic[@"Name"],@"PostName":dataDic[@"PostName"],@"DeptName":dataDic[@"DeptName"],@"ImgUrl":dataDic[@"ImgUrl"],@"State":dataDic[@"State"]};
            NSArray *arr = _allModel.list;
            
            for (int i = 0; i<arr.count; i++) {
                MyArrangeModel *model = [MyArrangeModel mj_objectWithKeyValues:arr[i]];
                [self.workDataArr addObject:model];
            }
        }
        self.workDataArr = (NSMutableArray*)[[_workDataArr reverseObjectEnumerator] allObjects];
        [self.dTableView reloadData];
        [self.dTableView.mj_header endRefreshing];

    } failureBlock:^(ModelRequestResult *error) {
        [self hiddenLoadingMinView];

        [LToast showWithText:error.errorMsg];
        [self.dTableView.mj_header endRefreshing];

    }];
}




-(void)takeTelephoneThreeWithPhone:(NSString *)phone {
    //借助UIWebView打电话,会回来,解决了不越狱的问题
    //注意不要将webView添加到self.view，否则会遮挡原有的视图
    if (_webView == nil) {
        _webView = [[UIWebView alloc]init];
    }
    NSLog(@"%p",_webView);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}


#pragma mark menuViewdelegate

-(void)LeftMenuViewClick:(NSDictionary*)dic{
    self.LeaderID = dic[@"leaderID"];
    
    NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
    NSString *leader = [NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]];
    
    
    if (![dic[@"leaderID"]isEqualToString:leader]) {
        _type = 0;
    }else{
        _type = 1;
    }
    
    [self getFirstPageData];
    
}

-(void)LeftMenuViewSectionClick:(NSDictionary *)dic{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark tableviewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _workDataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *judgeArr = [NSMutableArray array];
    MyArrangeModel *model = self.workDataArr[section];
    for (NSDictionary *dic in model.Judge) {
        
        JudgeModel *model = [JudgeModel mj_objectWithKeyValues:dic];
        if (model.Content.length>0) {
            [judgeArr addObject:model];
        }
        _judgeArr = judgeArr;
    }
    if (model.IsZanNames.length>0) {

        return judgeArr.count+1;
    }else{
        return judgeArr.count;
    }
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    testTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TestViewCell                  　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　    　　　　　　　　　　　　　　　　　       　　　　　      　　     　　　　　　　　　  　　　　　　　　　        　　　　　　　　　　　                                                                                                                                                                                                            forIndexPath:indexPath];
    NSMutableArray *judgeArr = [NSMutableArray array];

    MyArrangeModel *amodel = self.workDataArr[indexPath.section];

    
    for (NSDictionary *dic in amodel.Judge) {
        
        JudgeModel *model = [JudgeModel mj_objectWithKeyValues:dic];
        if (model.Content.length>0) {
            [judgeArr addObject:model];
        }
    }

    if (amodel.IsZanNames.length>0) {
        if (indexPath.row == 0) {
            ZanWorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zancell" forIndexPath:indexPath];
            
            cell.zanStr = [NSString stringWithFormat:@" %@",amodel.IsZanNames];
            
            return cell;
        }else{
        cell.row = indexPath.row-1;
        }
    }else{
        cell.row = indexPath.row;
    }
    if (judgeArr.count>0) {
        cell.arr = judgeArr;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JudgeViewController *add = [[JudgeViewController alloc]init];
    add.view.frame = CGRectMake(0, 0,Kscreen_width,Kscreen_height);
//    [add showInView:<#(MyArrangeModel *)#>];
}



//用户点击
- (void)pushAction:(UIBarButtonItem *)item {
    
    [self.menu show];

}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DYHeaderSectionView *view = [[[NSBundle mainBundle] loadNibNamed:@"DYHeaderSectionView" owner:self options:nil] firstObject];
    view.sec = section;
    NSInteger num = self.workDataArr.count;
    if (num>0) {
        view.model = self.workDataArr[section];
    }
    
    view.tapView = ^(int a) {
        JudgeViewController *add = [[JudgeViewController alloc]init];
        MyArrangeModel *model = [[MyArrangeModel alloc]init];
        model = self.workDataArr[section];
        add.view.frame = CGRectMake(0, 0,Kscreen_width,Kscreen_height);
        [add showInView:_type];
        [add.judge sendModel:model Type:_type];
    };
    return view;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
}

- (void)setupNav {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"USERS"] style:UIBarButtonItemStylePlain target:self action:@selector(pushAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}


#pragma mark Lazing

- (NSMutableArray *)workDataArr {
    if(_workDataArr == nil) {
        _workDataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _workDataArr;
}

- (NSMutableArray *)workJudgeArr {
    if(_workJudgeArr == nil) {
        _workJudgeArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _workJudgeArr;
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
