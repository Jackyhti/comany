//
//  HomeTableViewCellThree.h
//  XinJiangWorkAssets
//
//  Created by mac on 2017/8/16.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupInfoMoel.h"
@interface HomeTableViewCellThree : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *titelLabel;

@property(nonatomic,retain)GroupInfoMoel *bumenModel;

@property(nonatomic,retain)GroupInfoMoel *yuanBuModel;

@end
