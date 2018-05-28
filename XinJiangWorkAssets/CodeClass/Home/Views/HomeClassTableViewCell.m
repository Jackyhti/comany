//
//  HomeClassTableViewCell.m
//  XinJiangWorkAssets
//
//  Created by mac on 2017/8/17.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "HomeClassTableViewCell.h"

@interface HomeClassTableViewCell()



@end


@implementation HomeClassTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

//    self.leftLabel.font = self.statusLab.font = [UIFont systemFontOfSize:SCALE(50)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
