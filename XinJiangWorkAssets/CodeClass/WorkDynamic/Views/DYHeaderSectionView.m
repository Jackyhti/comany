//
//  HeaderSectionView.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/4/8.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "DYHeaderSectionView.h"

@interface DYHeaderSectionView()

@property (weak, nonatomic) IBOutlet UILabel *conentLab;
@property (weak, nonatomic) IBOutlet UILabel *commitLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;


@end

@implementation DYHeaderSectionView

-(void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ac)];
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = YES;

}

-(void)ac{
    self.tapView(1);
}

-(void)setModel:(MyArrangeModel *)model{
    
    self.numLab.text = [NSString stringWithFormat:@" (%ld)",(long)self.sec+1];
    
    self.conentLab.text = [NSString stringWithFormat:@"%@",model.Arrange[@"Content"]];
    NSString *str;
    if ([model.Status isEqualToString:@"1"]) {
        str = @"[进行中]";
    }else if ([model.Status isEqualToString:@"2"]){
        str = @"[已完成]";
    }else if ([model.Status isEqualToString:@"3"]){
        str = @"[已取消]";
    }else if ([model.Status isEqualToString:@"4"]){
        str = @"[未完成]";
    }else if ([model.Status isEqualToString:@"5"]){
        str = @"[继续做]";
    }
    self.commitLab.text = str;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
