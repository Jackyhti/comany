//
//  FooterSection.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/5/9.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "FooterSection.h"

@implementation FooterSection

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    [super awakeFromNib];
    
    _bcView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.bcView.layer.cornerRadius = 10;
    self.bcView.layer.masksToBounds = YES;
    self.bcView.layer.borderWidth = 1.0;
    
    _left.backgroundColor = [UIColor lightGrayColor];
    _right.backgroundColor = [UIColor lightGrayColor];
}

@end
