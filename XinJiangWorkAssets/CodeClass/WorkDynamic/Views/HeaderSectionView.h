//
//  HeaderSectionView.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/4/8.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyArrangeModel.h"

@interface HeaderSectionView : UIView
@property (weak, nonatomic) IBOutlet UIView *bcView;

@property (weak, nonatomic) IBOutlet UIView *bommonView;

@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *conLab;
@property (weak, nonatomic) IBOutlet UIView *leflt;
@property (weak, nonatomic) IBOutlet UIView *right;

@property(nonatomic,strong)MyArrangeModel *model;

@property(nonatomic,assign)NSInteger sec;

@property(nonatomic,copy)void(^tapView)(int a);

@end
