//
//  ReplyYBVC.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/3/12.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "BaseViewController.h"
#import "HeaderModel.h"
@interface ReplyYBVC : BaseViewController

@property(nonatomic,strong) HeaderModel *model;

@property(nonatomic,copy)void(^backReolad)(int a);

@end
