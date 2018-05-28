//
//  ApprovalViewController.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/23.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "ApprovalViewController.h"
#import "ApprovalTableViewCell.h"
#import "NextApprovalVC.h"
#import "NotThroughVC.h"
#import "MeVC.h"

@interface ApprovalViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *shenpiBtn;
@property (weak, nonatomic) IBOutlet UIButton *meBtn;

@end

@implementation ApprovalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUI];
}

-(void)setUI{
    [self.myTableView registerNib:[UINib nibWithNibName:@"ApprovalTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.meBtn.backgroundColor = kCellSpColor;
}

- (IBAction)shenpiAct:(id)sender {
    self.shenpiBtn.backgroundColor = kCellSpColor;
    self.meBtn.backgroundColor = [UIColor whiteColor];
}


- (IBAction)meAct:(id)sender {
    self.shenpiBtn.backgroundColor = [UIColor whiteColor];
    self.meBtn.backgroundColor = kCellSpColor;
    MeVC *mevc = [[MeVC alloc]init];
    mevc.title = @"请假申请详情";
    [self.navigationController pushViewController:mevc animated:YES];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ApprovalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NextApprovalVC *vc = [[NextApprovalVC alloc]init];
        vc.title = @"请假审批";
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row == 1){
        NotThroughVC *vc =[[NotThroughVC alloc]init];
        vc.title = @"审批流程";
        [self.navigationController pushViewController:vc animated:YES];
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
