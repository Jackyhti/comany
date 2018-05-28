//
//  JudgeView.h
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/15.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyArrangeModel.h"
@interface JudgeView : UIView<UITextViewDelegate>

@property(nonatomic,strong)MyArrangeModel *model;

@property (nonatomic, copy) void (^cancleButtonClickedBlock)(UIView *arrView);
@property (nonatomic, copy) void (^judgeButtonClickedBlock)(NSDictionary *dic);

-(void)sendModel:(MyArrangeModel*)model Type:(int)type;

@end
