//
//  OnWorkTableViewCellThree.m
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/13.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "OnWorkTableViewCellThree.h"

@implementation OnWorkTableViewCellThree

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (IBAction)addAction:(id)sender {
    self.addTapBlack(self.dayLabel);
}


- (IBAction)minusAction:(id)sender {
    self.minusTapBlack(self.dayLabel);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
