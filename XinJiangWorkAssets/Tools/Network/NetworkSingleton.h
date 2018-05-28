//
//  NetworkSingleton.h
//  车主
//
//  Created by 孙波 on 15/6/17.
//  Copyright (c) 2016年 孙波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "DataRequest.h"


@interface NetworkSingleton : NSObject

+(NetworkSingleton *)sharedManager;

#pragma mark - 通用方法（商家）
-(void)postDataToResult:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlockData)successBlock failureBlock:(FailureBlockData)failureBlock;

#pragma mark - 上传图片

-(void)uploadPic:(NSDictionary *)parameter url:(NSString *)Url fileData:(NSData *)fileData successBlock:(SuccessBlockData)successBlock faileureBlock:(FailureBlockData)failureBlock;

//上传多个照片
-(void)uploadPic:(NSDictionary *)parameter url:(NSString *)Url photosData:(NSArray *)PhotosData successBlock:(SuccessBlockData)successBlock faileureBlock:(FailureBlockData)failureBlock;


#pragma mark - 左上角切换县区（切换县区）
-(void)getLeftChangeCityResult:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlockData)successBlock failureBlock:(FailureBlockData)failureBlock;



@end
