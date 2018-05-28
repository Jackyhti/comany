//
//  JudgeView.m
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/15.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "JudgeView.h"
#import "TabButton.h"
#import "UITextView+Placeholder.h"


@interface JudgeView()

@property(nonatomic,strong)UIScrollView *mainScrollView;

@end

#define leftSpace 15
#define BtnWdith 65
@implementation JudgeView
{
    CGRect _frame;
    
    //关闭按钮
    
    TabButton   *_cancleButton;
    
    //工作
    UITextView *_myTextView;
    //评价
    UITextView *_judgeTextView;
    //点赞
    TabButton   *_priceButton;
    
    UILabel *juLab;
    
//    UILabel *zjStr;
    
    UIView *zjView;
    
    //追加btn
    UIButton *_zjBtn;
    
    UILabel *_zjLab;
    
    UITextView *_zjTextView;
    
    UIButton    *_priceActionButton;
    
    UIView *_xian;
    
    UILabel *_plLab;
    
    UITextView *_pltextTF;
    
    NSDictionary *_allDic;
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

-(void)sendModel:(MyArrangeModel*)model Type:(int)type{

    self.model = model;

    _myTextView.text = model.Arrange[@"Content"];
    _myTextView.userInteractionEnabled = NO;
    
    _judgeTextView.text = model.Result[@"Content"];
    _judgeTextView.textColor = [UIColor darkGrayColor];


    if ([model.Status isEqualToString:@"1"]) {
        TabButton *tBu = [self viewWithTag:701];
        tBu.selected = YES;
    }else if ([model.Status isEqualToString:@"2"]){
        TabButton *tBu = [self viewWithTag:702];
        tBu.selected = YES;
    }
    else if ([model.Status isEqualToString:@"3"]){
        TabButton *tBu = [self viewWithTag:703];
        tBu.selected = YES;
    }
    else if ([model.Status isEqualToString:@"4"]){
        TabButton *tBu = [self viewWithTag:704];
        tBu.selected = YES;
    }
    else if ([model.Status isEqualToString:@"5"]){
        TabButton *tBu = [self viewWithTag:705];
        tBu.selected = YES;
    }
    
    if (self.model.Memo.count>0) {
        for (int i = 0; i<self.model.Memo.count; i++) {
            UILabel *zjLab = [[UILabel alloc]init];
            
            zjLab.font = [UIFont systemFontOfSize:16.0];
            
            zjLab.textColor = [UIColor darkGrayColor];
            zjLab.tag = 10000+i;
            zjLab.text = [NSString stringWithFormat:@"%d:%@",i+1,self.model.Memo[i][@"Content"]];
            zjLab.numberOfLines = 0;


            if (i==0) {
                zjLab.frame = CGRectMake(juLab.frame.origin.x+juLab.frame.size.width+7, _judgeTextView.origin.y+_judgeTextView.size.height+8, _frame.size.width-juLab.frame.origin.x-juLab.frame.size.width-5-20, zjLab.size.height+5);
            }else{
               UILabel *topLab = [self viewWithTag:i+10000-1];
                zjLab.frame = CGRectMake(juLab.frame.origin.x+juLab.frame.size.width+7,
                                         topLab.origin.y+topLab.size.height+5, _frame.size.width-juLab.frame.origin.x-juLab.frame.size.width-5-20, zjLab.size.height);
            }
            [zjLab sizeToFit];

//            NSLog(@"%f",zjLab.size.height);

            [self.mainScrollView addSubview:zjLab];
    
            if (i == self.model.Memo.count - 1) {
                zjView = [[UIView alloc]init];
                UILabel *topLab = [self viewWithTag:self.model.Memo.count+10000-1];
                
                zjView.frame = CGRectMake(juLab.frame.origin.x+juLab.frame.size.width+5, _judgeTextView.origin.y+_judgeTextView.size.height+5,_frame.size.width-juLab.frame.origin.x-juLab.frame.size.width-5-20, topLab.origin.y + topLab.size.height-_judgeTextView.origin.y-_judgeTextView.size.height-5+10);
                
                zjView.layer.borderWidth = 1.0;
                zjView.layer.borderColor = [UIColor lightGrayColor].CGColor;
                zjView.layer.cornerRadius = 5;
                zjView.layer.masksToBounds = YES;
                
                
                UILabel *bzLab = [[UILabel alloc]initWithFrame:CGRectMake(leftSpace, _judgeTextView.origin.y+_judgeTextView.size.height+3, 40, 30)];
                
                bzLab.text = @"备注:";
                bzLab.font = [UIFont systemFontOfSize:15.0];
                bzLab.textColor = [UIColor darkGrayColor];
                
                [self.mainScrollView addSubview:bzLab];
                [self.mainScrollView addSubview: zjView];
                
                
                _zjBtn.frame = CGRectMake(self.size.width-leftSpace-80, zjView.origin.y+zjView.size.height+3, 80, 30);
                
                _zjLab = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, zjView.origin.y+zjView.size.height+3, 40, 30)];
                
                
                _zjTextView.frame = CGRectMake(_zjLab.origin.x+_zjLab.size.width+5, zjView.origin.y+zjView.size.height + 3,_frame.size.width-juLab.frame.origin.x-juLab.frame.size.width-5-20,60);
                
                _priceActionButton.frame = CGRectMake(self.size.width/2-40, zjView.frame.origin.y+zjView.size.height+40, 80, 35);
                
                
                

            }
                    }
    }else{
        
        
    }
    //别人的框
    if (type == 0) {
        _judgeTextView.userInteractionEnabled = NO;

        for(int i = 701;i <= 705;i++) {
            TabButton *tBu = [self viewWithTag:i];
                tBu.userInteractionEnabled = NO;
            
        }
        _mainScrollView.frame = CGRectMake(0, 0, self.width, self.height);

        _zjBtn.hidden = YES;
        
        if (self.model.Memo.count>0) {
            //评论lab
            _plLab = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, zjView.frame.origin.y+zjView.frame.size.height+10, 40, 30)];
        }else{
            _plLab = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, _judgeTextView.frame.origin.y+_judgeTextView.frame.size.height+10, 40, 30)];
        }
        _plLab.text = @"评论:";
        _plLab.font = [UIFont systemFontOfSize:15.0];
        _plLab.textColor = [UIColor darkGrayColor];
        [_mainScrollView addSubview:_plLab];
        
        //评论
        _pltextTF = [[UITextView alloc] initWithFrame:CGRectMake(_plLab.frame.origin.x+_plLab.frame.size.width+5,_plLab.frame.origin.y, _frame.size.width-_plLab.frame.origin.x-_plLab.frame.size.width-5-20,80)];
        _pltextTF.text =  @"";
        _pltextTF.placeholder = @"请输入评论";
        _pltextTF.font = [UIFont systemFontOfSize:16.0];
        _pltextTF.layer.borderWidth = 1.0;
        _pltextTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _pltextTF.layer.cornerRadius = 5;
        _pltextTF.layer.masksToBounds = YES;
        _pltextTF.delegate = self;
        _pltextTF.textColor = [UIColor darkGrayColor];
        [_mainScrollView addSubview:_pltextTF];
        
        
        //赞
        _priceButton = [[TabButton alloc]initWithFrame:CGRectMake(leftSpace, _pltextTF.frame.origin.y+_pltextTF.frame.size.height+25, 50, 25) title:@"赞" imageStr:@"zan_grey" imgFrame:CGRectMake(25, 0, 25, 25) titleFrame:CGRectMake(0, 8, 20, 10)];
        //    _priceButton.backgroundColor = [UIColor yellowColor];
        _priceButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [_priceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_priceButton setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
        [_priceButton setImage:[UIImage imageNamed:@"zan_click"] forState:UIControlStateSelected];
        [_priceButton addTarget:self action:@selector(zanAction:) forControlEvents:UIControlEventTouchUpInside];
        [_mainScrollView addSubview:_priceButton];

        _priceActionButton.frame = CGRectMake(self.size.width/2-40, _pltextTF.frame.origin.y+_pltextTF.size.height+20, 80, 35);

        }
    
    
    self.mainScrollView.contentSize = CGSizeMake(self.width, _priceActionButton.origin.y+_priceActionButton.frame.size.height+10);
    
    
}

