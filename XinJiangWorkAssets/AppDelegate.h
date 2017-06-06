//
//  AppDelegate.h
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/6.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

