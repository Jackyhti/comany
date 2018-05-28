//
//  ChuChaiTableViewCell.m
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/14.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "ChuChaiTableViewCell.h"

@implementation ChuChaiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
