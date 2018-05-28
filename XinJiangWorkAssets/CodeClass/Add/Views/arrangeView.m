//
//  arrangeView.m
//  NetWorkNoteBook
//
//  Created by zhenzhen on 16/7/5.
//  Copyright © 2016年 csip. All rights reserved.
//

#import "arrangeView.h"
#import "UIView+SDAutoLayout.h"
#import "TabButton.h"
#import "UITextView+Placeholder.h"

#define FRAMEWIDTH   Kscreen_width-40
#define FRAMEHEIGHT  Kscreen_height-220



@interface arrangeView()<UITextViewDelegate>

@end


@implementation arrangeView
{
    CGRect _frame;
    NSInteger  _num;
    NSInteger _lookNum;
    
    UILabel    *_addView;
    
    //关闭按钮

    TabButton   *_cancleButton;
    
    TabButton   *_yesButt;
    //    UILabel    *_yesLab;
    TabButton   *_tomButt;
    //    UILabel    *_tomLab;
    
    UIImageView     *_backView;
    UIImageView   *_imgView;
    UILabel      *_nowLab;
    
    UITextView  *_myTextView;
    
    UIButton    *_commitButton;
    
    //所有人  四大班子
    TabButton *_allBtn;
    TabButton *_fourBtn;
    
}
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        _frame = frame;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self setup];
    }
    return self;
}

