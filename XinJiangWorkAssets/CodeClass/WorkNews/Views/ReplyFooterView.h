//
//  ReplyFooterView.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/3/15.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReplyFooterView : UIView
@property (weak, nonatomic) IBOutlet UITextView *replyTextView;
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;

@property (weak, nonatomic) IBOutlet UILabel *tishiLab;

@property(nonatomic,copy)void(^passValue)(NSString *btn);

@end
