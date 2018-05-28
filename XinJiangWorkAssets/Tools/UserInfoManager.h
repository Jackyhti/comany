//
//  UserInfoManager.h
//  FrameTemplateDemo
//
//  Created by 成龙 on 17/1/10.
//  Copyright © 2017年 3L-LY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoManager : NSObject
//全局单例

+(UserInfoManager*)shareGlobalSettingInstance;



@property (nonatomic, assign)long  longNum;


/**
 *  保存用户信息
 *
 *  @param userInfo 用户信息
 */
-(void)setUserInfo:(NSDictionary *)userInfo;
/**
 *  获取用户信息
 *
 *  @return 用户信息
 */
-(NSDictionary *)getUserInfo;



/**
 *  保存用户信息
 *
 *  @param user 用户信息
 */
-(void)setUser:(NSDictionary *)user;
/**
 *  获取用户信息
 *
 *  @return 用户信息
 */
-(NSDictionary *)getUser;


//设置token值（修改密码需要用到）
-(void)setToken:(NSString *)token;


//获取登录成功的Token值
-(NSString*)getToken;


/**设置推送的token值*/
-(void)setDeviceToken:(NSString *)token;

/**获取推送的token值*/
-(NSString *)getDeviceToken;


//MD5加密
-(NSString*)md5SecureWithString:(NSString*)str;



/*获取定位信息X*/
-(void)setLocationStrX:(NSString *)locaX;


/*获取定位信息X*/
-(NSString*)getLocationStrX;



/*获取定位信息Y*/
-(void)setLocationStrY:(NSString *)locaY;

/*获取定位信息Y*/
-(NSString*)getLocationStrY;


/*!
 *  @brief 字典转Json字符串
 *
 *  @param object 字典
 *
 *  @return Json字符串
 */
-(NSString*)DataTOjsonString:(id)object;


//获得当前时间
- (NSString *)getTodayDate;


//传入今天的时间，返回明天的时间
- (NSString *)GetTomorrowDay:(NSDate *)aDate;

//获取当前日期
- (NSDictionary *)getCurrentDateWithDay:(long)day;

//获取字符串的宽度
-(float)widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height;

-(float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;

- (UIImage *)triangleImageWithSize:(CGSize)size tintColor:(UIColor *)tintColor;

@end
