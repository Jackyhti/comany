//
//  NotThroughVC.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/24.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "NotThroughVC.h"
#import "NotThroughHeader.h"
#import "NotThroughTableViewCell.h"
#import "NotThroughFooter.h"


@interface NotThroughVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation NotThroughVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self  setUI];

}

-(void)setUI{
    [self.myTableView registerNib:[UINib nibWithNibName:@"NotThroughTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}



-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"NotThroughHeader" owner:self options:nil];
  
    NotThroughHeader *header = [arr objectAtIndex:0];

    return header;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    NSArray *arr =[[NSBundle mainBundle]loadNibNamed:@"NotThroughFooter" owner:self options:nil];
    NotThroughFooter *footer = [arr objectAtIndex:0];
    

    footer.passAct = ^(UIButton *sender){
    
        [LToast showWithText:@"重新申请"];
    
    };
    
    footer.passTwoAct = ^(UIButton *sender){
    
        [LToast showWithText:@"删除申请"];
    
    };
    
    
    
    return footer;

}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NotThroughTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.xianTop.hidden = YES;
    }else{
        cell.xianBottom.hidden = YES;
    }
    
    return cell;
}





-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 115;

}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 542;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 98;

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;

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
