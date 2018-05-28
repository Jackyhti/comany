//
//  OnWorkViewController.m
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/6.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "OnWorkViewController.h"
#import "OnWorkHeaderView.h"
#import "WorkTableViewCellOne.h"
#import "OnWorkTableViewCell.h"
#import "OnWorkTableViewCellOne.h"
#import "OnWorkTableViewCellThree.h"
#import "ChuChaiTableViewCell.h"
#import "OnworkHeaderModel.h"
#import "ApprovalViewController.h"
#import "QingJiaVC.h"

#define TableHeaderHeight 60

@interface OnWorkViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *_dateStr;
    NSString *_dayStr;
    CGSize size;
    int selectSection;
}


@property (strong, nonatomic) IBOutlet UITableView *onTableView;

@property (nonatomic, retain)NSMutableArray *dataSource;

@property(nonatomic,strong)NSString *Type;

@end

@implementation OnWorkViewController
{
    NSString *_state;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"在岗调整";
        self.isHiddenBackBtn = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavBtn];
    [self initData];
    [self configureTableView];
    [self setFooterView];
    
    [self getData];
}


-(void)getData{
    
    NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
    NSString *LeaderID = [NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]];
    //    NSLog(@"%@",userDic);
    NSDictionary *dic = @{@"LeaderID":LeaderID};
    [[NetworkSingleton sharedManager] postDataToResult:dic url:kWorkState successBlock:^(ModelRequestResult *responseBody) {
        if(responseBody.succWDJH) {
            [self hiddenLoadingMinView];
            [self.onTableView.mj_header endRefreshing];
            NSDictionary *responDic = responseBody.responseObject;
            NSLog(@"工作动态%@",responDic);
            _state = responDic[@"data"][@"State"];
            if ([_state isEqualToString:@"在岗"]) {
                OnworkHeaderModel *selectModel =  self.dataSource[0];
                selectModel.isOpen = @"1";
            }else if ([_state isEqualToString:@"请假"]){
                OnworkHeaderModel *selectModel =  self.dataSource[1];
                selectModel.isOpen = @"1";
            }else if ([_state isEqualToString:@"单位内开会"]){
                OnworkHeaderModel *selectModel =  self.dataSource[2];
                selectModel.isOpen = @"1";
            }else if ([_state isEqualToString:@"单位外开会"]){
                OnworkHeaderModel *selectModel =  self.dataSource[3];
                selectModel.isOpen = @"1";
            }else if ([_state isEqualToString:@"出差"]){
                OnworkHeaderModel *selectModel =  self.dataSource[4];
                selectModel.isOpen = @"1";
            }else if ([_state isEqualToString:@"其他"]){
                OnworkHeaderModel *selectModel =  self.dataSource[5];
                selectModel.isOpen = @"1";
            }
        }
        [self.onTableView reloadData];
    } failureBlock:^(ModelRequestResult *error) {
        [self hiddenLoadingMinView];
        [LToast showWithText:error.errorMsg];
    }];

}

-(void)setNavBtn{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"审批" style:2 target:self action:@selector(itemAct)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)itemAct{
    ApprovalViewController *vc = [[ApprovalViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = @"请假审批";
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)initData {
    NSString *path=[[NSBundle mainBundle] pathForResource:@"OnWork" ofType:@"plist"];
    //读取数据到 NsDictionary字典中
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:path];
    for(int i = 0;i < array.count;i++) {
        NSDictionary *dic = array[i];
        OnworkHeaderModel *model = [OnworkHeaderModel mj_objectWithKeyValues:dic];
        [self.dataSource addObject:model];
    }
    [self.onTableView reloadData];
}

- (void)configureTableView {
    [self.onTableView registerNib:[UINib nibWithNibName:@"WorkTableViewCellOne" bundle:nil] forCellReuseIdentifier:@"WorkTableViewCellOne"];
    [self.onTableView registerNib:[UINib nibWithNibName:@"OnWorkTableViewCell" bundle:nil] forCellReuseIdentifier:@"OnWorkTableViewCell"];
    [self.onTableView registerNib:[UINib nibWithNibName:@"OnWorkTableViewCellOne" bundle:nil] forCellReuseIdentifier:@"OnWorkTableViewCellOne"];
    [self.onTableView registerNib:[UINib nibWithNibName:@"OnWorkTableViewCellThree" bundle:nil] forCellReuseIdentifier:@"OnWorkTableViewCellThree"];
    
    [self.onTableView registerNib:[UINib nibWithNibName:@"ChuChaiTableViewCell" bundle:nil] forCellReuseIdentifier:@"ChuChaiTableViewCell"];

    [self.onTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.onTableView.tableFooterView = [UIView new];
    self.onTableView.separatorInset = UIEdgeInsetsZero;
    self.onTableView.layoutMargins = UIEdgeInsetsZero;
    
}

- (void)setFooterView {
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Kscreen_width, 200)];
    footer.backgroundColor = [UIColor clearColor];
    
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, Kscreen_width-20, 50)];
    nextBtn.backgroundColor = kHomeColor;
    [nextBtn setTitle:@"保存" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.layer.cornerRadius = 5;
    nextBtn.layer.masksToBounds = YES;
    [nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:nextBtn];
    
    self.onTableView.tableFooterView = footer;
  
}


