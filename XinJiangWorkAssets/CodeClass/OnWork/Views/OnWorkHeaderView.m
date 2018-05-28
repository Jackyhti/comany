//
//  OnWorkHeaderView.m
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/9.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "OnWorkHeaderView.h"


@interface OnWorkHeaderView()


@property (strong, nonatomic) IBOutlet UIImageView *leftImgView;

@property (strong, nonatomic) IBOutlet UILabel *titleLab;

@property (strong, nonatomic) IBOutlet UIImageView *rightImgView;

@property (weak, nonatomic) IBOutlet UISwitch *swithBtn;

@end




@implementation OnWorkHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTapAction:)];
    [self addGestureRecognizer:tap];
    self.rightImgView.hidden = YES;
    //但这里我们练习了获取值变动病利用isOn来做相应的操作
    [self.swithBtn addTarget:self action:@selector(getValue) forControlEvents:UIControlEventValueChanged];
    
}

- (void)setModel:(OnworkHeaderModel *)model {
    self.leftImgView.image = [UIImage imageNamed:model.pic];
    self.titleLab.text = model.str;
    if([model.isOpen isEqualToString:@"0"]) {
        self.rightImgView.image = [UIImage imageNamed:@"Radio"];
        [self.swithBtn setOn:NO animated:NO];
    }else {
        self.rightImgView.image = [UIImage imageNamed:@"Radio_click"];
        [self.swithBtn setOn:YES animated:NO];

    }
}

- (void)headerTapAction:(UITapGestureRecognizer *)tap {
    
    self.tapBlack(self.section);
}

-(void)getValue{
    self.tapBlack(self.section);
}

@end
