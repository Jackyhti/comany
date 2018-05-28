//
//  HeaderSectionView.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/4/8.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyArrangeModel.h"

@interface DYHeaderSectionView : UIView

@property(nonatomic,strong)MyArrangeModel *model;

@property(nonatomic,assign)NSInteger sec;

@property(nonatomic,copy)void(^tapView)(int a);

@end
