//
//  ApprovalTableViewCell.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/23.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "ApprovalTableViewCell.h"

@implementation ApprovalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.xian.backgroundColor = kCellSpColor;
    
    self.quan.backgroundColor = [UIColor redColor];
    self.quan.layer.masksToBounds = YES;
    self.quan.layer.cornerRadius = 5;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
