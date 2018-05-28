//
//  OnWorkTableViewCell.m
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/12.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "OnWorkTableViewCell.h"

#define BTNWIDTN  60

@interface OnWorkTableViewCell()


@property (strong, nonatomic) IBOutlet UILabel *descLab;

@property (strong, nonatomic) IBOutlet UIImageView *dateImgView;

@end


@implementation OnWorkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}




#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
//    CGFloat h = [[UserInfoManager shareGlobalSettingInstance] heightForString:_myTextView.text fontSize:14.0 andWidth:(Kscreen_width-126)];
//    
    // 让 table view 重新计算高度
//    UITableView *tableView = [self tableView];
//    [tableView beginUpdates];
//    [tableView endUpdates];

}

- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}



- (void)layoutSubviews {

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if(selected) {
    }
    // Configure the view for the selected state
}

@end
