//
//  NomalLdjbCell.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/5/16.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "NomalLdjbCell.h"

@implementation NomalLdjbCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bcView.layer.cornerRadius = 10;
    self.bcView.layer.masksToBounds = YES;
    self.bcView.layer.borderWidth = 1.0;
    self.bcView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.userPhoto.layer.cornerRadius = 15;
    self.userPhoto.layer.masksToBounds = YES;
    
    self.header.backgroundColor = [UIColor colorWithHexString:@"#ced7e7"];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
