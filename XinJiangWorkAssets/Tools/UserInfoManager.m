//
//  UserInfoManager.m
//  FrameTemplateDemo
//
//  Created by 成龙 on 17/1/10.
//  Copyright © 2017年 3L-LY. All rights reserved.
//

#import "UserInfoManager.h"
#import <CommonCrypto/CommonCrypto.h>

static UserInfoManager *globalSetting;
static NSDictionary *myDic;


@implementation UserInfoManager

+(UserInfoManager*)shareGlobalSettingInstance{
    if (!globalSetting) {
        globalSetting = [[self alloc]init];
    }
    return globalSetting;
}

-(NSString*)getToken{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[userDefaults valueForKey:@"token"]length] == 0) {
        return @"";
    }
    return [userDefaults valueForKey:@"token"];
}

-(void)setToken:(NSString *)token
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:token forKey:@"token"];
    [userDefaults synchronize];
}

-(void)setUserInfo:(NSDictionary *)userInfo{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userInfo forKey:@"userInfo"];
    [userDefaults synchronize];
    
}

-(void)setUser:(NSDictionary *)user{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:user forKey:@"user"];
    [userDefaults synchronize];
    
}


-(NSDictionary *)getUserInfo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults objectForKey:@"userInfo"];
    if (dic.count == 0) {
        return @{};
    }
    return dic;
}

-(NSDictionary *)getUser{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults objectForKey:@"user"];
    if (dic.count == 0) {
        return @{};
    }
    return dic;
}




-(void)setDeviceToken:(NSString *)token
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:token forKey:kPushToken];
    [userDefaults synchronize];
}


-(NSString *)getDeviceToken {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[userDefaults valueForKey:kPushToken]length] == 0) {
        return @"";
    }
    return [userDefaults valueForKey:kPushToken];
}

/*获取定位信息X*/
-(void)setLocationStrX:(NSString *)locaX{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:locaX forKey:@"LocationX"];
    [userDefaults synchronize];
}

/*获取定位信息Y*/
-(void)setLocationStrY:(NSString *)locaY{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:locaY forKey:@"LocationY"];
    [userDefaults synchronize];
}

/*获取定位信息X*/
-(NSString*)getLocationStrX{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[userDefaults valueForKey:@"LocationX"]length] == 0) {
        return @"";
    }
    return [userDefaults valueForKey:@"LocationX"];
}

/*获取定位信息Y*/
-(NSString*)getLocationStrY{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[userDefaults valueForKey:@"LocationY"]length] == 0) {
        return @"";
    }
    return [userDefaults valueForKey:@"LocationY"];
}


+(void)saveUserInfo:(NSDictionary *)userInfo withPath:path{
    
    //准备工作：文件路径+文件名(xx/Documents/archive)
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:path];
    //    NSArray *array = @[@"Bob", @19, @[@"Objective-C", @"Swift"]];
    NSDictionary *myDictionary = userInfo;
    //1.归档：写入数据
    //1.1 准备一个可变的数据类型
    NSMutableData *mutableData = [NSMutableData data];
    NSLog(@"开始准备的数据长度:%lu", (unsigned long)mutableData.length);
    //1.2 创建NSKeyedArchiver对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableData];
    //1.3 对写入的数据进行编码
    [archiver encodeObject:myDictionary forKey:@"firstStu"];
    //1.4 完成编码
    [archiver finishEncoding];
    NSLog(@"编码后的数据长度:%lu", (unsigned long)mutableData.length);
    //1.5 写入文件中
    [mutableData writeToFile:filePath atomically:YES];
    
}
+ (NSDictionary *)unarchivewithPath:path{
    //2.解档：读取数据
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:path];
    //2.1 从指定的文件读取归档的数据
    NSData *readData = [NSData dataWithContentsOfFile:filePath];
    //2.2 创建NSKeyedUnarchiver对象
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:readData];
    //2.3 解码对象
    NSDictionary *dic = [unarchiver decodeObjectForKey:@"firstStu"];
    //2.4 完成解码
    [unarchiver finishDecoding];
    //验证数据
    //    NSLog(@"读取的数据：%@", self.dic);
    return dic;
}

- (NSString *)getTodayDate {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init]; //初始化格式器。
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *currentTime = [dateformatter stringFromDate:[NSDate date]];
    return currentTime;
}

//传入今天的时间，返回明天的时间
- (NSString *)GetTomorrowDay:(NSDate *)aDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"YYYY-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}


#pragma mark - MAD5加密
-(NSString *)md5SecureWithString:(NSString*)str {
    //将oc的字符串转为c语言字符串
    const char *CStr = str.UTF8String;
    //使用CC_MD5函数进行加密:MD5函数声明的密文由16个16进制的字符组成
    /*
     参数1⃣️：要加密的c语言字符串
     参数2⃣️：C语言字符串的长度
     参数3⃣️：生成的16个16进制字符的数组的首地址
     */
    //声明一个字符数组 可存放16个字符
    unsigned char result [CC_MD5_DIGEST_LENGTH];
    //计算MD5值
    CC_MD5(CStr, (CC_LONG)strlen(CStr), result);
    //遍历c语言字符数组  将其中的16个字符拼接起来,形成oc的字符串
    NSMutableString *string =[NSMutableString string];
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [string appendFormat:@"%02X",result[i]];
    }
    NSLog(@"md5加密后%@",string);
    NSLog(@"长度:%lu",(unsigned long)string.length);
    return  [string lowercaseString];
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


//获取当前日期
- (NSDictionary *)getCurrentDateWithDay:(long)day {
    NSDate *date = [NSDate date];
    NSDate *yesDate = [NSDate dateWithTimeIntervalSinceNow:-(day * (24*60*60))];
    NSDate *tommorrowDate = [NSDate dateWithTimeIntervalSinceNow:+(day * (24*60*60))];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY/MM/dd"];
    NSString *now = [formatter stringFromDate:date];
    NSString *yes = [formatter stringFromDate:yesDate];
    NSString *tommorrow = [formatter stringFromDate:tommorrowDate];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:yes,@"yes",now,@"now",tommorrow,@"tommorrow", nil];
    
    return dic;
}



//获取字符串的宽度
-(float)widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height
{
    UIColor  *backgroundColor=[UIColor blackColor];
    UIFont *font=[UIFont boldSystemFontOfSize:fontSize];
    CGRect sizeToFit = [value boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                              NSForegroundColorAttributeName:backgroundColor,
                                                                                                                                              NSFontAttributeName:font
                                                                                                                                              } context:nil];
    
    return sizeToFit.size.width;
}



//获得字符串的高度
-(float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    UIColor  *backgroundColor=[UIColor blackColor];
    UIFont *font=[UIFont boldSystemFontOfSize:fontSize];
    CGRect sizeToFit = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                             NSForegroundColorAttributeName:backgroundColor,
                                                                                                                                             NSFontAttributeName:font
                                                                                                                                             } context:nil];
    return sizeToFit.size.height;
}

//倒三角
- (UIImage *)triangleImageWithSize:(CGSize)size tintColor:(UIColor *)tintColor{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(size.width/2,size.height)];
    [path addLineToPoint:CGPointMake(size.width, 0)];
    [path closePath];
    CGContextSetFillColorWithColor(ctx, tintColor.CGColor);
    [path fill];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}



@end
