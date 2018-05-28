//
//  QingJiaTableViewCell.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/26.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "QingJiaTableViewCell.h"

@implementation QingJiaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDataArr:(NSArray*)dataArr Row:(int)row{
    if (dataArr != nil) {
        if (row == 0) {
            _leftLab.text = @"请假类型";
            _rightLab.text = [NSString stringWithFormat:@"%@",dataArr[0]];
        }else if ((int)row == 1){
            _leftLab.text = @"开始时间";
            _rightLab.text = [NSString stringWithFormat:@"%@",dataArr[1]];
        }else{
            _leftLab.text = @"结束时间";
            _rightLab.text = [NSString stringWithFormat:@"%@",dataArr[2]];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
