//
//  YBDynamicTableViewCell.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/3/9.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderModel.h"


@interface YBDynamicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *ybType;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;


@property(nonatomic,strong)HeaderModel *model;

@end
