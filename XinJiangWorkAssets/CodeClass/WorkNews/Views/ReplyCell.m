//
//  ReplyCell.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/5.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "ReplyCell.h"
#import "NSAttributedString+YYText.h"
#import "YYLabel+MessageHeight.h"
#import "NSString+SimpleModifier.h"

@implementation ReplyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.conView.backgroundColor = HEXCOLOR(0xf2f2f2);
    [self addsubViews];
    [self setUp];
    // Initialization code
}

#pragma mark --------- 添加视图 -----------
- (void)addsubViews{
    [self.contentView sd_addSubviews:@[self.commentLabel]];
}


- (void)setUp{
    self.commentLabel.sd_layout
    .widthIs(Kscreen_width-70)
    .leftSpaceToView(self.contentView,35)
    .topSpaceToView(self.contentView,0);
}

- (YYLabel *)commentLabel{
    if (!_commentLabel) {
        _commentLabel = [YYLabel new];
        _commentLabel.font = [UIFont systemFontOfSize:14];
        _commentLabel.textColor = HEXCOLOR(0x4c4c4c);
        _commentLabel.numberOfLines = 0;
        _commentLabel.preferredMaxLayoutWidth = Kscreen_width-70; //设置最大的宽度
        _commentLabel.displaysAsynchronously = YES; /// enable async display
        YYTextSimpleEmoticonParser *parser = [YYTextSimpleEmoticonParser new];
        parser.emoticonMapper  = [NSString retunRichTextDic];
        YYTextLinePositionSimpleModifier *mod = [YYTextLinePositionSimpleModifier new];
        mod.fixedLineHeight = 22.5;
        _commentLabel.textParser = parser;
        _commentLabel.linePositionModifier = mod;
    }
    return _commentLabel;
}



-(void)setModel:(ReplyModel *)model{
    if (model.ToUserName) {
        NSRange range = NSMakeRange(0, model.CUserName.length);
        
        NSRange toRange = NSMakeRange(model.CUserName.length+4,model.ToUserName.length);
        
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[[NSString stringWithFormat:@"%@ 回复 %@:%@",model.CUserName,model.ToUserName,model.CommentText] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] attributes:@{NSForegroundColorAttributeName:HEXCOLOR(0x303030)}];
        
        [text addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x5583f0) range:range];
        [text addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x5583f0) range:toRange];
        
        _conLab.attributedText = text;
    }else{
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[[NSString stringWithFormat:@"%@: %@",model.CUserName,model.CommentText] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] attributes:@{NSForegroundColorAttributeName:HEXCOLOR(0x303030)}];
        //        text.yy_font = [UIFont systemFontOfSize:14];
        NSRange range = NSMakeRange(0, model.CUserName.length);
        [text addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x5583f0) range:range];
        _conLab.attributedText = text;
    
    }

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
