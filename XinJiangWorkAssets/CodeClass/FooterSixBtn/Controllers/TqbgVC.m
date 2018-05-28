//
//  TqbgVC.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/5/23.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "TqbgVC.h"
#import "TqbgTableViewCell.h"
#import "TqHeader.h"
#import "TqFooter.h"

#import "TqPhotoUpVC.h"

#import "TqVoiceUpVC.h"

#import "TqVedioUpVC.h"

#import "popupReplyVC.h"

@interface TqbgVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property(nonatomic,strong)UISegmentedControl *segment;

@end

@implementation TqbgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(NavAc)];
    self.navigationItem.rightBarButtonItem = item;
    self.navigationItem.titleView = self.segment;
    

 

    [self setUI];
}

-(void)setUI{
    [self.myTableView registerNib:[UINib nibWithNibName:@"TqbgTableViewCell" bundle:nil] forCellReuseIdentifier:@"tacell"];
    self.myTableView.estimatedRowHeight = 60;
    self.myTableView.estimatedSectionHeaderHeight = 200;
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    self.myTableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    
    self.myTableView.sectionFooterHeight = 80;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TqHeader *headerView = [[[NSBundle mainBundle] loadNibNamed:@"TqHeader" owner:nil options:nil] firstObject];
    int spc = (Kscreen_width-30)/3;

    if (section == 0) {
        headerView.bcHeight.constant = 1;
    }else if (section == 1){
        //图
        headerView.bcHeight.constant = spc;
        for (int i = 0; i<3; i++) {
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(i*(spc+5), 0, spc, spc)];
            image.backgroundColor = [UIColor lightGrayColor];
            [headerView.bcConView addSubview:image];
        }
    }else if (section == 2){
        //音频
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(0, 30, 140, 35);
        [btn setBackgroundImage:[UIImage imageNamed:@"audio_frame_bg1.9"] forState:UIControlStateNormal];
        [headerView.bcConView addSubview:btn];
    }else if (section == 3){
        //视频
        headerView.bcHeight.constant = spc;

        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, spc, spc)];
        image.backgroundColor = [UIColor lightGrayColor];
        [headerView.bcConView addSubview:image];
    }
    
    return headerView;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    TqFooter *footerView = [[[NSBundle mainBundle] loadNibNamed:@"TqFooter" owner:nil options:nil] firstObject];
    
    footerView.readBtn.tag = section + 200;
    footerView.replyBtn.tag = section + 300;
    [footerView.readBtn addTarget:self action:@selector(isreadAC:) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView.replyBtn addTarget:self action:@selector(replayAC:) forControlEvents:UIControlEventTouchUpInside];
    
    return footerView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TqbgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tacell" forIndexPath:indexPath];

    return cell;
}

-(void)NavAc{
    UIAlertController *ale = [UIAlertController alertControllerWithTitle:@"提示" message:@"发布内容" preferredStyle:1];
    UIAlertAction *A = [UIAlertAction actionWithTitle:@"文字图片" style:0 handler:^(UIAlertAction * _Nonnull action) {
        TqPhotoUpVC *vc = [[TqPhotoUpVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIAlertAction *B = [UIAlertAction actionWithTitle:@"语音" style:0 handler:^(UIAlertAction * _Nonnull action) {
        TqVoiceUpVC *soundvc = [[TqVoiceUpVC alloc]init];
        [self.navigationController pushViewController:soundvc animated:YES];
    }];
    UIAlertAction *C = [UIAlertAction actionWithTitle:@"视频" style:0 handler:^(UIAlertAction * _Nonnull action) {
        TqVedioUpVC *vedioVc = [[TqVedioUpVC alloc]init];
        [self.navigationController pushViewController:vedioVc animated:YES];
    }];
    UIAlertAction *D = [UIAlertAction actionWithTitle:@"取消" style:1 handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [ale addAction:A];
    [ale addAction:B];
    [ale addAction:C];
    [ale addAction:D];
    [self presentViewController:ale animated:YES completion:nil];
    
}

-(UISegmentedControl*)segment{
    NSArray *titles = @[@"未读", @"已读"];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:titles];
    segment.frame = CGRectMake(0, 0, 150, 30);
    [segment addTarget:self action:@selector(tapseg:) forControlEvents:UIControlEventValueChanged];
    segment.selectedSegmentIndex = 0;
    return segment;
}

-(void)tapseg:(UISegmentedControl*)seg{
    NSInteger Index = seg.selectedSegmentIndex;
    switch (Index) {
        case 0:
        {
            NSLog(@"分段1");
        }
            break;
        case 1:
        {
            NSLog(@"分段2");
        }
            break;
        default:{
            
        }
            break;
    }
}

-(void)isreadAC:(UIButton*)btn{
    NSLog(@"已读Tag%ld",(long)btn.tag);

}

-(void)replayAC:(UIButton*)btn{
    NSLog(@"回复Tag%ld",(long)btn.tag);
    
    popupReplyVC *view = [[popupReplyVC alloc]init];
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
