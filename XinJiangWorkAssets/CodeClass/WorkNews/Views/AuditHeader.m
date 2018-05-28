//
//  AuditHeader.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/4/23.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "AuditHeader.h"

@implementation AuditHeader

-(void)awakeFromNib{
    [super awakeFromNib];
    self.BcView.layer.cornerRadius = 8;
    self.BcView.layer.masksToBounds = YES;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
