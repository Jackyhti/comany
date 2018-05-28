//
//  QJThreeTableViewCell.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/27.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QJThreeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *conView;
@property (weak, nonatomic) IBOutlet UICollectionView *selectView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end
