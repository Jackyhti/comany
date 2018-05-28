//
//  YBDynamicTableViewCell.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/3/9.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "YBDynamicTableViewCell.h"

@implementation YBDynamicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(HeaderModel *)model{
    _titleLab.text =[NSString stringWithFormat:@"（%@）%@",model.RowNum,model.Title];
    if ([model.IsChecked isEqualToString:@"0"]) {
_typeLab.text = @"[待审核]";
        _typeLab.textColor = [UIColor orangeColor];
    }else if ([model.IsChecked isEqualToString:@"1"]){
    _typeLab.text = @"[通过]";
        _typeLab.textColor = kColor(0, 165, 15, 1);
    }else if ([model.IsChecked isEqualToString:@"-1"]){
    _typeLab.text = @"[未通过]";
        _typeLab.textColor = [UIColor redColor];
    }
    _nameLab.text = model.Name;
    _ybType.text = model.Position;
    _timeLab.text = model.PubTime;
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
