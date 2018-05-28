//
//  OfficeHeaderView.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/3/1.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "OfficeHeaderView.h"

@interface OfficeHeaderView()
{
    NSString *_dateStr;
}

@property (weak, nonatomic) IBOutlet UILabel *onWorkLab;
@property (weak, nonatomic) IBOutlet UILabel *qingJiaLab;
@property (weak, nonatomic) IBOutlet UILabel *chuchaiLab;
@property (weak, nonatomic) IBOutlet UILabel *kaihuiLab;


@property (weak, nonatomic) IBOutlet UILabel *typeLab1;

@property (weak, nonatomic) IBOutlet UILabel *typeLab2;
@property (weak, nonatomic) IBOutlet UILabel *typeLab3;
@property (weak, nonatomic) IBOutlet UILabel *typeLab4;
@property (weak, nonatomic) IBOutlet UILabel *typeLab5;

@property (weak, nonatomic) IBOutlet UILabel *typeLab6;


@end


@implementation OfficeHeaderView
{
    CGFloat  _width;
    
    long      _day;
    long      _yesDay;
    long      _tomDay;
    
    long     _isLeft;
    long     _isRight;
}



-(void)awakeFromNib{
    [super awakeFromNib ];
    _day = 1;
    _yesDay = 0;
    _tomDay = 0;
    _isLeft = 0;
    _isRight = 0;
    
    _width = Kscreen_width;
    [self setup];
}


-(void)setDic:(NSDictionary *)dic{
    NSDictionary *dics = dic[@"list"][0];
    NSArray *arr1 = dics[@"strlist0"];
    NSArray *arr2 = dics[@"strlist1"];
    NSArray *arr3 = dics[@"strlist2"];
    NSArray *arr4 = dics[@"strlist3"];
    NSArray *arr5 = dics[@"strlist4"];
    NSArray *arr6 = dics[@"strlist5"];
    NSString *nameArr1 = @"";
    for (int i = 0; i<arr1.count; i++) {
        NSDictionary *nameDic = arr1[i];
       nameArr1 = [nameArr1 stringByAppendingString:[NSString stringWithFormat:@",%@",nameDic[@"LeaderName"]]];
    }
    if (arr1.count>0) {
        nameArr1 = [nameArr1 substringFromIndex:1];
    }

    _typeLab1.text = [NSString stringWithFormat:@"%@",nameArr1];
    
    NSString *nameArr2 = @"" ;
    for (int i = 0; i<arr2.count; i++) {
        NSDictionary *nameDic = arr2[i];
  nameArr2 = [nameArr2 stringByAppendingString:[NSString stringWithFormat:@",%@",nameDic[@"LeaderName"]]];    }
    if (arr2.count>0) {
    nameArr2 = [nameArr2 substringFromIndex:1];
    }
    _typeLab2.text = [NSString stringWithFormat:@"%@",nameArr2];
    NSString *nameArr3 = @"";
    for (int i = 0; i<arr3.count; i++) {
        NSDictionary *nameDic = arr3[i];
  nameArr3 = [nameArr3 stringByAppendingString:[NSString stringWithFormat:@",%@",nameDic[@"LeaderName"]]];    }
    if (arr3.count>0) {

    nameArr3 = [nameArr3 substringFromIndex:1];
    }
    _typeLab3.text = [NSString stringWithFormat:@"%@",nameArr3];
    NSString *nameArr4 = @"";
    for (int i = 0; i<arr4.count; i++) {
        NSDictionary *nameDic = arr4[i];
  nameArr4 = [nameArr4 stringByAppendingString:[NSString stringWithFormat:@",%@",nameDic[@"LeaderName"]]];    }
    if (arr4.count>0) {

    nameArr4 = [nameArr4 substringFromIndex:1];
    }
    _typeLab4.text = [NSString stringWithFormat:@"%@",nameArr4];
    NSString *nameArr5 = @"";
    for (int i = 0; i<arr5.count; i++) {
        NSDictionary *nameDic = arr5[i];
  nameArr5 = [nameArr5 stringByAppendingString:[NSString stringWithFormat:@",%@",nameDic[@"LeaderName"]]];    }
    if (arr5.count>0) {

    nameArr5 = [nameArr5 substringFromIndex:1];
    }
    _typeLab5.text = [NSString stringWithFormat:@"%@",nameArr5];
   
    NSString *nameArr6 = @"";
    for (int i = 0; i<arr6.count; i++) {
        NSDictionary *nameDic = arr6[i];
  nameArr6 = [nameArr6 stringByAppendingString:[NSString stringWithFormat:@",%@",nameDic[@"LeaderName"]]];    }
    if (arr6.count>0) {

    nameArr6 = [nameArr6 substringFromIndex:1];
    }else{

    }
    _typeLab6.text = [NSString stringWithFormat:@"%@",nameArr6];
    
    
    if ([_typeLab2.text isEqualToString:@""]) {
        _typeLab2.text = @"无";
    }
    
    if ([_typeLab3.text isEqualToString:@""]) {
        _typeLab3.text = @"无";
    }
    
    if ([_typeLab4.text isEqualToString:@""]) {
        _typeLab4.text = @"无";
    }
    
    if ([_typeLab5.text isEqualToString:@""]) {
        _typeLab5.text = @"无";
    }
    
    if ([_typeLab1.text isEqualToString:@""]) {
        _typeLab1.text = @"无";
    }
    
    if ([_typeLab6.text isEqualToString:@""]) {
        _typeLab6.text = @"无";
    }
    
}

