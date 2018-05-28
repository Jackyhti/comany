//
//  HomeTableViewCellThree.m
//  XinJiangWorkAssets
//
//  Created by mac on 2017/8/16.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "HomeTableViewCellThree.h"


@interface HomeTableViewCellThree()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topH;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labHeight;


//背景底部视图
@property (weak, nonatomic) IBOutlet UIView *backGroundView;


//label1
@property (weak, nonatomic) IBOutlet UILabel *label1;


//lable1 status
@property (weak, nonatomic) IBOutlet UILabel *labeltatus1;


//label2

@property (weak, nonatomic) IBOutlet UILabel *label2;


// label2 status

@property (weak, nonatomic) IBOutlet UILabel *labeltatus2;


@end

@implementation HomeTableViewCellThree

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.topH.constant = SCALE(120);
    self.labHeight.constant =  (SCALE(400) - SCALE(120) - 12 - 12)/2;

    self.backGroundView.layer.cornerRadius = 10;
    self.backGroundView.layer.masksToBounds = YES;
    self.backGroundView.layer.borderWidth = 1.0;
    self.backGroundView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.titelLabel.font = [UIFont systemFontOfSize:SCALE(55)];
    //更改个人信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:@"change" object:nil];
//    self.label1.font = self.label2.font = self.labeltatus1.font = self.labeltatus2.font = [UIFont systemFontOfSize:SCALE(50)];
}



-(void)setBumenModel:(GroupInfoMoel *)bumenModel{
    NSDictionary *dic = bumenModel.list[0];
    NSArray *ar = dic[@"BuMen"];
    if (ar.count>0) {
        self.label1.text = [NSString stringWithFormat:@"(1)%@",dic[@"BuMen"][0][@"Title"]];
    }
    
    if (ar.count>1) {
        self.label2.text = [NSString stringWithFormat:@"(2)%@",dic[@"BuMen"][1][@"Title"]];
    }
    [self title];

}


-(void)reload{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self title];
    });

}

-(void)title{
    NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUser];
    NSString *bm = [NSString stringWithFormat:@"%@ - 部门动态",userDic[@"data"][@"DeptName"]];
    self.titelLabel.text = bm;
}



-(void)setYuanBuModel:(GroupInfoMoel *)yuanBuModel{
    NSDictionary *dic = yuanBuModel.list[0];
    NSArray *ar = dic[@"YuanBu"];

    if (ar.count>0) {
        self.label1.text = [NSString stringWithFormat:@"(1)%@",dic[@"YuanBu"][0][@"Title"]];

    }
    if (ar.count>1) {
        self.label2.text = [NSString stringWithFormat:@"(2)%@",dic[@"YuanBu"][1][@"Title"]];

    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
