//
//  BaseViewController.h
//  PeachStore
//
//  Created by Jacky on 16/5/28.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
typedef NS_ENUM(NSInteger, btnContentStyle) {
    word_str,      //仅文字
    pic_rightBtn   //按钮是图片
};


@property (nonatomic, assign) BOOL isHiddenBackBtn;   //是否隐藏左上角返回按钮

@property (nonatomic, strong) NSString *myClassName;  //友盟+统计时的当前页面名称

/*!
 *  @brief navgationRightBtn(导航条右上角按钮)
 *
 *  @param type  按钮是Str还是图片
 *  @param title 如果是字符串Str
 *  @param color title的字体颜色
 *  @param image 按钮的背景图片
 */
- (void)setRightBtn:(btnContentStyle)type title:(NSString *)title titleTextColor:(UIColor *)color image:(UIImage *)image;

-(void)LeftItemAction:(UIButton *)sender;

-(void)RightItemAction:(UIButton *)sender;


- (void)showToastCenterText:(NSString *)text;

- (void)showToastBottomText:(NSString *)text;

/*!
 *  @brief 显示加载动画
 */
- (void)showWaitingPicView;

/*!
 *  @brief 隐藏加载动画
 */
- (void)hiddenWaitingPicView;


/*!
 *  @brief 显示加载框
 */
- (void)showLoadingSVP;

/*!
 *  @brief 显示特小加载框
 */
- (void)showLoadingMinView;

/*!
 *  @brief 显示加载框带文字
 *
 *  @param text 要显示的文字
 */
- (void)showLoadingSVPWithText:(NSString *)text;

/*!
 *  @brief 显示加载框带文字
 */
- (void)showLoadingSVPText;

/*!
 *  @brief 隐藏加载框
 */
- (void)hiddenLoadingSVP;

/*!
 *  @brief 隐藏特小加载框
 */
- (void)hiddenLoadingMinView;


// 根据图片url获取图片尺寸
-(CGSize)getImageSizeWithURL:(id)imageURL;



//根据URL计算图片的size
- (CGSize)getImageHeightWithURL:(NSString *)imageURL;


//缩放图片
-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;


@end
