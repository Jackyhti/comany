//
//  AuditFooterView.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/4/23.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "AuditFooterView.h"

@implementation AuditFooterView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.tgBtn.layer.cornerRadius = 8;
    self.tgBtn.layer.masksToBounds = YES;
    self.btgBtn.layer.cornerRadius = 8;
    self.btgBtn.layer.masksToBounds = YES;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.cornerRadius = 8;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)tgAC:(id)sender {
    self.sendResult(@"1");
}

- (IBAction)btgAC:(id)sender {
    self.sendResult(@"-1");
}


@end
