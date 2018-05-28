//
//  WorkTableViewCellOne.m
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/12.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "WorkTableViewCellOne.h"
#import "QRadioButton.h"


#define BtnWID  60

@interface WorkTableViewCellOne()<QRadioButtonDelegate>

@property (strong, nonatomic) IBOutlet UIView *bgView;


@end


@implementation WorkTableViewCellOne
{
    QRadioButton *_shijianBtn;
    QRadioButton *_bingjiaBtn;
    QRadioButton *_yearjiaBtn;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setUI];
}

- (void)setUI {
    //事假
    _shijianBtn = [[QRadioButton alloc] initWithDelegate:self groupId:@"groupId1"];
    [_shijianBtn setTitle:@"事假" forState:UIControlStateNormal];
    [_shijianBtn setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.7] forState:UIControlStateNormal];
    [_shijianBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
//    _shijianBtn.backgroundColor  = [UIColor yellowColor];
    _shijianBtn.delegate = self;
    
    [self.bgView addSubview:_shijianBtn];

    //病假
    _bingjiaBtn = [[QRadioButton alloc] initWithDelegate:self groupId:@"groupId1"];
    [_bingjiaBtn setTitle:@"病假" forState:UIControlStateNormal];
    [_bingjiaBtn setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.7] forState:UIControlStateNormal];
    [_bingjiaBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
    //    _yBtn.backgroundColor  = [UIColor yellowColor];
    _bingjiaBtn.delegate = self;
    [self.bgView addSubview:_bingjiaBtn];
    //年假
    _yearjiaBtn = [[QRadioButton alloc] initWithDelegate:self groupId:@"groupId1"];
    [_yearjiaBtn setTitle:@"年假" forState:UIControlStateNormal];
    [_yearjiaBtn setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.7] forState:UIControlStateNormal];
    [_yearjiaBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
    //    _yBtn.backgroundColor  = [UIColor yellowColor];
    _yearjiaBtn.delegate  = self;
    [self.bgView addSubview:_yearjiaBtn];
    
}

- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId {
    self.btnTapBlack(radio);
}


- (void)layoutSubviews {
    
    _shijianBtn.frame = CGRectMake(25, 0, BtnWID, self.frame.size.height);
    _bingjiaBtn.frame = CGRectMake(_shijianBtn.frame.origin.x+_shijianBtn.frame.size.width+15, 0, BtnWID, self.frame.size.height);
    _yearjiaBtn.frame = CGRectMake(_bingjiaBtn.frame.origin.x+_bingjiaBtn.frame.size.width+15, 0, BtnWID, self.frame.size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
