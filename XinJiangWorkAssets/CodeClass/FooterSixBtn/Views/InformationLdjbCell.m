//
//  InformationLdjbCell.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/5/16.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "InformationLdjbCell.h"

@implementation InformationLdjbCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bcView.layer.cornerRadius = 10;
    self.bcView.layer.masksToBounds = YES;
    self.bcView.layer.borderWidth = 1.0;
    self.bcView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.header.backgroundColor = [UIColor colorWithHexString:@"#ced7e7"];
    
    self.userPhoto.layer.cornerRadius = 15;
    self.userPhoto.layer.masksToBounds = YES;
    
    self.jqLab.textColor = [UIColor colorWithHexString:@"#986318"];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"近期有2天未汇报,距离计划完成日期还有4天，请尽快执行和回报！"];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    //定义图片内容及位置和大小
    attch.image = [UIImage imageNamed:@"laba"];
    attch.bounds = CGRectMake(0, -2, 15, 15);
    //创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];

    [AttributedStr insertAttributedString:string atIndex:0];
    _jqLab.attributedText = AttributedStr;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
