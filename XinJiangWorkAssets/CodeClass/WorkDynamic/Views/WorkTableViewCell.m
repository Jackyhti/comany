//
//  WorkTableViewCell.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/5/9.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "WorkTableViewCell.h"

@implementation WorkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    _left.backgroundColor = [UIColor lightGrayColor];
    _right.backgroundColor = [UIColor lightGrayColor];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
