//
//  QjTwoTableViewCell.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/26.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "QjTwoTableViewCell.h"

@implementation QjTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

-(void)setDataArr:(NSArray*)dataArr Row:(int)row{
    if (dataArr != nil) {
        if (row == 0) {
            _leftLab.text = @"请假天数";
            _rightLab.text = [NSString stringWithFormat:@"%@",dataArr[0]];
        }else {
            _leftLab.text = @"请假理由";
            _rightLab.text = [NSString stringWithFormat:@"%@",dataArr[1]];
        }
    }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
