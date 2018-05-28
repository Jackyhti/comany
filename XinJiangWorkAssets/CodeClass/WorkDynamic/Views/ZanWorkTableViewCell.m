//
//  ZanWorkTableViewCell.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/4/13.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "ZanWorkTableViewCell.h"

@implementation ZanWorkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setZanStr:(NSString *)zanStr{

    self.zanLab.attributedText = [self stringWithUIImage:zanStr];
}

- (NSAttributedString *)stringWithUIImage:(NSString *) contentStr {
    // 创建一个富文本
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:contentStr];

    /**
     添加图片到指定的位置
     */
    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
    // 表情图片
    attchImage.image = [UIImage imageNamed:@"zan_click"];
    // 设置图片大小
    attchImage.bounds = CGRectMake(0, 0, 15, 15);
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
    [attriStr insertAttributedString:stringImage atIndex:0];
    

    return attriStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
