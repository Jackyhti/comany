//
//  AuditViewController.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/4/23.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "AuditViewController.h"
#import "AuditHeader.h"
#import "AuditTableViewCell.h"
#import "AuditFooterView.h"
@interface AuditViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property(nonatomic,strong)AuditFooterView *footerView;

@end

@implementation AuditViewController
{
    CGFloat btgF;  //不通过时候底部的高
    NSString *jg;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUI];
    
    [self setFooter];
    
}

-(void)setUI{
    [self.myTableView registerNib:[UINib nibWithNibName:@"AuditTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    AuditHeader *headerView = [[[NSBundle mainBundle] loadNibNamed:@"AuditHeader" owner:self options:nil]firstObject];

    NSString *typeStr;
    if ([_model.Type isEqualToString:@"1"]) {
        typeStr = @"中心动态";
    }else if ([_model.Type isEqualToString:@"2"]){
    typeStr = @"部门动态";
    }
    
    headerView.titleLab.text = typeStr;
    
    self.myTableView.estimatedRowHeight = 50;
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    self.myTableView.tableHeaderView = headerView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMove)];
    [self.myTableView addGestureRecognizer:tap];
    
}

-(void)setFooter{
    if ([self.model.IsChecked isEqualToString:@"0"]) {
        _footerView = [[[NSBundle mainBundle]loadNibNamed:@"AuditFooterView" owner:self options:nil] firstObject];
        _footerView.textView.delegate = self;
        _footerView.frame = CGRectMake(0, Kscreen_height-200-64, Kscreen_width, 200);
        __weak typeof(self)weakSelf = self;
        _footerView.sendResult = ^(NSString *str) {
            jg = str;
            
            
            if ([jg isEqualToString:@"-1"] && weakSelf.footerView.textView.text.length < 1) {
                [LToast showWithText:@"请填写不通过原因"];
            }else{
                [weakSelf sendData];}
        };
        [self.myTableView addSubview:_footerView];
    }else if ([self.model.IsChecked isEqualToString:@"1"]){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, Kscreen_height-64-60, Kscreen_width, 60)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *titLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 40)];
        titLab.text = @"审核状态:";
        [view addSubview:titLab];
        UILabel *conLab = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 80, 40)];
        conLab.text = @"审核通过";
        conLab.textColor = [UIColor greenColor];
        [view addSubview:conLab];
        [self.view addSubview:view];
    }else if ([self.model.IsChecked isEqualToString:@"-1"]){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, Kscreen_height-64-60, Kscreen_width, 60 )];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *titLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 40)];
        titLab.text = @"审核状态:";
        [view addSubview:titLab];
        
        UILabel *titLab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 80, 40)];
        titLab2.text = @"原因:";
        [view addSubview:titLab2];
        
        UILabel *conLab = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 120, 40)];
        conLab.text = @"审核未通过";
//        ReasonNote
        UILabel *con2Lab = [[UILabel alloc]initWithFrame:CGRectMake(100, 60, Kscreen_width-120, 40)];
        con2Lab.numberOfLines = 0;
        con2Lab.text = self.model.ReasonNote;
        [con2Lab sizeToFit];
        
        
        conLab.textColor = [UIColor redColor];
        [view addSubview:conLab];
        [view addSubview:con2Lab];
        if (con2Lab.frame.size.height<40) {
            [con2Lab setOrigin:CGPointMake(100, 60)];
            view.frame = CGRectMake(0, Kscreen_height-64-60-60, Kscreen_width, 60+60);
        }else{
            [view setFrame:CGRectMake(0, Kscreen_height-64-60-con2Lab.frame.size.height-20, Kscreen_width, 60+con2Lab.frame.size.height+20+10)];
            btgF = 60+con2Lab.frame.size.height+20+10;
        }
        [self.view addSubview:view];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([self.model.IsChecked isEqualToString:@"0"]) {
        return 200;
    }else if ([self.model.IsChecked isEqualToString:@"1"]){
        return 60;
    }else if ([self.model.IsChecked isEqualToString:@"-1"]){
        return btgF;
    }else{
        return 60;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        AuditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.conLab.text = self.model.PubTime;
        return cell;
    }else if (indexPath.row == 1){
        AuditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.titleLab.text = @"标题";
        cell.photo.hidden = YES;
        cell.conLab.text = self.model.Title;
        return cell;
    }else if (indexPath.row == 2){
        AuditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.titleLab.text = @"内容";
        cell.photo.hidden = YES;
        cell.conLab.text = self.model.Content;
        return cell;
    }else{
        return nil;
    }
   
}


-(void)sendData{
    [self showLoadingMinView];
    NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
    NSString *LeaderID = [NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]];
    
    NSNotification *not = [[NSNotification alloc]initWithName:@"reload" object:nil userInfo:nil];
    
    NSDictionary *dic = @{@"LeaderID":LeaderID,@"Result":jg,@"dynamicId":self.model.ID,@"Note":_footerView.textView.text};
    
    [[NetworkSingleton sharedManager] postDataToResult:dic url:kAuditResult successBlock:^(ModelRequestResult *responseBody) {
        if(responseBody.succWDJH) {
            [self hiddenLoadingMinView];
            [self.myTableView.mj_header endRefreshing];
            [LToast showWithText:@"回复成功"];
            [[NSNotificationCenter defaultCenter] postNotification:not];

            [self.navigationController popViewControllerAnimated:YES];
        }
        [self.myTableView reloadData];
    } failureBlock:^(ModelRequestResult *error) {
        [self hiddenLoadingMinView];
        [LToast showWithText:error.errorMsg];
    }];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
[UIView animateWithDuration:0.3 animations:^{
    self.myTableView.contentOffset = CGPointMake(0, 300);
}];
}

-(void)tapMove{
    [UIView animateWithDuration:0.5 animations:^{
        [self.myTableView endEditing:YES];
        self.myTableView.contentOffset = CGPointMake(0, 0);
    }];
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
