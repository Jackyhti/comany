//
//  JudgeViewController.h
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/15.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyArrangeModel.h"
#import "JudgeView.h"
@interface JudgeViewController : UIViewController

- (void)showInView:(int)type;


@property(nonatomic,strong)MyArrangeModel *model;

@property (nonatomic, retain)JudgeView *judge;


@end