#pragma mark tabledelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    OnworkHeaderModel *model = self.dataSource[section];
//    if(section == 1) {
//        if([model.isOpen isEqualToString:@"1"]) {
//            return 4;
//        }else {
//            return 0;
//        }
//    }else if(section == 4) {
//        if([model.isOpen isEqualToString:@"1"]) {
//            return 2;
//        }else {
//            return 0;
//        }
//    }else {
//        return 0;
//    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1) {
        if(indexPath.row == 0) {
            WorkTableViewCellOne *oneCell = [tableView dequeueReusableCellWithIdentifier:@"WorkTableViewCellOne" forIndexPath:indexPath];
            oneCell.btnTapBlack = ^(QRadioButton *btn) {
                [LToast showWithText:btn.titleLabel.text];
            };
            return oneCell;
        }else if(indexPath.row == 2) {
            OnWorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OnWorkTableViewCell" forIndexPath:indexPath];
            cell.dateLabel.text = _dateStr;
            return cell;
        }else if(indexPath.row == 1) {
            OnWorkTableViewCellOne *cell = [tableView dequeueReusableCellWithIdentifier:@"OnWorkTableViewCellOne" forIndexPath:indexPath];
         
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            OnWorkTableViewCellThree *cell = [tableView dequeueReusableCellWithIdentifier:@"OnWorkTableViewCellThree" forIndexPath:indexPath];
            cell.dayLabel.text = _dayStr;
            cell.addTapBlack = ^(UILabel *dLab) {
                CGFloat d = [dLab.text floatValue];
                d += 0.5;
                _dayStr = [NSString stringWithFormat:@"%.2f",d];
                
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:1];
                
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            };
            cell.minusTapBlack = ^(UILabel *dLab) {
                CGFloat d = [dLab.text floatValue];
                if(d > 0) {
                    d -= 0.5;
                    _dayStr = [NSString stringWithFormat:@"%.2f",d];
                }
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:1];
                
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            };
            return cell;
        }
    }else {
        ChuChaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChuChaiTableViewCell" forIndexPath:indexPath];
        if(indexPath.row == 0) {
            cell.leftLab.text = @"出差地点";
            cell.detailLab.text = @"乌鲁木齐 到 山东";
        }else {
            cell.leftLab.text = @"备注";
            cell.detailLab.text = @"无";
        }
        return cell;
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    if(indexPath.section == 1) {
        if(indexPath.row == 1) {
            
        }
        if(indexPath.row == 2) {
            WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *startDate) {
                NSString *start = [startDate stringWithFormat:@"YYYY-MM-dd"];
                _dateStr = start;
                
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:1];
                
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                NSLog(@"时间： %@",start);
            }];
            datepicker.doneButtonColor = kHomeColor;//确定按钮的颜色
            [datepicker show];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OnWorkHeaderView" owner:self options:nil];
    //得到第一个UIView
    OnWorkHeaderView *headerView = [nib objectAtIndex:0];
    headerView.section = section;
    headerView.model = self.dataSource[section];
    if(section == (self.dataSource.count-1)) {
        headerView.lineView.backgroundColor = [UIColor clearColor];
    }
    headerView.tapBlack = ^(NSInteger sec) {
        
        OnworkHeaderModel *selectModel =  self.dataSource[section];

        if([selectModel.isOpen isEqualToString:@"0"]) {
            selectModel.isOpen = @"1";
            selectSection = (int)section;
        }else {
            selectModel.isOpen = @"0";
        }
        [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            OnworkHeaderModel *dModel = (OnworkHeaderModel *)obj;
            if(![dModel.str isEqualToString:selectModel.str]) {
                dModel.isOpen = @"0";
            }
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.onTableView reloadData];
        });
    };
    return headerView;
}

#pragma mark 点击下一步
- (void)nextAction:(UIButton *)btn {
    int a = 0;
    for (int i = 0; i<self.dataSource.count; i++) {
        OnworkHeaderModel *selectModel =  self.dataSource[i];
        if ([selectModel.isOpen isEqualToString:@"1"]) {
            NSString *sta = [NSString stringWithFormat:@"%d",i];
            [self sendState:sta];
        }
        if ([selectModel.isOpen isEqualToString:@"0"] ) {
            a ++;
            if (a == 6) {
                [LToast showWithText:@"请至少选择一种状态"];
            }
        }
    }
}

-(void)sendState:(NSString*)sta{
    NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
    NSString *LeaderID = [NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]];
    NSDictionary *dic = @{@"LeaderID":LeaderID,@"State":sta,@"Remark":@""};
    [[NetworkSingleton sharedManager] postDataToResult:dic url:ksendState successBlock:^(ModelRequestResult *responseBody) {
        if(responseBody.succWDJH) {
            [self hiddenLoadingMinView];
            [self.onTableView.mj_header endRefreshing];
            [LToast showWithText:@"修改成功"];
            self.Type = sta;
            NSNotification *not = [[NSNotification alloc]initWithName:@"ty" object:self userInfo:@{@"type":sta}];
            [[NSNotificationCenter defaultCenter]postNotification:not];
             self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];
        }
        [self.onTableView reloadData];
    } failureBlock:^(ModelRequestResult *error) {
        [self hiddenLoadingMinView];
        [LToast showWithText:error.errorMsg];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
    if (scrollView == self.onTableView)
    {
        CGFloat sectionHeaderHeight = TableHeaderHeight;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return TableHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    
    if(indexPath.section == (self.dataSource.count-1)) {
        return 45;
    }else {
        return TableHeaderHeight;
    }
    
    
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}



- (NSMutableArray *)dataSource {
    if(_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
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
