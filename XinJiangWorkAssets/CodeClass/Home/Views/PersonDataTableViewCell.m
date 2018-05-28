//
//  PersonDataTableViewCell.m
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/7.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "PersonDataTableViewCell.h"




@implementation PersonDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