- (void)setup {
    
    
    _dateStr = [[UserInfoManager shareGlobalSettingInstance]getCurrentDateWithDay:1][@"now"];
    
    _timeLab.text = [[NSString stringWithFormat:@"%@ 今天",[self getCurrentDateWithDay:1 current:_dateStr][@"now"]] substringFromIndex:5];
    
}


- (IBAction)beforeAction:(UIButton *)sender {
    _yesDay++;
    
    _day = _yesDay-_tomDay;
    
    NSString *str = [self getCurrentDateWithDay:_day current:_dateStr][@"yes"];
    [self blockValue:str date:_dateStr];

}
- (IBAction)nextAction:(UIButton *)sender {
    _tomDay++;
    
    _day = _tomDay-_yesDay;
    
    
    NSString *str = [self getCurrentDateWithDay:_day current:_dateStr][@"tommorrow"];
    [self blockValue:str date:_dateStr];

}

- (void)blockValue:(NSString *)str  date:(NSString *)dateStr{
    _timeLab.text = [str substringFromIndex:5];
    _timeLab.text = [self returnDateWithStr:_timeLab.text date:_dateStr];
    
    [self setLabel];
    
    if(self.networkBlock) {
        self.networkBlock(str);
    }
}

- (void)setLabel {
    NSString *str = [self getCurrentDateWithDay:0 current:_dateStr][@"now"];
    if([_timeLab.text isEqualToString:[str substringFromIndex:5]]) {
        _timeLab.text = [_timeLab.text stringByAppendingString:@"今天"];
    }
    
    NSString *yesStr = [[UserInfoManager shareGlobalSettingInstance] getCurrentDateWithDay:1][@"yes"];
    if([_timeLab.text isEqualToString:[[yesStr substringFromIndex:5] stringByReplacingOccurrencesOfString:@"/" withString:@"-"]]) {
        _timeLab.text = [_timeLab.text stringByAppendingString:@"昨天"];
    }
    
    
    NSString *tommorrowStr = [[UserInfoManager shareGlobalSettingInstance] getCurrentDateWithDay:1][@"tommorrow"];
    if([_timeLab.text isEqualToString:[[tommorrowStr substringFromIndex:5] stringByReplacingOccurrencesOfString:@"/" withString:@"-"]]) {
        _timeLab.text = [_timeLab.text stringByAppendingString:@"明天"];
    }
}



- (NSString *)returnDateWithStr:(NSString *)str date:(NSString *)dateStr {
    NSString *now = [[UserInfoManager shareGlobalSettingInstance] getCurrentDateWithDay:1][@"now"] ;
    NSString *yes = [[UserInfoManager shareGlobalSettingInstance] getCurrentDateWithDay:1][@"yes"] ;
    NSString *tom = [[UserInfoManager shareGlobalSettingInstance] getCurrentDateWithDay:1][@"tommorrow"] ;
    
    
    if([str isEqualToString:[now substringFromIndex:5]]) {
        return [str stringByAppendingString:@"今天"];
    }else if([str isEqualToString:[yes substringFromIndex:5]]) {
        return [str stringByAppendingString:@"昨天"];
        
    }else if([str isEqualToString:[tom substringFromIndex:5]]){
        return [str stringByAppendingString:@"明天"];
        
    }else {
        return str;
    }
}



//获取当前日期
- (NSDictionary *)getCurrentDateWithDay:(long)day current:(NSString *)currentStr{
    
    NSDateFormatter *strFor = [[NSDateFormatter alloc]init];
    [strFor setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [strFor dateFromString:currentStr];
    
    NSDate *yesDate = [NSDate dateWithTimeInterval:-(day * (24*60*60)) sinceDate:date];
    //    NSDate *yesDate = [NSDate dateWithTimeIntervalSinceNow:-(day * (24*60*60))];
    //    NSDate *tommorrowDate = [NSDate dateWithTimeIntervalSinceNow:+(day * (24*60*60))];
    
    NSDate *tommorrowDate = [NSDate dateWithTimeInterval:+(day * (24*60*60)) sinceDate:date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *now = [formatter stringFromDate:date];
    NSString *yes = [formatter stringFromDate:yesDate];
    NSString *tommorrow = [formatter stringFromDate:tommorrowDate];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:yes,@"yes",now,@"now",tommorrow,@"tommorrow", nil];
    return dic;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
