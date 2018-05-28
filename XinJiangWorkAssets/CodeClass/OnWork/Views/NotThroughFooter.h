//
//  NotThroughFooter.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/24.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotThroughFooter : UIView

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property(nonatomic,copy)void(^passAct)(UIButton *act);

@property(nonatomic,copy)void(^passTwoAct)(UIButton *act);


@end
