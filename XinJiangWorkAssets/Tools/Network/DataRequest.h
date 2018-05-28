//
//  DataRequest.h
//  mylweibo
//
//  Created by myl on 15-4-13.
//  Copyright (c) 2015年 zykj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelRequestResult.h"

//请求超时
#define TIMEOUT 30

typedef void(^SuccessBlockData)(ModelRequestResult *responseBody);
typedef void(^FailureBlockData)(ModelRequestResult *error);

@interface DataRequest : NSObject

+ (DataRequest *)shareDataRequest;

/*!
 *  @author 15-04-13 21:04:33
 *
 *  @brief  检测网络连接
 *
 *  @return 是否连接
 *
 *  @since 1.0
 */
+ (BOOL)checkNetwork;



/**
 post网络访问

 @param parameter 参数
 @param url url
 @param successBlock successBlock description
 @param failureBlock failureBlock description
 */
-(void)postResult:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlockData)successBlock failureBlock:(FailureBlockData)failureBlock;




/**
 图片上传

 @param paramDic 参数
 @param fileData 文件内容
 @param UrlStr 地址
 @param successBlock successBlock description
 @param failureBlock failureBlock description
 */
-(void)uploadImageFileWithPrarms:(NSDictionary *)paramDic fileData:(NSData *)fileData uploadUrl:(NSString *)UrlStr successBlock:(SuccessBlockData)successBlock failureBlock:(FailureBlockData)failureBlock;


//传多个图片
-(void)uploadImageFileWithPrarms:(NSDictionary *)paramDic photosData:(NSArray *)photos uploadUrl:(NSString *)UrlStr successBlock:(SuccessBlockData)successBlock failureBlock:(FailureBlockData)failureBlock;


@end
