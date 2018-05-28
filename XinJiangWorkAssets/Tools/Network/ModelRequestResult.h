//
//  ModelRequestResult.h
//
//
//  Created by 孙波 on 15/9/23.
//  Copyright (c) 2015年 com.hn3l. All rights reserved.
//

#define DIC_MODEL_REQUEST_RESULT @"DIC_MODEL_REQUEST_RESULT"

#import <Foundation/Foundation.h>

@interface ModelRequestResult : NSObject


+ (ModelRequestResult *)shareDataRequest;

/*********************网贷聚合专用***************************/
@property (nonatomic,assign) BOOL succWDJH;             //网贷聚合访问数据成功后返回结果
@property (nonatomic,assign) BOOL errorWDJH;            //网贷聚合访问数据失败后返回结果
@property (nonatomic,assign) NSInteger errorCodeWDJH;   //网贷聚合访问数据失败后返回的Code结果
@property (nonatomic,strong) NSString *msgWDJH;         //网贷聚合访问数据成功和失败后返回的msg结果
/*********************网贷聚合专用***************************/

@property (nonatomic,assign) BOOL succ;                 //整体访问成功与否(系统基础级别)
@property (nonatomic,assign) NSInteger errorCode;       // 只有在_succ为NO的时候有用
@property (nonatomic,retain) NSString * errorMsg;       // 只有在_succ为NO的时候有用
@property (nonatomic,assign) NSInteger unsucc;          //整体访问成功与否(系统基础级别)

@property (nonatomic, strong) NSData *responseData;
@property (nonatomic, strong) NSString *responseString;
@property (nonatomic, strong) id responseObject;

@end
