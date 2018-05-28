//
//  HomeFooterView.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/4/23.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "HomeFooterView.h"

@interface HomeFooterView()
@property (weak, nonatomic) IBOutlet UIView *backGorundView;
@property (weak, nonatomic) IBOutlet UIView *ldtsView;
@property (weak, nonatomic) IBOutlet UIView *tqbgView;
@property (weak, nonatomic) IBOutlet UIView *pxzxView;
@property (weak, nonatomic) IBOutlet UIView *hyzxView;
@property (weak, nonatomic) IBOutlet UIView *yqdtView;
@property (weak, nonatomic) IBOutlet UIView *zcfgView;

@end

@implementation HomeFooterView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backGorundView.layer.cornerRadius = 10;
    self.backGorundView.layer.masksToBounds = YES;
    self.backGorundView.layer.borderWidth = 1.0;
    self.backGorundView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self addTap];
}


-(void)addTap{
    _ldtsView.tag = 2000;
    _tqbgView.tag = 2001;
    _pxzxView.tag = 2002;
    _hyzxView.tag = 2003;
    _yqdtView.tag = 2004;
    _zcfgView.tag = 2005;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];

    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    
    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    
    [_ldtsView addGestureRecognizer:tap1];
    
    [_tqbgView addGestureRecognizer:tap2];
    
    [_pxzxView addGestureRecognizer:tap3];
    
    [_hyzxView addGestureRecognizer:tap4];
    
    [_yqdtView addGestureRecognizer:tap5];
    
    [_zcfgView addGestureRecognizer:tap6];
}

-(void)tapView:(UITapGestureRecognizer*)tap{
    self.sendBtn((int)tap.view.tag);

}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
