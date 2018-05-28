//
//  PersonalAvtorTableViewCell.h
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/7.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PersonalAvtorTableViewCellDelegate <NSObject>

-(void)avtorClickAction;

@end


@interface PersonalAvtorTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *avtorImgView;

@property (nonatomic, assign)id<PersonalAvtorTableViewCellDelegate>delegate;


@end