- (void)setup {
    _mainScrollView = [[UIScrollView alloc]init];
    _mainScrollView.frame = CGRectMake(0, 0, self.width, self.height);
    [self addSubview:_mainScrollView];
    //关闭按钮
    _cancleButton = [[TabButton alloc]initWithFrame:CGRectMake(_frame.size.width-100, 0, 100, 45) title:nil imageStr:@"close" imgFrame:CGRectMake(100-25-10, 10, 25, 25) titleFrame:CGRectZero];
//    _cancleButton.backgroundColor = [UIColor yellowColor];
    [_cancleButton addTarget:self action:@selector(cancleButton:) forControlEvents:UIControlEventTouchUpInside];
    [_mainScrollView addSubview:_cancleButton];
    
    //工作
    UILabel *workLab = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, _cancleButton.frame.origin.y+_cancleButton.frame.size.height+3, 40, 30)];
    workLab.text = @"工作:";
    workLab.font = [UIFont systemFontOfSize:15.0];
    workLab.textColor = [UIColor darkGrayColor];
//    workLab.backgroundColor = [UIColor redColor];
    [_mainScrollView addSubview:workLab];
    
    _myTextView = [[UITextView alloc] initWithFrame:CGRectMake(workLab.frame.origin.x+workLab.frame.size.width+5,workLab.frame.origin.y, _frame.size.width-workLab.frame.origin.x-workLab.frame.size.width-5-20,80)];
    _myTextView.text =  @"";
    _myTextView.placeholder = @"请输入您的工作安排";
    _myTextView.font = [UIFont systemFontOfSize:16.0];
    _myTextView.layer.borderWidth = 1.0;
    _myTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _myTextView.layer.cornerRadius = 5;
    _myTextView.layer.masksToBounds = YES;
    _myTextView.delegate = self;
    _myTextView.textColor = [UIColor darkGrayColor];
    [_mainScrollView addSubview:_myTextView];
    
    
    //状态
    UILabel *statusLab = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, _myTextView.frame.origin.y+_myTextView.frame.size.height+10, 40, 30)];
    statusLab.text = @"状态:";
    statusLab.font = [UIFont systemFontOfSize:15.0];
    statusLab.textColor = [UIColor darkGrayColor];
    [_mainScrollView addSubview:statusLab];
    
    CGFloat wid = _myTextView.frame.origin.x;
    CGFloat h = statusLab.frame.origin.y;
    NSArray *titles = @[@"进行中",@"已完成",@"已取消",@"未完成",@"继续做"];
    for(int i = 0;i < titles.count;i++) {
        
        TabButton *zan = [[TabButton alloc]initWithFrame:CGRectMake(wid,h, BtnWdith, 25) title:titles[i] imageStr:@"Radio_pick" imgFrame:CGRectMake(0, 5, 18, 18) titleFrame:CGRectMake(18, 4, 50, 20)];
        //        zan.backgroundColor = [UIColor blueColor];
        zan.tag = 701+i;
        zan.selected = NO;
        [zan setImage:[UIImage imageNamed:@"Radio_pick"] forState:UIControlStateNormal];
        [zan setImage:[UIImage imageNamed:@"Radio_pick_click"] forState:UIControlStateSelected];
        [zan setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
        [zan addTarget:self action:@selector(zanTabAction:) forControlEvents:UIControlEventTouchUpInside];
        if(zan.frame.origin.x+BtnWdith > (_frame.size.width)){
            wid = _myTextView.frame.origin.x;
            h = zan.frame.origin.y+zan.frame.size.height+8;
            zan.frame = CGRectMake(wid,h, BtnWdith, 25);
        }
        
        wid += BtnWdith + 10;
        
        zan.titleLabel.font = [UIFont systemFontOfSize:15];
        
//        zan.backgroundColor = [UIColor redColor];
        [_mainScrollView addSubview:zan];
    }
    
    //小结
    juLab = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace,h+40, 40, 30)];
    juLab.text = @"小结:";
    juLab.font = [UIFont systemFontOfSize:15.0];
    juLab.textColor = [UIColor darkGrayColor];
    [_mainScrollView addSubview:juLab];
    
    _judgeTextView = [[UITextView alloc] initWithFrame:CGRectMake(juLab.frame.origin.x+juLab.frame.size.width+5,juLab.frame.origin.y, _frame.size.width-juLab.frame.origin.x-juLab.frame.size.width-5-20,80)];
    _judgeTextView.text =  @"";
    _judgeTextView.placeholder = @"请填写评价信息";
    _judgeTextView.font = [UIFont systemFontOfSize:16.0];
    _judgeTextView.layer.borderWidth = 1.0;
    _judgeTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _judgeTextView.layer.cornerRadius = 5;
    _judgeTextView.layer.masksToBounds = YES;
    _judgeTextView.delegate = self;
    [_mainScrollView addSubview:_judgeTextView];
    
   
    
    //追加btn
    _zjBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _zjBtn = [[UIButton alloc]init];
    _zjBtn.frame = CGRectMake(self.size.width-leftSpace-80, _judgeTextView.origin.y+_judgeTextView.size.height+3, 80, 30);
    
    [_zjBtn setTitle:@"备注+" forState:UIControlStateNormal];
    
    [_zjBtn setTitleColor:[UIColor blackColor] forState:0];

    [_zjBtn addTarget:self action:@selector(zjAC:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainScrollView addSubview:_zjBtn];
    
    //追加
    _zjLab = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, _judgeTextView.origin.y+_judgeTextView.size.height+3, 40, 30)];
    _zjLab.text = @"追加:";
    _zjLab.font = [UIFont systemFontOfSize:15.0];
    _zjLab.textColor = [UIColor darkGrayColor];
    //    workLab.backgroundColor = [UIColor redColor];
    
    _zjTextView = [[UITextView alloc]init] ;
    _zjTextView.frame = CGRectMake(_zjLab.origin.x+_zjLab.size.width+5, _judgeTextView.origin.y+_judgeTextView.size.height + 3,_frame.size.width-juLab.frame.origin.x-juLab.frame.size.width-5-20,60);
    _zjTextView.placeholder = @"请填写追加信息";
    _zjTextView.font = [UIFont systemFontOfSize:16.0];
    _zjTextView.layer.borderWidth = 1.0;
    _zjTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _zjTextView.layer.cornerRadius = 5;
    _zjTextView.layer.masksToBounds = YES;
    
    
    _priceActionButton = [[UIButton alloc]init];
    _priceActionButton.frame = CGRectMake(self.size.width/2-40, _judgeTextView.frame.origin.y+_judgeTextView.size.height+40, 80, 35);
    _priceActionButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [_priceActionButton setTitle:@"保存" forState:UIControlStateNormal];
    [_priceActionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_priceActionButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    _priceActionButton.layer.cornerRadius = 3;
    _priceActionButton.layer.masksToBounds = YES;
    _priceActionButton.backgroundColor = kHomeColor;
    [_priceActionButton addTarget:self action:@selector(saveButton:) forControlEvents:UIControlEventTouchUpInside];
    [_mainScrollView addSubview:_priceActionButton];
    
    self.mainScrollView.contentSize = CGSizeMake(self.width, _priceActionButton.origin.y+_priceActionButton.frame.size.height);
}

