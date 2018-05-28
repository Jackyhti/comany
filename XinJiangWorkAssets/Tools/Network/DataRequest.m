//
//  DataRequest.m
//  mylweibo
//
//  Created by myl on 15-4-13.
//  Copyright (c) 2015年 zykj. All rights reserved.
//

#import "DataRequest.h"
#import "XMLReader.h"
#import "LReachability.h"
#import <AFNetworking/AFNetworking.h>

#define JIE_XI_TYPE         @"XML"

#define dis_to_url          @"https://www.baidu.com"

static DataRequest *dataRequest;
@implementation DataRequest

-(instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

+ (DataRequest *)shareDataRequest
{
    static DataRequest *dataRequest = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dataRequest = [[self alloc] init];
    });
    return dataRequest;
}


/*!
 *  @author 15-04-13 21:04:33
 *
 *  @brief  检测网络连接
 *
 *  @return 是否连接
 *
 *  @since 1.0
 */
+ (BOOL)checkNetwork
{
    LReachability *r = [LReachability reachabilityWithHostName:dis_to_url];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            return NO;
            break;
        case ReachableViaWWAN:
            return YES;
            break;
        case ReachableViaWiFi:
            return YES;
            break;
        default:
            return NO;
    }
}

-(AFHTTPSessionManager *)baseHtppRequest{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //增加这几行代码；
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    [securityPolicy setAllowInvalidCertificates:YES];
    
    //这里进行设置；
    [manager setSecurityPolicy:securityPolicy];
    
    [manager.requestSerializer setTimeoutInterval:TIMEOUT];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json",@"text/xml; charset=utf-8",@"application/x-www-form-urlencoded", nil];
    return manager;
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
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}


#pragma mark - POST方式网络访问(AFNetworking 3.0.4版本)
-(void)postResult:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlockData)successBlock failureBlock:(FailureBlockData)failureBlock{
    ModelRequestResult *requestResult = [ModelRequestResult shareDataRequest];
    
    NETLog(@"参数",@"%@",parameter);
    
    AFHTTPSessionManager *manager = [self baseHtppRequest];
    // 设置解析方式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];

    //两种编码方式
    //NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlStr = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NETLog(@"访问的URL",@"%@",urlStr);
//        NETLog(@"网络返回数据",@"%@",responseObject);

        requestResult.succ = YES;
        /*************************************************/
        @try {
            NSDictionary *resultDic = responseObject;
            if ([resultDic[@"code"] integerValue] == 1) {
                //内部成功SUCCESS
                requestResult.succWDJH = YES;
                requestResult.msgWDJH = resultDic[@"message"];
                requestResult.responseObject = resultDic;

//            }else if([resultDic[@"code"] integerValue] == -1){
//                //内部访问出现问题，请获得msg的值
//                requestResult.succWDJH = NO;
//                requestResult.errorCodeWDJH = [resultDic[@"code"] integerValue];
//                requestResult.msgWDJH = resultDic[@"message"];
//
//                requestResult.responseObject = resultDic;

            }else{
                //内部访问出现问题，请获得msg的值
                requestResult.succWDJH = NO;
               
                requestResult.errorCodeWDJH = [resultDic[@"code"] integerValue];
                requestResult.msgWDJH = [NSString stringWithFormat:@"%@",resultDic[@"message"]];
                [LToast showWithText:[NSString stringWithFormat:@"%@",requestResult.msgWDJH]];
                requestResult.responseObject = resultDic;
            }
            /*************************************************/
            
            //默认是JSON解析，responseObject 就是解析后的字典不需要自己再做解析
            NETLog(@"网络返回JSON数据：",@"%@",[self DataTOjsonString:responseObject]);

        } @catch (NSException *exception) {
            NETLog(@"核心网络访问出现问题：",@"%@", exception);

        } @finally {

        }

        //requestResult.responseObject = responseObject;
        successBlock(requestResult);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        requestResult.succ = NO;
        requestResult.errorMsg = errorStr;
        requestResult.errorCode = error.code;
        //[LToast showWithText:@"获取数据失败！"];
        NETLog(@"数据访问失败URL:",@"%@   %@", urlStr,error);
        failureBlock(requestResult);
    }];
}




