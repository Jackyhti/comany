//
//  ReleaseTableViewCell.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/1/19.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupListModel.h"
@interface ReleaseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labCon;
@property (weak, nonatomic) IBOutlet UIImageView *checkImage;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;

@property (weak, nonatomic) IBOutlet UIImageView *acimage;
@property(nonatomic,strong)GroupListModel *model;
@property (weak, nonatomic) IBOutlet UILabel *numLab;

@end