-(void)zjAC:(UIButton*)btn{
    
    [UIView animateWithDuration:0.5 animations:^{
    
        if (self.model.Memo.count>0) {
            
            _zjTextView.frame = CGRectMake(_zjLab.origin.x+_zjLab.size.width+5, zjView.origin.y+zjView.size.height + 3,_frame.size.width-juLab.frame.origin.x-juLab.frame.size.width-5-20,60);
        }else{
        _zjTextView.frame = CGRectMake(_zjLab.origin.x+_zjLab.size.width+5, _judgeTextView.origin.y+_judgeTextView.size.height + 3,_frame.size.width-juLab.frame.origin.x-juLab.frame.size.width-5-20,60);
        }
        
        _zjBtn.frame = CGRectMake(self.size.width-leftSpace-80, _zjTextView.origin.y+_zjTextView.size.height+3, 80, 30);
        
        _zjBtn.userInteractionEnabled = NO;
        
        [_zjBtn setTitleColor:[UIColor grayColor] forState:0];
        
        [_mainScrollView addSubview:_zjLab];
        
        [_mainScrollView addSubview:_zjTextView];
        
       
//        [self.mainScrollView setContentOffset:CGPointMake(0,_myTextView.origin.y) animated:YES];
    }];
    _priceActionButton.frame =CGRectMake(self.size.width/2-_priceActionButton.size.width/2, _zjTextView.frame.origin.y+_zjTextView.size.height+10, 80, 35);
    
    self.mainScrollView.contentSize = CGSizeMake(self.width, _priceActionButton.origin.y+_priceActionButton.frame.size.height+10);
}




