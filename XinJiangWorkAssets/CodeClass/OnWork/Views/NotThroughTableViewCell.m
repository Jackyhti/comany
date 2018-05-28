//
//  NotThroughTableViewCell.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/24.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "NotThroughTableViewCell.h"

@interface NotThroughTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UILabel *levelLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIImageView *stateImage;
@property (weak, nonatomic) IBOutlet UILabel *conLab;

@end


@implementation NotThroughTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
