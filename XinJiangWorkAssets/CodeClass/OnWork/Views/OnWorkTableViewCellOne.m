//
//  OnWorkTableViewCellOne.m
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/13.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "OnWorkTableViewCellOne.h"


@implementation OnWorkTableViewCellOne

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _textView.scrollEnabled = YES;
    _textView.autocorrectionType = UITextAutocorrectionTypeNo;

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
