//
//  HomeTableViewCellTwo.h
//  XinJiangWorkAssets
//
//  Created by mac on 2017/8/17.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupInfoMoel.h"

@protocol HomeTableViewCellTwoDidSelectItemDelegate <NSObject>

-  (void)homeTableViewCellTwoDidSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface HomeTableViewCellTwo : UITableViewCell<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)GroupInfoMoel *model;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, assign) id<HomeTableViewCellTwoDidSelectItemDelegate> homeTableViewCellTwoDidSelectItemDelegate;


@end
