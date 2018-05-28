//
//  HomeTableViewCellOne.m
//  XinJiangWorkAssets
//
//  Created by mac on 2017/8/16.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "HomeTableViewCellOne.h"

@interface HomeTableViewCellOne()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hei1;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *currentTop;

@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (weak, nonatomic) IBOutlet UILabel *lab2;

@property (weak, nonatomic) IBOutlet UILabel *lab3;

//当前用户
@property (weak, nonatomic) IBOutlet UILabel *currentLab;

//用户
@property (weak, nonatomic) IBOutlet UILabel *userLab;


//在岗
@property (weak, nonatomic) IBOutlet UIButton *btn1;

//签到
@property (weak, nonatomic) IBOutlet UIButton *qiandaoBtn;


//修改
@property (weak, nonatomic) IBOutlet UIButton *xiugaiBtn;

//请假审批中

@property (weak, nonatomic) IBOutlet UIButton *qingjiaBtn;

@end


@implementation HomeTableViewCellOne

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //更改个人信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:@"change" object:nil];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.lineTop.constant = SCALE(500) * 0.55;
    self.hei1.constant = self.lineTop.constant /3;
    self.currentTop.constant = SCALE(30);
    
    self.userLab.font = [UIFont systemFontOfSize:SCALE(50)];
//    self.label1.font = self.lab2.font = self.lab3.font = [UIFont systemFontOfSize:SCALE(49)];
    self.currentLab.font = [UIFont systemFontOfSize:SCALE(50)];
//    self.btn1.titleLabel.font = self.qiandaoBtn.titleLabel.font = self.xiugaiBtn.titleLabel.font = self.qingjiaBtn.titleLabel.font = [UIFont systemFontOfSize:SCALE(46)];
  
    NSString *userName = [[UserInfoManager shareGlobalSettingInstance]getUser][@"data"][@"Name"];
    NSString *userLea = [[UserInfoManager shareGlobalSettingInstance]getUser][@"data"][@"PostName"];
      NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@(%@)",userName,userLea]];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:22.0]
                          range:NSMakeRange(0, userName.length)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor blueColor]
                          range:NSMakeRange(0, userName.length)];
    self.userLab.attributedText = AttributedStr;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(perAction)];
    [self.userLab addGestureRecognizer:tap];
    
    UITapGestureRecognizer *cellOneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellTap:)];
    UITapGestureRecognizer *cellTwoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellTap:)];
    UITapGestureRecognizer *cellThreeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellTap:)];
    self.label1.tag = 101;
    self.lab2.tag = 102;
    self.lab3.tag = 103;
    self.label1.userInteractionEnabled = YES;
    self.lab2.userInteractionEnabled = YES;
    self.lab3.userInteractionEnabled = YES;
    [self.label1 addGestureRecognizer:cellOneTap];
    [self.lab2 addGestureRecognizer:cellTwoTap];
    [self.lab3 addGestureRecognizer:cellThreeTap];

}

-(void)reload{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *userName = [[UserInfoManager shareGlobalSettingInstance]getUser][@"data"][@"Name"];
        NSString *userLea = [[UserInfoManager shareGlobalSettingInstance]getUser][@"data"][@"PostName"];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@(%@)",userName,userLea]];
        [AttributedStr addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:22.0]
                              range:NSMakeRange(0, userName.length)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:[UIColor blueColor]
                              range:NSMakeRange(0, userName.length)];
        self.userLab.attributedText = AttributedStr;
    });
}

-(void)cellTap:(UITapGestureRecognizer*)tap{
//    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer*)tap;
//    
//    int num = (int)[singleTap view].tag;
//    [self.delegate tapCell:num];
}


-(void)setModel:(GroupInfoMoel *)model{
    if (model) {
        NSDictionary *dic = model.list[0];
        NSArray *arr = dic[@"notice"];
        if (arr.count>0) {
             self.label1.text = [NSString stringWithFormat:@"%@  %@",dic[@"notice"][0][@"PubTime"],dic[@"notice"][0][@"Title"]];
        }
        if (arr.count>1) {
           self.lab2.text = [NSString stringWithFormat:@"%@  %@",dic[@"notice"][1][@"PubTime"],dic[@"notice"][1][@"Title"]];
        }
       
        if (arr.count>2) {
              self.lab3.text = [NSString stringWithFormat:@"%@  %@",dic[@"notice"][2][@"PubTime"],dic[@"notice"][2][@"Title"]];
        }
      
    }
}

-(void)setState:(NSString *)state{
  [self.btn1 setTitle:[NSString stringWithFormat:@"[%@]",
                       state] forState:UIControlStateNormal];
}


//跳转个人中心

- (void)perAction {
    [self.delegate pushToPersonalCenterVC];
}

//签到
- (IBAction)signINAction:(id)sender {
    [self.delegate pushSignMapVC];
}
//修改
- (IBAction)changeAction:(id)sender {
    [self.delegate pushSignMapVC];
}

//请假审批中
- (IBAction)qingjiaAction:(id)sender {
}
//在岗状态
- (IBAction)typeAction:(id)sender {
    [self.delegate pushToqingjiaVC];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