-(void)uploadImageFileWithPrarms:(NSDictionary *)paramDic fileData:(NSData *)fileData uploadUrl:(NSString *)UrlStr successBlock:(SuccessBlockData)successBlock failureBlock:(FailureBlockData)failureBlock{
    ModelRequestResult *requestResult = [ModelRequestResult shareDataRequest];
    if ([DataRequest checkNetwork])
        {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", nil];
        [manager POST:UrlStr parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            
            [formData appendPartWithFileData:fileData
                                        name:@"imgname"          //服务器接收的key
                                    fileName:@"filedata.jpg"           //文件名称
                                    mimeType:@"multipart/form-data/jpg/jpeg"];     //文件类型(根据不同情况自行修改)
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"URL:%@ \n网络返回数据----:\n%@",UrlStr,[self DataTOjsonString:responseObject]);
            
            if ([[responseObject objectForKey:@"Code"] integerValue] == 1) {
                requestResult.succWDJH = YES;
            }else{
                requestResult.succWDJH = NO;
            }
            requestResult.succ = YES;
            requestResult.responseObject = responseObject;
            successBlock(requestResult);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            requestResult.succ = NO;
            requestResult.errorMsg = errorStr;
            requestResult.errorCode = error.code;
            
            NSLog(@"URL:%@ \n网络返回数据----:\n",UrlStr);
            failureBlock(requestResult);
        }];
        }else{
//            NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"error",@"RespResult",@"网络无法连接！",@"ContentResult", nil];
            requestResult.succ = NO;
            requestResult.errorMsg = @"网络无法连接~~！";
            requestResult.errorCode = -1;
            failureBlock(requestResult);
        }
}

-(void)uploadImageFileWithPrarms:(NSDictionary *)paramDic photosData:(NSArray *)photos uploadUrl:(NSString *)UrlStr successBlock:(SuccessBlockData)successBlock failureBlock:(FailureBlockData)failureBlock{
    ModelRequestResult *requestResult = [ModelRequestResult shareDataRequest];
    if ([DataRequest checkNetwork])
    {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", nil];
        [manager POST:UrlStr parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            for (int i = 0; i < photos.count; i++) {
                [formData appendPartWithFileData:[photos[i] mutableCopy] name:[NSString stringWithFormat:@"upload%d",i+1] fileName:[NSString stringWithFormat:@"imgname%d.jpg",i+1] mimeType:@"multipart/form-data/jpg/jpeg"];
            }
//            [formData appendPartWithFileData:fileData
//                                        name:@"imgname"          //服务器接收的key
//                                    fileName:@"filedata.jpg"           //文件名称
//                                    mimeType:@"multipart/form-data/jpg/jpeg"];     //文件类型(根据不同情况自行修改)
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"URL:%@ \n网络返回数据----:\n%@",UrlStr,responseObject);
            
            if ([[responseObject objectForKey:@"Code"] integerValue] == 1) {
                requestResult.succWDJH = YES;
            }else{
                requestResult.succWDJH = NO;
            }
            requestResult.succ = YES;
            requestResult.responseObject = responseObject;
            successBlock(requestResult);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            requestResult.succ = NO;
            requestResult.errorMsg = errorStr;
            requestResult.errorCode = error.code;
            
            NSLog(@"URL:%@ \n网络返回数据----:\n %@",UrlStr,errorStr);
            failureBlock(requestResult);
        }];
    }else{
        //            NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"error",@"RespResult",@"网络无法连接！",@"ContentResult", nil];
        requestResult.succ = NO;
        requestResult.errorMsg = @"网络无法连接~~！";
        requestResult.errorCode = -1;
        failureBlock(requestResult);
    }
}


@end
