//
//  ReplyCell.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/5.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYLabel.h"
#import "ReplyModel.h"

@interface ReplyCell : UITableViewCell
@property (nonatomic, strong) YYLabel *commentLabel;

@property(nonatomic,strong)NSMutableArray *comentArr;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UIView *conView;
@property (weak, nonatomic) IBOutlet UILabel *conLab;

@property(nonatomic,strong)ReplyModel *model;

@end
