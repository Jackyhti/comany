//
//  AuditTwoTableViewCell.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/4/23.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "AuditTwoTableViewCell.h"

@implementation AuditTwoTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tgBtn.layer.cornerRadius = 8;
    self.tgBtn.layer.masksToBounds = YES;
    self.btgBtn.layer.cornerRadius = 8;
    self.btgBtn.layer.masksToBounds = YES;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.cornerRadius = 8;
    // Initialization code
}
- (IBAction)tgAc:(id)sender {
    
    
}

- (IBAction)btgAc:(id)sender {
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
