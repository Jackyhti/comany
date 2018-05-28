//
//  LPlaceHolderTextView.h
//  MobileLuoYang
//  自定义textView
//  Created by csip on 15-1-16.
//  Copyright (c) 2015年 孙波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPlaceHolderTextView : UITextView
{
    NSString *placeholder;
    UIColor *placeholderColor;
@private
    UILabel *placeHolderLabel;

    UILabel *rightBottomWordLabel;
}

@property(nonatomic, retain) UILabel *placeHolderLabel;



@property(nonatomic, retain) UIImageView *placeHolderImage;

@property(nonatomic, retain) NSString *placeholderImg;

@property(nonatomic, retain) NSString *placeholder;

@property(nonatomic, retain) UIColor *placeholderColor;

@property(nonatomic, assign) float placeholderLabelLeft;

@property(nonatomic, retain) UILabel *rightBottomWordLabel;

/**
 右下角文字剩余字符显示格式，例如:[您还可以输入{s}个字符]|[{w}/{a}字符]等；
 说明：{d}当前输入字符数；{s}剩余可输入的字符串；{a}总共可以输入的字符串；
 */
@property(nonatomic, retain) NSString *rightBootomLeftWordString;

@property(nonatomic, assign) float rightBottomWordLabelFont;

@property(nonatomic, retain) UIColor *rightBottomWordLabelColor;

@property(nonatomic, assign) NSInteger rightBottomWordCount;

/**
 *	@brief	文本改变时调用改方法
 *
 *	@param 	notification    通知
 */
-(void)textChanged:(NSNotification*)notification;


@end
