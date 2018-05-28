//
//  QingJiaVC.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/26.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "QingJiaVC.h"
#import "QingJiaTableViewCell.h"
#import "QjTwoTableViewCell.h"
#import "QJThreeTableViewCell.h"
@interface QingJiaVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation QingJiaVC
{
    NSArray *dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUI];
    [self setFooterView];
    dataArr = @[@"2",@"医院陪护陪护医院陪护陪护医院陪护陪护医院陪护陪护陪护医院陪护陪护陪护医院陪护陪护"];
}

-(void)setUI{
    [self.myTableView registerNib:[UINib nibWithNibName:@"QingJiaTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([QingJiaTableViewCell class])];
    [self.myTableView registerNib:[UINib nibWithNibName:@"QjTwoTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([QjTwoTableViewCell class])];
    [self.myTableView registerNib:[UINib nibWithNibName:@"QJThreeTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([QJThreeTableViewCell class])];
}

- (void)setFooterView {
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Kscreen_width, 100)];
    footer.backgroundColor = [UIColor clearColor];
    
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, Kscreen_width-20, 50)];
    nextBtn.backgroundColor = kHomeColor;
    [nextBtn setTitle:@"提交" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.layer.cornerRadius = 5;
    nextBtn.layer.masksToBounds = YES;
    [nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:nextBtn];
    
    self.myTableView.tableFooterView = footer;
    
}

-(void)nextAction:(UIButton*)btn{


}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
         QingJiaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([QingJiaTableViewCell class]) forIndexPath:indexPath];
        NSArray *arr = @[@"事假",@"2017-05-08",@"2017-05-10"];
        [cell setDataArr:arr Row:(int)indexPath.row];
        return cell;
    }else if (indexPath.section == 1){
        QjTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([QjTwoTableViewCell class]) forIndexPath:indexPath];
        [cell setDataArr:dataArr Row:(int)indexPath.row];
        return cell;
    }else if (indexPath.section == 2){
        QJThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([QJThreeTableViewCell class]) forIndexPath:indexPath];
        cell.selectView.hidden = YES;
        self.showInView  = cell.conView;
        self.maxCount = 2;
        [self initPickerView];
        
        return cell;
    }else{
        QJThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([QJThreeTableViewCell class]) forIndexPath:indexPath];
       cell.titleLab.text = @"审批人";
        return cell;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 3;
    }else if (section == 1){
        return 2;
    }else{
        return 1;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            return 60;
        }else{
            if ([self getHightWithStr:dataArr[1]] <= 21) {
                return 60;
            }else{
                return  [self getHightWithStr:dataArr[1]] + 20 ;
            }
        }
    }else if(indexPath.section == 2){
        return Kscreen_width/4 + 60;
    }else{
        return 93+41+16;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
 
        return 10;
}

- (float)getHightWithStr:(NSString *)str
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    NSDictionary *attributes = @{
                                 
                                 NSFontAttributeName:[UIFont systemFontOfSize:17],
                                 
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 
                                 };
    
    CGSize size = CGSizeMake(Kscreen_width-73.5-60, 1000);
    
    CGSize contentactually = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    
  
    return contentactually.height;
    
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
