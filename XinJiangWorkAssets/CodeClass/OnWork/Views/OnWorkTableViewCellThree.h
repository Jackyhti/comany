//
//  OnWorkTableViewCellThree.h
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/13.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnWorkTableViewCellThree : UITableViewCell

//加法
@property(nonatomic,copy)void(^addTapBlack)(UILabel *dayLab);

//减法
@property(nonatomic,copy)void(^minusTapBlack)(UILabel *dayLab);

@property (strong, nonatomic) IBOutlet UILabel *dayLabel;


@end
