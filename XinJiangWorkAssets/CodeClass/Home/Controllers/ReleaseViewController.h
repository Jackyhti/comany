//
//  ReleaseViewController.h
//  XinJiangWorkAssets
//
//  Created by mac on 2017/8/22.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "XWPublishBaseController.h"
#import "LPlaceHolderTextView.h"

@interface ReleaseViewController : XWPublishBaseController

//背景
@property(nonatomic,strong) UIView *noteTextBackgroudView;

//备注
@property(nonatomic,strong) LPlaceHolderTextView *noteTextView;

//文字个数提示label
@property(nonatomic,strong) UILabel *textNumberLabel;

//文字说明
@property(nonatomic,strong) UILabel *explainLabel;

//发布按钮
@property(nonatomic,strong) UIButton *submitBtn;

-(void)upxian;


@end
