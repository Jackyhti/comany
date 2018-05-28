//
//  BaseTabBarViewController.m
//
//
//  Created by csip on 16/4/20.
//  Copyright © 2016年 sun. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "AddViewController.h"
#import "HomeViewController.h"
#import "DynamicViewController.h"
#import "OnWorkViewController.h"
#import "NewsViewController.h"
#import "LBTabBar.h"
#import "CustomPopOverView.h"
#import "AppDelegate.h"


static NSString *const kHomeVC = @"HomeViewController";
static NSString *const kDynamicVC = @"DynamicViewController";
static NSString *const kOnWorkVC  = @"OnWorkViewController";
static NSString *const kNewsVC   = @"NewsViewController";

@interface BaseTabBarViewController ()<LBTabBarDelegate>

@property (nonatomic, retain)AddViewController *add;


@property (nonatomic, retain)CustomPopOverView *popView;



@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewControllers];
    //[self setCustomBackBarButtonItem];
    
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    LBTabBar *tabbar = [[LBTabBar alloc] init];
    tabbar.myDelegate = self;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];
    
    
}

/**
 *  设置返回按键样式
 */
- (void)addCustomBackBarButtonItem2Controller:(UIViewController *)controller
{
    
}

/**
 *  返回键事件
 *
 *  @param sender sender
 */
-(void)LeftItemAction:(UIButton *)sender
{
    
}

/**
 *  添加子控制器
 */
- (void)addChildViewControllers
{
    [self addChildViewControllerWithControllerName:kHomeVC barItemImageName:@"toolbar_sy" title:@"首页"];
    [self addChildViewControllerWithControllerName:kDynamicVC barItemImageName:@"toolbar_gzdt" title:@"工作动态"];
    [self addChildViewControllerWithControllerName:kOnWorkVC barItemImageName:@"toolbar_zgtz" title:@"在岗调整"];
    [self addChildViewControllerWithControllerName:kNewsVC barItemImageName:@"toolbar_ybdt" title:@"院部动态"];
}


/**
 *  添加子控制器内容
 *
 *  @param viewControllerName 控制器名称
 *  @param imageName          图片名称
 *  @param title              标题
 */

- (void)addChildViewControllerWithControllerName:(NSString *)viewControllerName barItemImageName:(NSString *)imageName title:(NSString *)title
{
    BaseViewController *vc = [[NSClassFromString(viewControllerName) alloc] init];
    vc.title = title;
    vc.isHiddenBackBtn = YES;
    vc.tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_click",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    
//    [textAttrs setObject:RGB(80, 80, 80) forKey:NSForegroundColorAttributeName];
    [textAttrs setObject:[UIColor colorWithHexString:@"#777777"] forKey:NSForegroundColorAttributeName];
    [selectedTextAttrs setObject:kHomeColor forKey:NSForegroundColorAttributeName];
    
    [vc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    BaseNavigationContrller *nvc = [[BaseNavigationContrller alloc] initWithRootViewController:vc];
    [nvc.navigationBar setTintColor:[UIColor whiteColor]];
//    [nvc.navigationBar setBarTintColor:K_Main_Theme_Color];
    [nvc.navigationBar setBackgroundImage:[UIImage imageWithColor:kHomeColor] forBarMetrics:UIBarMetricsDefault];
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName: [UIFont boldSystemFontOfSize:kNavTitleFontSize],
                                     NSForegroundColorAttributeName: [UIColor whiteColor],
                                     };
    [nvc.navigationBar setTitleTextAttributes:textAttributes];
    [self addChildViewController:nvc];
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if(self.popView) {
        [self popViewDismiss];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ItemTag" object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@(item.tag),@"Item" ,nil]];
}

- (void)tabBarPlusBtnClick:(LBTabBar *)tabBar {
    
    if(!self.add) {
        AddViewController *add = [[AddViewController alloc]init];
        add.view.frame = CGRectMake(0, 0,Kscreen_width,Kscreen_height);
        self.add = add;
        [add showInView];
        self.add = nil;
    }else {
        [UIView animateWithDuration:0.5 animations:^{
            self.add.view.hidden = NO;
        }];
    }
//    if(self.popView) {
//        [self popViewDismiss];
//        return;
//    }
//    
//    CustomPopOverView *view = [CustomPopOverView popOverView];
//    self.popView = view;
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeInfoDark];
//    btn.bounds = CGRectMake(0, 0, 60, 45);
//    btn.backgroundColor = [UIColor redColor];
//    
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 3, 280, 45)];
//    CGFloat bgWid = (bgView.frame.size.width-2)/3;
//    UIButton *notiBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, bgWid, bgView.frame.size.height)];
//    [notiBtn setTitle:@"通知公告" forState:UIControlStateNormal];
//    [notiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [notiBtn addTarget:self action:@selector(notiAction:) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:notiBtn];
//    
//    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(bgWid, 0, 1, bgView.frame.size.height)];
//    line1.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
//    [bgView addSubview:line1];
//    
//    
//    UIButton *dyBtn = [[UIButton alloc] initWithFrame:CGRectMake(bgWid+1, 0, bgWid, bgView.frame.size.height)];
//    [dyBtn setTitle:@"工作动态" forState:UIControlStateNormal];
//    [dyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [dyBtn addTarget:self action:@selector(dyAction:) forControlEvents:UIControlEventTouchUpInside];
//
//    [bgView addSubview:dyBtn];
//    
//    
//    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(bgWid*2+1, 0, 1, bgView.frame.size.height)];
//    line2.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
//    [bgView addSubview:line2];
//    
//    
//    UIButton *ybBtn = [[UIButton alloc] initWithFrame:CGRectMake(bgWid*2+1, 0, bgWid, bgView.frame.size.height)];
//    [ybBtn setTitle:@"院部动态" forState:UIControlStateNormal];
//    [ybBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [ybBtn addTarget:self action:@selector(ybAction:) forControlEvents:UIControlEventTouchUpInside];
//
//    [bgView addSubview:ybBtn];
//    
//    
//    
//    
//    view.content = bgView;
//    
//    [view showFrom:tabBar alignStyle:CPAlignStyleCenter];
}

#pragma click
-(void)ybAction:(UIButton *)btn {
    [LToast showWithText:btn.titleLabel.text];
    [self popViewDismiss];
}
-(void)dyAction:(UIButton *)btn {
    [LToast showWithText:btn.titleLabel.text];
    [self popViewDismiss];
}
-(void)notiAction:(UIButton *)btn {
    [LToast showWithText:btn.titleLabel.text];
    [self popViewDismiss];
}




- (void)popViewDismiss {
    [self.popView dismiss];
    self.popView = nil;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
