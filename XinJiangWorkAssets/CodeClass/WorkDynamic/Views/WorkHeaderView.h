//
//  WorkHeaderView.h
//  NetWorkNoteBook
//
//  Created by zhenzhen on 16/7/11.
//  Copyright © 2016年 csip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkHeaderView : UIView


@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (nonatomic, copy) void (^phoneBlock)(NSString *phoneStr);
@property (nonatomic, copy) void (^networkBlock)(NSString *date);

@property(nonatomic,copy)void(^change)(NSString *btn);

@property (nonatomic, retain)NSDictionary *headerDic;


@end
