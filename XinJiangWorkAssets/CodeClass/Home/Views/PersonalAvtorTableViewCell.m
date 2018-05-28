//
//  PersonalAvtorTableViewCell.m
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/7.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "PersonalAvtorTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation PersonalAvtorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTapAction:)];
    [self.avtorImgView addGestureRecognizer:tap];
    NSString *str = [[UserInfoManager shareGlobalSettingInstance] getUser][@"data"][@"ImgUrl"];
    NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    _avtorImgView.image = [UIImage imageWithData:[[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",KBASE_ImageURL,url]]]];
//    
    
      [_avtorImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",KBASE_ImageURL,url]] placeholderImage:[UIImage imageNamed:@"personZW"]];
    
    //修改头像
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadAfter) name:@"header" object:nil];

}

-(void)reloadAfter{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *str = [[UserInfoManager shareGlobalSettingInstance] getUser][@"data"][@"ImgUrl"];
        NSLog(@"%@",str);
        NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _avtorImgView.image = [UIImage imageWithData:[[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",KBASE_ImageURL,url]]]];
    });
}

- (void)imgTapAction:(UIImageView *)imgView {
    [_delegate avtorClickAction];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
