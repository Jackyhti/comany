//
//  OfficeVC.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/3/2.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "BaseViewController.h"

@interface OfficeVC : BaseViewController

@property(nonatomic,strong)LeftMenuView *leftView;

//侧边栏
@property (nonatomic ,strong)MenuView *menu;

@property(nonatomic,strong)NSString *groupID;

@end
