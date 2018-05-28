//
//  NotifDeaVC.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/3/29.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "BaseViewController.h"
#import "NoticeModel.h"
@interface NotifDeaVC : BaseViewController

@property(nonatomic,strong)NoticeModel *model;

@property(nonatomic,copy)void(^backReload)(NSString *a);

@end