- (void)setup {
    _num = 0;
    _addView = [[UILabel alloc] initWithFrame:CGRectMake(_frame.size.width/2-50, 20, 100, 30)];
    _addView.text = @"添加安排";
    _addView.textColor = [UIColor blackColor];
    _addView.textAlignment = NSTextAlignmentCenter;
    _addView.font = [UIFont systemFontOfSize:19.0];
//    _addView.backgroundColor = [UIColor yellowColor];
    [self addSubview:_addView];
    
    _cancleButton = [[TabButton alloc]initWithFrame:CGRectMake(_frame.size.width-100, 0, 100, 55) title:nil imageStr:@"close" imgFrame:CGRectMake(100-25-10, 10, 25, 25) titleFrame:CGRectZero];
//    _cancleButton.backgroundColor = [UIColor yellowColor];
    [_cancleButton addTarget:self action:@selector(cancleButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancleButton];
    

    CGFloat originY = 0;
    if(iPhone5) {
        originY = 140;
    }else {
        originY = 160;
    }
    
    
    _backView = [[UIImageView alloc] initWithFrame:CGRectMake(_frame.size.width/2-originY/2, _addView.frame.origin.y+_addView.frame.size.height+15, originY, 30)];
    _backView.backgroundColor = kHomeColor;
    _backView.image = [UIImage imageNamed:@"button"];
    _backView.layer.cornerRadius = 3;
    _backView.layer.masksToBounds = YES;
    [self addSubview:_backView];
    
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(_backView.frame.size.width/2-90/2-3-15-5,7, 15, 15)];
    _imgView.image = [UIImage imageNamed:@"date_white"];
    [_backView addSubview:_imgView];
    
   
    _nowLab = [[UILabel alloc] initWithFrame:CGRectMake(_backView.frame.size.width/2-90/2-5, 0, 120, _backView.frame.size.height)];
    NSString *str = [NSString stringWithFormat:@"%@ %@",[self getCurrentDate][@"now"],NOWDay];
    _nowLab.text = str;
//    _nowLab.backgroundColor = [UIColor redColor];
    _nowLab.textAlignment = NSTextAlignmentCenter;
//    _nowLab.text = [str substringFromIndex:5];
    _nowLab.textColor = [UIColor whiteColor];
    [_backView addSubview:_nowLab];
    if(iPhone5) {
        _nowLab.font = [UIFont systemFontOfSize:13.0];
    }else {
        _nowLab.font = [UIFont systemFontOfSize:14.0];
    }
    
    CGFloat tabSpace = 15;
    if(iPhone5) {
        tabSpace = 6;
    }
    
    
    _yesButt = [[TabButton alloc]initWithFrame:CGRectMake(_backView.frame.origin.x-60-tabSpace, 65, 60, 30) title:YESDay imageStr:@"arrow_left_blue" imgFrame:CGRectMake(0, 5, 20, 20) titleFrame:CGRectMake(22, 5, 35, 20)];
    _yesButt.tag = 100;
    //    _yesButt.backgroundColor = [UIColor yellowColor];
    _yesButt.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_yesButt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_yesButt setImage:[UIImage imageNamed:@"arrow_left_blue"] forState:UIControlStateNormal];
    [_yesButt setImage:[UIImage imageNamed:@"arrow_left_blue"] forState:UIControlStateSelected];
    
    [_yesButt addTarget:self action:@selector(buttAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_yesButt];
    //    _yesButt.backgroundColor = [UIColor orangeColor];
    
    
    
    _tomButt = [[TabButton alloc]initWithFrame:CGRectMake(_backView.frame.origin.x+_backView.frame.size.width+tabSpace, 65, 60, 20) title:TOMMORROW imageStr:@"arrow_right_blue" imgFrame:CGRectMake(35, 5, 20, 20) titleFrame:CGRectMake(0, 5, 35, 20)];
    _tomButt.tag = 102;
    _tomButt.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_tomButt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_tomButt setImage:[UIImage imageNamed:@"arrow_right_blue"] forState:UIControlStateNormal];
    [_tomButt setImage:[UIImage imageNamed:@"arrow_right_blue"] forState:UIControlStateSelected];
    
    [_tomButt addTarget:self action:@selector(buttAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_tomButt];
    //    _tomButt.backgroundColor = [UIColor orangeColor];
    
    
    
    
    _myTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, _yesButt.frame.origin.y+_yesButt.frame.size.height+20, _frame.size.width-40,100)];
    _myTextView.text =  @"";
    _myTextView.placeholder = @"请输入您的工作安排";
    _myTextView.font = [UIFont systemFontOfSize:16.0];
    _myTextView.layer.borderWidth = 1.0;
    _myTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _myTextView.layer.cornerRadius = 5;
    _myTextView.layer.masksToBounds = YES;
    _myTextView.delegate = self;
    [self addSubview:_myTextView];
    
    
    
    CGFloat widY = [[UserInfoManager shareGlobalSettingInstance] widthForString:@"一般" fontSize:16 andHeight:30];
    CGFloat widY2 = [[UserInfoManager shareGlobalSettingInstance] widthForString:@"非常重要" fontSize:16 andHeight:30];
    CGFloat spa = Kscreen_width-100-widY*2-widY2;
    
    
    CGFloat imgWAH = 18;
    
    TabButton *y1 = [[TabButton alloc]initWithFrame:CGRectMake(20,_myTextView.frame.origin.y+_myTextView.frame.size.height+10, widY+30, 30) title:@"一般" imageStr:@"Radio_pick"  imgFrame:CGRectMake(4, 6, imgWAH, imgWAH) titleFrame:CGRectMake(13, 0, widY+25, 30)];
    y1.tag = 103;
    y1.selected = NO;
    //    y1.backgroundColor = [UIColor yellowColor];
    y1.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [y1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [y1 addTarget:self action:@selector(buttAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:y1];
    //y1.frame.origin.x+spa/5+y1.frame.size.width
    TabButton *y2 = [[TabButton alloc]initWithFrame:CGRectMake((Kscreen_width-40-widY-30)/2-5, y1.frame.origin.y, widY+30, 30) title:@"重要" imageStr:@"Radio_pick"  imgFrame:CGRectMake(4, 6, imgWAH, imgWAH) titleFrame:CGRectMake(13, 0, widY+25, 30)];
    y2.tag = 104;
    y2.selected = NO;
    y2.titleLabel.font = [UIFont systemFontOfSize:15.0];
    
    [y2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [y2 addTarget:self action:@selector(buttAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:y2];
    //y2.frame.origin.x+spa/5+y2.frame.size.width
    TabButton *y3 = [[TabButton alloc]initWithFrame:CGRectMake(Kscreen_width-40-widY2-30-10, y1.frame.origin.y, widY2+30, 30) title:@"非常重要" imageStr:@"Radio_pick"  imgFrame:CGRectMake(4, 6, imgWAH, imgWAH) titleFrame:CGRectMake(13, 0, widY2+25, 30)];
    y3.tag = 105;
    y3.selected = NO;
    y3.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [y3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [y3 addTarget:self action:@selector(buttAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:y3];
    
    //lab
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(y1.frame.origin.x, y1.frame.origin.y+y1.frame.size.height+10,100, 20)];
    lab.text = @"谁可以看";
    lab.font = [UIFont systemFontOfSize:15.0];
    lab.textColor = [UIColor blackColor];
    //    lab.backgroundColor = [UIColor yellowColor];
    [self addSubview:lab];
    
    //看的人
    _allBtn = [[TabButton alloc]initWithFrame:CGRectMake(y1.frame.origin.x,lab.frame.origin.y+lab.frame.size.height+5, 80, 30) title:@"所有人" imageStr:@"Radio_pick"  imgFrame:CGRectMake(4, 6, imgWAH, imgWAH) titleFrame:CGRectMake(25, 0,50, 30)];
    _allBtn.tag = 110;
    _allBtn.selected = NO;
    _allBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [_allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_allBtn addTarget:self action:@selector(watchAction:) forControlEvents:UIControlEventTouchUpInside];
    //    _allBtn.backgroundColor = [UIColor cyanColor];
    [self addSubview:_allBtn];
    
    
    _fourBtn = [[TabButton alloc]initWithFrame:CGRectMake(_allBtn.frame.origin.x + _allBtn.frame.size.width+20,_allBtn.frame.origin.y, 130, 30) title:@"四大班子领导" imageStr:@"Radio_pick"  imgFrame:CGRectMake(4, 6, imgWAH, imgWAH) titleFrame:CGRectMake(25, 0,100, 30)];
    _fourBtn.tag = 111;
    _fourBtn.selected = NO;
    _fourBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [_fourBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_fourBtn addTarget:self action:@selector(watchAction:) forControlEvents:UIControlEventTouchUpInside];
    //    _fourBtn.backgroundColor = [UIColor cyanColor];
    [self addSubview:_fourBtn];
    
    
    
    
    _commitButton = [[UIButton alloc] initWithFrame:CGRectMake(_frame.size.width/2-(FRAMEWIDTH-120)/2, _frame.size.height-15-35, FRAMEWIDTH-120, 35)];
    [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
 //   [_commitButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    _commitButton.layer.cornerRadius = 3;
    _commitButton.layer.masksToBounds = YES;
    _commitButton.backgroundColor = kHomeColor;
    [_commitButton addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_commitButton];

}



//提交按钮
- (void)commitAction:(UIButton *)commit {
    
    NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];

    NSDictionary *dataDic = [userDic objectForKey:@"data"];
    NSDictionary *dic = @{};
    
    if(_myTextView.text.length !=0 && _num != 0&& _lookNum != 3) {
        
        NSString *timeStr = @"";
        
        if([_nowLab.text containsString:YESDay]) {
            timeStr = [self getCurrentDate][@"yes"];
        }
        if([_nowLab.text containsString:NOWDay]) {
            timeStr = [self getCurrentDate][@"now"];
            
            
        } if([_nowLab.text containsString:TOMMORROW]) {
            timeStr = [self getCurrentDate][@"tommorrow"];
        }
        
        dic = @{@"LeaderID":dataDic[@"LeaderID"],@"ArrangeTime":timeStr,@"ArrangeContent":[NSString stringWithFormat:@"%@",_myTextView.text],@"Weight":[NSString stringWithFormat:@"%@",@(_num)],@"WhoLook":[NSString stringWithFormat:@"%@",@(_lookNum)]};
        NSLog(@"%@",dic);

        if (self.commitButtonClickedBlock) {
            self.commitButtonClickedBlock(dic);
        }
        
        //103,104,105
        for(TabButton *tab in self.subviews) {
            if(tab.tag == 103) {
                tab.selected = NO;
            }
            if(tab.tag == 104) {
                tab.selected = NO;
            }if(tab.tag == 105) {
                tab.selected = NO;
            }
        }
        _myTextView.text = @"";
        
        _num = 0;
        
        _lookNum = 3;
        
    }else {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请把信息填写完整" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alertView show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        });
    }
}


- (void)watchAction:(TabButton *)btn {
    if(btn.tag == _allBtn.tag) {
        _allBtn.selected = YES;
        _fourBtn.selected = NO;
    }
    if(btn.tag == _fourBtn.tag) {
        _fourBtn.selected = YES;
        _allBtn.selected = NO;
    }
    
    if (_allBtn.selected == YES) {
        _lookNum = 0;
    }
    
    if (_fourBtn.selected == YES) {
        _lookNum = 1;
    }
    [btn setImage:[UIImage imageNamed:@"Radio_pick_click"] forState:UIControlStateSelected];

}

- (void)buttAction:(UIButton *)butt {
    
    UIButton *b3 = [butt.superview viewWithTag:101];
    if(butt.tag == 100) {
        if([_nowLab.text containsString:NOWDay]) {
            NSString *str = [NSString stringWithFormat:@"%@ %@",[self getCurrentDate][@"yes"],YESDay];
            _nowLab.text = str;
            _yesButt.selected = YES;
            _tomButt.selected = NO;
        }
        if([_nowLab.text containsString:TOMMORROW]) {
            _yesButt.selected = NO;
            _tomButt.selected = NO;
            NSString *str = [NSString stringWithFormat:@"%@ %@",[self getCurrentDate][@"now"],NOWDay];
            _nowLab.text = str;
            
        }
    }else if(butt.tag == 102) {
        if([_nowLab.text containsString:NOWDay]) {
            
            NSString *str = [NSString stringWithFormat:@"%@ %@",[self getCurrentDate][@"tommorrow"],TOMMORROW];
            _nowLab.text = str;
            _tomButt.selected = YES;
            
            
        }
        if([_nowLab.text containsString:YESDay]) {
            _tomButt.selected = NO;
            _yesButt.selected = NO;
            NSString *str = [NSString stringWithFormat:@"%@ %@",[self getCurrentDate][@"now"],NOWDay];
            _nowLab.text = str;
            
        }
        
    }else if(butt.tag == 103) {
        butt.selected = !butt.selected;
        
        if(butt.selected) {
            TabButton *b4 = [butt.superview viewWithTag:104];
            TabButton *b5 = [butt.superview viewWithTag:105];
            b4.selected = NO;
            b5.selected = NO;
            [butt setImage:[UIImage imageNamed:@"Radio_pick_click"] forState:UIControlStateSelected];
            _num = 1;
        }else {
            _num = 0;
        }
    }else if(butt.tag == 104) {
        butt.selected = !butt.selected;
        
        if(butt.selected) {
            TabButton *b3 = [butt.superview viewWithTag:103];
            TabButton *b5 = [butt.superview viewWithTag:105];
            b3.selected = NO;
            b5.selected = NO;
            [butt setImage:[UIImage imageNamed:@"Radio_pick_click"] forState:UIControlStateSelected];
            _num = 2;
        }else {
            _num = 0;
        }
    }else if(butt.tag == 105) {
        butt.selected = !butt.selected;
        
        TabButton *b4 = [butt.superview viewWithTag:104];
        TabButton *b3 = [butt.superview viewWithTag:103];
        b4.selected = NO;
        b3.selected = NO;
        
        if(butt.selected) {
            _num = 3;
            [butt setImage:[UIImage imageNamed:@"Radio_pick_click"] forState:UIControlStateSelected];
        }else {
            _num = 0;
        }
    }
}



//关闭按钮
- (void)cancleButton:(UIButton *)btn {
    self.cancleButtonClickedBlock(self);
}

#pragma mark -UITextView Delegate Method



-(BOOL)textView:(UITextView *)textView shouldChangetTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


//获取当前日期
- (NSDictionary *)getCurrentDate {
    NSDate *date = [NSDate date];
    NSDate *yesDate = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
    NSDate *tommorrowDate = [NSDate dateWithTimeIntervalSinceNow:+(24*60*60)];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *now = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    NSString *yes = [NSString stringWithFormat:@"%@",[formatter stringFromDate:yesDate]];
    NSString *tommorrow = [NSString stringWithFormat:@"%@",[formatter stringFromDate:tommorrowDate]];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:yes,@"yes",now,@"now",tommorrow,@"tommorrow", nil];
    return dic;
}


@end