- (void)saveButton:(UIButton *)bu {
    
    _allDic = [NSDictionary dictionary];

    NSString *zanStr ;
    if(_priceButton.selected) {
        zanStr = @"1";
    }else {
        zanStr = @"0";
    }
    
    
    NSString *statusStr;
    for(int i = 701;i <= 705;i++) {
        TabButton *tBu = [self viewWithTag:i];
        if(tBu.selected == YES) {
            statusStr = [NSString stringWithFormat:@"%ld",tBu.tag-700];
        }
    }
    
    NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];

    NSString *jg;
    if (_pltextTF == nil) {
        jg = @"";
    }else{
        jg = _pltextTF.text;
    }
    _allDic = @{
                @"ArrangeID":self.model.ArrangeID,//安排ID
                @"LeaderID":[NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]],  //人的ID
                @"Status":statusStr,  //进行的状态
                @"Result":_judgeTextView.text, //小结内容
                
                @"MemoID":@"0",  //备注ID
            
                
                @"MemoContent":_zjTextView.text, //备注内容
               
                @"JudgeID":@"0",  //评论ID
                @"JudgeLeaderID":[NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]],  //评论人ID
                @"JudgeContent":jg, //评论内容
                @"JudgeIsZan":zanStr, // 0/1  1点了 ，0没点
                @"WhoLook":@"0",
                //工作内容不传因为不能修改
                };
    
//    NSDictionary *saveDic = @{@"ArrangeID":_arrange.myID,@"Content":_contentArray,@"Status":statusStr};
//    NSString *saveStr = [[GlobalSetting shareGlobalSettingInstance] DataTOjsonString:saveDic];
    if(self.judgeButtonClickedBlock) {
        self.judgeButtonClickedBlock(_allDic);
    }
   
    
}

/*!
 *  @brief 字典转Json字符串
 *
 *  @param object 字典
 *
 *  @return Json字符串
 */
-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                        // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSASCIIStringEncoding];
        jsonString = [NSString stringWithFormat:@"%@",SUNBStringEncodeString(jsonString)];
    }
    return jsonString;
}

- (void)zanAction:(UIButton *)bu {
    bu.selected = !bu.selected;
}



- (void)zanTabAction:(TabButton *)bu {
    bu.selected = !bu.selected;
    
    for(int i = 701;i <= 705;i++) {
        TabButton *tBu = [self viewWithTag:i];
        if(i != bu.tag) {
            tBu.selected = NO;
        }
    }
}


//关闭按钮
- (void)cancleButton:(UIButton *)btn {
    self.cancleButtonClickedBlock(self);
}

@end
