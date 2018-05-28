//
//  ZanTableViewCell.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/3/20.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "ZanTableViewCell.h"

@interface ZanTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *zanLab;

@end

@implementation ZanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.zanLab.backgroundColor = HEXCOLOR(0xf2f2f2);
    
    NSString *str = @"成龙，小明，柏玉，小张，李四，王五,阿里巴巴，腾讯，网易，新浪，百度，巨人";
    self.zanLab.attributedText = [self stringWithUIImage:str];
    
}

- (NSAttributedString *)stringWithUIImage:(NSString *) contentStr {
    // 创建一个富文本
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    // 修改富文本中的不同文字的样式
    //    [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 5)];
    //    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 5)];
    
    /**
     添加图片到指定的位置
     */
    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
    // 表情图片
    attchImage.image = [UIImage imageNamed:@"zan"];
    // 设置图片大小
    attchImage.bounds = CGRectMake(0, 0, 15, 15);
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
    [attriStr insertAttributedString:stringImage atIndex:0];
    
    // 设置数字为红色
    /*
     [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, 9)];
     [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(5, 9)];
     */
    //NSDictionary * attrDict = @{ NSFontAttributeName: [UIFont fontWithName: @"Zapfino" size: 15],
    // NSForegroundColorAttributeName: [UIColor blueColor] };
    
    //创建 NSAttributedString 并赋值
    //_label02.attributedText = [[NSAttributedString alloc] initWithString: originStr attributes: attrDict];
//    NSDictionary * attriBute = @{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:30]};
//    [attriStr addAttributes:attriBute range:NSMakeRange(5, 9)];
    
    //    // 添加表情到最后一位
    //    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    //    // 表情图片
    //    attch.image = [UIImage imageNamed:@"jiedu"];
    //    // 设置图片大小
    //    attch.bounds = CGRectMake(0, 0, 40, 15);
    //
    //    // 创建带有图片的富文本
    //    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    //    [attriStr appendAttributedString:string];
    
    return attriStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
