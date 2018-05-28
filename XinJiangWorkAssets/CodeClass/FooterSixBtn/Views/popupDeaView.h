//
//  popupDeaView.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/5/16.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface popupDeaView : UIView

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property(nonatomic,copy)void(^close)(void);

@end
