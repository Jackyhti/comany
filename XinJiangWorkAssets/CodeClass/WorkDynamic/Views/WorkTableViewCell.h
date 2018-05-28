//
//  WorkTableViewCell.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/5/9.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *conLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UIView *left;
@property (weak, nonatomic) IBOutlet UIView *right;

@end
