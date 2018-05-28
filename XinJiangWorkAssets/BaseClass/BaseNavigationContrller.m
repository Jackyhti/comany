//
//  BaseNavigationContrller.m
//  CityTravel
//
//  Created by 成龙 on 17/3/23.
//  Copyright © 2017年 3L-LY. All rights reserved.
//

#import "BaseNavigationContrller.h"

@interface BaseNavigationContrller () <UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationContrller {
    BOOL _isforbidden;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        //        [self setValue:[BaseNavBar new] forKey:@"navigationBar"];
    }
    return self;
}

//初始化
+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    
    //设置状态栏颜色
    [bar setBarStyle:UIBarStyleBlack];
    bar.barTintColor = kHomeColor;
    bar.translucent = NO;

    //设置导航条上的文字属性//
    NSMutableDictionary *dicAttr = [NSMutableDictionary dictionary];
    //字体颜色
    dicAttr[NSForegroundColorAttributeName]= [UIColor whiteColor];
    //字体大小,样式
    dicAttr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    
    [bar setTitleTextAttributes:dicAttr];
    //设置item属性
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *itemArrays = [NSMutableDictionary dictionary];
    itemArrays[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    itemArrays[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [item setTitleTextAttributes:itemArrays forState:UIControlStateNormal];
    
    NSMutableDictionary *itemDisAttrys = [NSMutableDictionary dictionary];
    itemDisAttrys[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [item setTitleTextAttributes:itemDisAttrys forState:UIControlStateDisabled];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    [self setupBackPanGestureIsForbidden:NO];
    
    self.navigationBar.translucent = NO;
}

- (void)setupBackPanGestureIsForbidden:(BOOL)isForBidden {
    _isforbidden = isForBidden;
    //设置手势代理
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    // 自定义手势 手势加在谁身上, 手势执行谁的什么方法
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:gesture.delegate action:NSSelectorFromString(@"handleNavigationTransition:")];
    //为控制器的容器视图
    [gesture.view addGestureRecognizer:panGesture];
    
    gesture.delaysTouchesBegan = YES;
    
    panGesture.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //需要过滤根控制器   如果根控制器也要返回手势有效, 就会造成假死状态
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    if (_isforbidden) {
        return YES;
    }
    
    return YES;
    
}


#pragma mark - 重写父类方法拦截push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //判断是否为第一层控制器
    if (self.childViewControllers.count > 0) { //如果push进来的不是第一个控制器
//        UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backButton setImage:[UIImage imageNamed:@"title_button_back"] forState:UIControlStateNormal];
//        [backButton addTarget:self action:@selector(leftBarButtonItemClicked) forControlEvents:UIControlEventTouchUpInside];
//        [backButton sizeToFit];
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        //当push的时候 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //先设置leftItem  再push进去 之后会调用viewdidLoad  用意在于vc可以覆盖上面设置的方法
    [super pushViewController:viewController animated:animated];
}


- (void)leftBarButtonItemClicked
{
    [self popViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
