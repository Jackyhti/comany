//
//  NotThroughFooter.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/24.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "NotThroughFooter.h"

@implementation NotThroughFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)cxsq:(UIButton *)sender {
    self.passAct(sender);
}

- (IBAction)scsq:(UIButton *)sender {
    self.passTwoAct(sender);
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.btn1.layer.masksToBounds = YES;
    self.btn1.layer.cornerRadius = 6;
    
    self.btn2.layer.masksToBounds = YES;
    self.btn2.layer.cornerRadius = 6;

}


@end
