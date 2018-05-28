//
//  TqHeader.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/5/25.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TqbgModel.h"
@interface TqHeader : UIView
@property (weak, nonatomic) IBOutlet UIView *bcConView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bcHeight;


@property(nonatomic,strong)TqbgModel *model;

@end
