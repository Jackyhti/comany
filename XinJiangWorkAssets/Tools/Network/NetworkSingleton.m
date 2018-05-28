//
//  NetworkSingleton.m
//  
//
//  Created by 孙波 on 15/6/17.
//  Copyright (c) 2016年 孙波. All rights reserved.
//

#import "NetworkSingleton.h"

@implementation NetworkSingleton

+(NetworkSingleton *)sharedManager{
    static NetworkSingleton *sharedNetworkSingleton = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        sharedNetworkSingleton = [[self alloc] init];
    });
    return sharedNetworkSingleton;
}

#pragma mark - 通用方法（网贷聚合数据请求公用）
-(void)postDataToResult:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlockData)successBlock failureBlock:(FailureBlockData)failureBlock
{
    NSString *contentUrl = [NSString stringWithFormat:@"%@/%@",KBASE_URL,url];

    NSMutableDictionary *parmDic = [NSMutableDictionary dictionaryWithDictionary:parameter];
//    [parmDic setObject:[NSString stringWithFormat:@"%d",[SUNBDateToShiJianChuoMiao intValue]] forKey:@"timestamp"];

//    NSLog(@"dic1:%@",parmDic);
//
//    for (NSString *str in [parmDic allKeys]) {
//        NSLog(@"key == %@",str);
//    }
//
//    NSArray *keys = [parmDic allKeys];
//    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
//        return [obj1 compare:obj2 options:NSNumericSearch];
//    }];
//
//    for (NSString *categoryId in sortedArray) {
//        NSLog(@"[dict objectForKey:categoryId] === %@",[parmDic objectForKey:categoryId]);
//        
//    }
//
//    NSLog(@"dic2:%@",parmDic);


//
//    NSString *jiaMiStr = [NSString stringWithFormat:@"%@%@",SUNBStringEncodeDictWithSort(parmDic),KTongYong_MIMA];
//    //转义成Url-去除等号，%号
//    jiaMiStr = SUNBStringEncodeString([jiaMiStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
//    [parmDic setObject:SUNBStringToSha1(jiaMiStr) forKey:@"sign"];




    [[DataRequest shareDataRequest] postResult:parmDic url:contentUrl successBlock:^(ModelRequestResult *responseBody) {
        successBlock(responseBody);
    } failureBlock:^(ModelRequestResult *error) {
        failureBlock(error);
    }];
}

#pragma mark - 上传图片

-(void)uploadPic:(NSDictionary *)parameter url:(NSString *)Url fileData:(NSData *)fileData successBlock:(SuccessBlockData)successBlock faileureBlock:(FailureBlockData)failureBlock{
    NSString *contentUrl = [NSString stringWithFormat:@"%@/%@",KBASE_URL,Url];
    
    [[DataRequest shareDataRequest] uploadImageFileWithPrarms:parameter fileData:fileData uploadUrl:contentUrl successBlock:^(ModelRequestResult *responseBody) {
        successBlock(responseBody);
    } failureBlock:^(ModelRequestResult *error) {
        failureBlock(error);
    }];

}

//上传多个照片
-(void)uploadPic:(NSDictionary *)parameter url:(NSString *)Url photosData:(NSArray *)PhotosData successBlock:(SuccessBlockData)successBlock faileureBlock:(FailureBlockData)failureBlock{
    NSString *contentUrl = [NSString stringWithFormat:@"%@/%@",KBASE_URL,Url];

 [[DataRequest shareDataRequest] uploadImageFileWithPrarms:parameter photosData:PhotosData uploadUrl:contentUrl successBlock:^(ModelRequestResult *responseBody) {
     successBlock(responseBody);

 } failureBlock:^(ModelRequestResult *error) {
     failureBlock(error);

 }];
    
    
}


//-(void)uploadPic:(NSDictionary *)parameter fileData:(NSData *)fileData successBlock:(SuccessBlockData)successBlock faileureBlock:(FailureBlockData)failureBlock{
//    NSString *contentUrl = [NSString stringWithFormat:@"%@/AddHeadImg.ashx",KBASE_URL];
//
//    [[DataRequest shareDataRequest] uploadImageFileWithPrarms:parameter fileData:fileData uploadUrl:contentUrl successBlock:^(ModelRequestResult *responseBody) {
//        successBlock(responseBody);
//    } failureBlock:^(ModelRequestResult *error) {
//        failureBlock(error);
//    }];
//}


#pragma mark - 左上角切换县区（切换县区）
-(void)getLeftChangeCityResult:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlockData)successBlock failureBlock:(FailureBlockData)failureBlock
{
    NSString *contentUrl = [NSString stringWithFormat:@"%@/%@",KBASE_URL,url];
    [[DataRequest shareDataRequest] postResult:parameter url:contentUrl successBlock:^(ModelRequestResult *responseBody) {
        successBlock(responseBody);
    } failureBlock:^(ModelRequestResult *error) {
        failureBlock(error);
    }];

}

#pragma mark - 推荐（猜你喜欢）
-(void)getRecommendResult:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlockData)successBlock failureBlock:(FailureBlockData)failureBlock{
    
    NSString *contentUrl = [NSString stringWithFormat:@"%@/%@",KBASE_URL,url];
    [[DataRequest shareDataRequest] postResult:parameter url:contentUrl successBlock:^(ModelRequestResult *responseBody) {
        successBlock(responseBody);
    } failureBlock:^(ModelRequestResult *error) {
        failureBlock(error);
    }];
    
}
@end
