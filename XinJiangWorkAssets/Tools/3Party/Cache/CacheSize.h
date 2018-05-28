//
//  CacheSize.h
//  PersonalCenter
//
//  Created by csip on 15/6/2.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheSize : NSObject
@property(nonatomic,copy)void(^onResult)(NSString*);
+ (instancetype)defaultCalculateFileSize;

/**
 *	@brief	计算单个文件大小
 *
 *	@param 	path 	文件位置
 *
 *	@return	文件大小
 */
- (float)fileSizeAtPath:(NSString*)path;

/**
 *	@brief	计算文件夹大小
 *
 *	@param 	path 	文件夹位置
 *
 *	@return 文件夹大小
 */
- (float)folderSizeAtPath:(NSString*)path;

/**
 *	@brief	清除缓存
 *
 *	@param 	path 	文件/文件夹位置
 */
- (void)clearCache:(NSArray *)paths clearBlock:(void(^)(NSString*))a;
@end
