//
//  OfficeVC.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/3/2.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "OfficeVC.h"
#import "OfficeHeaderView.h"
#import "testTableViewCell.h"
#import "WorkHeaderSectionView.h"
#import "GroupInfoMoel.h"
#import "MyArrangeModel.h"
#import "ZanWorkTableViewCell.h"
#import "HeaderSectionView.h"
#import "DynamicViewController.h"
#import "JudgeViewController.h"
#import "WorkPersonModel.h"
#import "WorkTableViewCell.h"
#import "FooterSection.h"
@interface OfficeVC ()<UITableViewDelegate,UITableViewDataSource,HomeMenuViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property(nonatomic,strong)GroupInfoMoel *allModel;

@property (nonatomic, retain)NSMutableArray *workDataArr;

@property (nonatomic, retain)NSMutableArray *workJudgeArr;

@property(nonatomic,retain)OfficeHeaderView *hearView;

@property(nonatomic,strong)NSMutableArray *judgeArr;

@end

@implementation OfficeVC
{
    NSString* _dateStr;
    int _type; //判断显示自己的弹框，还是别人的弹框

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //刷新
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getFirstPageData) name:@"close" object:nil];
    
    [self setUI];
    [self setNav];
    [self getFirstPageData];
    [self getWorkType];
//    [self.menu show];
}


-(void)setUI{
    
    self.myTableView.estimatedRowHeight = 50;//Cell自适应高度
    self.myTableView.sectionFooterHeight = 20;
    //cell高度自己计算
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([testTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([testTableViewCell class])];
    
     [self.myTableView registerNib:[UINib nibWithNibName:@"ZanWorkTableViewCell" bundle:nil] forCellReuseIdentifier:@"zancell"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"WorkTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *now = [formatter stringFromDate:date];
    
    _dateStr = now;

    
    OfficeHeaderView *header = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([OfficeHeaderView class]) owner:self options:nil] firstObject];
    _hearView = header;
    header.frame = CGRectMake(0, 0, Kscreen_width, 338);
    
    [header setNetworkBlock:^(NSString *date){
        _dateStr = date;
        [self getFirstPageData];
        [self getWorkType];
    }];
    self.myTableView.tableHeaderView = header;
    
}

-(void)getWorkType{
    _judgeArr  = [NSMutableArray array];
    NSMutableArray *data = [NSMutableArray array];
    NSDictionary *dic = @{@"GroupID":_groupID,@"Date":_dateStr};
    [[NetworkSingleton sharedManager] postDataToResult:dic url:kWorkType successBlock:^(ModelRequestResult *responseBody) {
        if(responseBody.succWDJH) {
            NSDictionary *dic = responseBody.responseObject;
            _hearView.dic = dic;
//           NSDictionary *dataDic = dic[@"list"][0];
//            for (int i =0; i<dataDic.count; i++) {
//                NSArray *ar = dataDic[[NSString stringWithFormat:@"strlist%d",i]];
//                for (int n = 0; n<ar.count; n++) {
//                    NSDictionary *dic = ar[n];
//                    [data addObject:dic[@"LeaderID"]];
//                }
//            }
            [self hiddenLoadingMinView];
        }
    } failureBlock:^(ModelRequestResult *error) {
        [self hiddenLoadingMinView];
        [LToast showWithText:error.errorMsg];
    }];
}

-(void)getFirstPageData{
    [self showLoadingMinView];
    NSString *leaderID;
    
    self.workDataArr = [NSMutableArray array];


    NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
    leaderID = [NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]];

    NSDictionary *dic = @{@"LeaderID":leaderID,@"Date":_dateStr,@"GroupID":_groupID};
    [[NetworkSingleton sharedManager] postDataToResult:dic url:kallPeron successBlock:^(ModelRequestResult *responseBody) {
        if(responseBody.succWDJH) {
            [self hiddenLoadingMinView];

            NSDictionary *responDic = responseBody.responseObject;
            _allModel = [GroupInfoMoel mj_objectWithKeyValues:responDic];
//            NSDictionary *dataDic = _allModel.data;
            
            for (int i = 0 ; i<_allModel.list.count; i++) {
                NSDictionary *dic = _allModel.list[i];
                WorkPersonModel *model = [WorkPersonModel mj_objectWithKeyValues:dic];
                
                NSMutableArray *arrData = [NSMutableArray array];
                for (int i = 0; i<model.ArrangeList.count; i++) {
                    MyArrangeModel *arrModel = [MyArrangeModel mj_objectWithKeyValues:model.ArrangeList[i]];
                    [arrData addObject:arrModel];
                }
                model.ArrangeList = arrData;
                [self.workDataArr  addObject:model];
        }
//        NSLog(@"%@",self.workDataArr);
//        self.workDataArr = (NSMutableArray*)[[_workDataArr reverseObjectEnumerator] allObjects];
        
        [self.myTableView reloadData];
        [self.myTableView.mj_header endRefreshing];
        }
    } failureBlock:^(ModelRequestResult *error) {
        [self hiddenLoadingMinView];
        
        [LToast showWithText:error.errorMsg];
        [self.myTableView.mj_header endRefreshing];
        
    }];
}

