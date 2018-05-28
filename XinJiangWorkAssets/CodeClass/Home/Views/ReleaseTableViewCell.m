//
//  ReleaseTableViewCell.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/1/19.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "ReleaseTableViewCell.h"

@implementation ReleaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.checkBtn setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
    [self.checkBtn setImage:[UIImage imageNamed:@"checkbox_click"] forState:UIControlStateSelected];
    // Initialization code
}


-(void)setModel:(GroupListModel *)model{
    self.labCon.text = model.Name;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        self.labCon.textColor = [UIColor blueColor];
    }else{
//        self.accessoryType = UITableViewCellAccessoryNone;
//        self.labCon.textColor = [UIColor blackColor];
    }
   
    // Configure the view for the selected state
}

@end
