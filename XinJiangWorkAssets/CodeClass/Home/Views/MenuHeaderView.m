//
//  MenuHeaderView.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/1/15.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "MenuHeaderView.h"

@implementation MenuHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor =[RGB(46, 64, 160) colorWithAlphaComponent:0.0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(act)];
    [self addGestureRecognizer:tap];
}


-(void)setGroupModel:(GroupModel *)groupModel{
    self.conLab.text = groupModel.GroupName;
    if ([groupModel.isOpen isEqualToString:@"1"]) {
        self.conLab.textColor = kColor(255, 241, 111, 1);
    }else{
        self.conLab.textColor = [UIColor whiteColor];
    }
}

-(void)act{
    self.tapBlack(self.sec);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