-(void)setNav{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"USERS"] style:UIBarButtonItemStylePlain target:self action:@selector(pushAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (NSMutableArray *)workDataArr {
    if(_workDataArr == nil) {
        _workDataArr = [NSMutableArray array];
    }
    return _workDataArr;
}

- (NSMutableArray *)workJudgeArr {
    if(_workJudgeArr == nil) {
        _workJudgeArr = [NSMutableArray array];
    }
    return _workJudgeArr;
}

#pragma mark menuViewdelegate

-(void)LeftMenuViewClick:(NSDictionary*)dic{
//    self.title = [NSString stringWithFormat:@"%@",dic[@"name"]];
    DynamicViewController *dyvc = [[DynamicViewController alloc]init];
    dyvc.title = [NSString stringWithFormat:@"个人动态"];
    dyvc.LeaderID = dic[@"leaderID"];
    dyvc.leftView = self.leftView;
    [self.navigationController pushViewController:dyvc animated:YES];
}

-(void)LeftMenuViewSectionClick:(NSDictionary *)dic{
    self.title = [NSString stringWithFormat:@"%@",dic[@"name"]];
    _groupID = dic[@"groupID"];
    
    [self getFirstPageData];
    [self getWorkType];
}

//用户点击
- (void)pushAction:(UIBarButtonItem *)item {
    [self.menu show];
}

#pragma mark tableviewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HeaderSectionView *view = [[[NSBundle mainBundle] loadNibNamed:@"HeaderSectionView" owner:self options:nil] firstObject];
    
    WorkPersonModel *model  = _workDataArr[section];
    view.conLab.text = [NSString stringWithFormat:@"%@ %@",model.Name,model.PostName];
    
    NSString *url = [model.ImgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [view.photoImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",KBASE_ImageURL,url]] placeholderImage:[UIImage imageNamed:@"personZW"]];
    
//    view.sec = section;
//    NSInteger num = self.workDataArr.count;
//    if (num>0) {
//        view.model = self.workDataArr[section];
//    }
//    
//    
//    
//    view.tapView = ^(int a) {
//        JudgeViewController *add = [[JudgeViewController alloc]init];
//        MyArrangeModel *model = [[MyArrangeModel alloc]init];
//        model = self.workDataArr[section];
//        NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
//        NSLog(@"%@",model.Arrange[@"LeaderID"]);
//        if (![model.Arrange[@"LeaderID"] isEqualToString:userDic[@"data"][@"LeaderID"] ]) {
//            _type = 0;
//        }else{
//            _type = 1;
//        }
//        add.view.frame = CGRectMake(0, 0,Kscreen_width,Kscreen_height);
//        [add showInView:_type];
//        [add.judge sendModel:model Type:_type];
//    };
    return view;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    FooterSection *view = [[[NSBundle mainBundle] loadNibNamed:@"FooterSection" owner:self options:nil] firstObject];

    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return _workDataArr.count;
    return _workDataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSMutableArray *judgeArr = [NSMutableArray array];
//    MyArrangeModel *model = self.workDataArr[section];
//    for (NSDictionary *dic in model.Judge) {
//        JudgeModel *model = [JudgeModel mj_objectWithKeyValues:dic];
//        if (model.Content.length>0) {
//            [judgeArr addObject:model];
//        }
//        _judgeArr = judgeArr;
//
//    }
//    if (model.IsZanNames.length>0) {
//        
//        return judgeArr.count+1;
//        
//    }else{
//        return judgeArr.count;
//    }
    WorkPersonModel *model  = _workDataArr[section];
    return model.ArrangeList.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"                  　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　    　　　　　　　　　　　　　　　　　       　　　　　      　　     　　　　　　　　　  　　　　　　　　　        　　　　　　　　　　　                                                                                                                                                                                                            forIndexPath:indexPath];
    WorkPersonModel *model  = _workDataArr[indexPath.section];
    MyArrangeModel *arrmodel = model.ArrangeList[indexPath.row];
    cell.conLab.text = [NSString stringWithFormat:@"(%ld) %@",indexPath.row+1,arrmodel.Arrange[@"Content"]];
    
    NSString *str;
    if ([arrmodel.Status isEqualToString:@"1"]) {
        str = @"[进行中]";
    }else if ([arrmodel.Status isEqualToString:@"2"]){
        str = @"[已完成]";
    }else if ([arrmodel.Status isEqualToString:@"3"]){
        str = @"[已取消]";
    }else if ([arrmodel.Status isEqualToString:@"4"]){
        str = @"[未完成]";
    }else if ([arrmodel.Status isEqualToString:@"5"]){
        str = @"[继续做]";
    }
    
    cell.typeLab.text = str;
//    MyArrangeModel *amodel = self.workDataArr[indexPath.section];
//    
//    if (amodel.IsZanNames.length>0) {
//        if (indexPath.row == 0) {
//
//            ZanWorkTableViewCell *zancell = [tableView dequeueReusableCellWithIdentifier:@"zancell" forIndexPath:indexPath];
//            
//            zancell.zanStr = [NSString stringWithFormat:@" %@",amodel.IsZanNames];
//            
//            return zancell;
//        }else{
//            cell.row = indexPath.row-1;
//        }
//        
//    }else{
//        cell.row = indexPath.row;
//    }
//    
//    
//    NSMutableArray *judgeArr = [NSMutableArray array];
//    for (NSDictionary *dic in amodel.Judge) {
//        JudgeModel *model = [JudgeModel mj_objectWithKeyValues:dic];
//        if (model.Content.length>0) {
//            [judgeArr addObject:model];
//        }
//        
//    }
//    cell.arr = judgeArr;
//    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JudgeViewController *add = [[JudgeViewController alloc]init];
    WorkPersonModel *model  = _workDataArr[indexPath.section];
    MyArrangeModel *arrmodel = model.ArrangeList[indexPath.row];
            NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
            if (![arrmodel.Arrange[@"LeaderID"] isEqualToString:userDic[@"data"][@"LeaderID"] ]) {
                _type = 0;
            }else{
                _type = 1;
            }
            add.view.frame = CGRectMake(0, 0,Kscreen_width,Kscreen_height);
            [add showInView:_type];
            [add.judge sendModel:arrmodel Type:_type];
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
