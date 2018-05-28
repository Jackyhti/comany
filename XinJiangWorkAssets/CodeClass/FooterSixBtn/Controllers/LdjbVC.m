//
//  LdjbVC.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/5/16.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "LdjbVC.h"
#import "InformationLdjbCell.h"
#import "NomalLdjbCell.h"
#import "popupDeaVC.h"
#import "AppDelegate.h"
#import "AddViewController.h"
@interface LdjbVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation LdjbVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    
    
    self.myTableView.estimatedRowHeight = 200;
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
}

-(void)initData{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cc:) name:@"cc" object:nil];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"InformationLdjbCell" bundle:nil] forCellReuseIdentifier:@"inforCell"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"NomalLdjbCell" bundle:nil] forCellReuseIdentifier:@"noCell"];
}

-(void)cc:(NSNotification*)not{

    NSLog(@"标记%@",not);

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        InformationLdjbCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inforCell" forIndexPath:indexPath];
        return cell;
    }else{
        NomalLdjbCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noCell" forIndexPath:indexPath];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    popupDeaVC *view = [[popupDeaVC alloc]init];
    view.view.frame = CGRectMake(0, 0, Kscreen_width, Kscreen_height);
//    view.popView = view;
    [view showView];
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
