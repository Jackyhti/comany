//
//  photoModel.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/5.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface photoModel : NSObject
//图片ID
@property (nonatomic, readwrite, copy) NSString * imgID;
//院部ID
@property (nonatomic, readwrite, copy) NSString * YBID;
//图片路劲
@property (nonatomic, readwrite, copy) NSString * path;
//图片地址
@property (nonatomic, readwrite, copy) NSString * ImgUrl;
//缩略图地址
@property (nonatomic, readwrite, copy) NSString * middle;

@property (nonatomic, readwrite, copy) NSString * small;


@end
