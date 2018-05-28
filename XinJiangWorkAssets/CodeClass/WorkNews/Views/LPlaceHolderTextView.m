//
//  LPlaceHolderTextView.m
//  MobileLuoYang
//  自定义textView
//  Created by csip on 15-1-16.
//  Copyright (c) 2015年 孙波. All rights reserved.
//

#import "LPlaceHolderTextView.h"

@implementation LPlaceHolderTextView
@synthesize placeHolderLabel,rightBottomWordLabel;
@synthesize placeholder;
@synthesize placeholderColor;
@synthesize placeHolderImage;
@synthesize placeholderImg;
- (void)awakeFromNib
{
    
    [super awakeFromNib];
    
    [self setPlaceholder:@""];

    [self setPlaceholderColor:[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1.0]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setPlaceholder:@""];

        [self setPlaceholderColor:[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1.0]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}
- (void)textChanged:(NSNotification *)notification
{
    
    if([[self placeholder] length] == 0)
    {
        return;
    }
    if([[self text] length] == 0)
    {
        [[self viewWithTag:999] setAlpha:1];
        placeHolderImage.hidden = NO;
    }
    else
    {
        [[self viewWithTag:999] setAlpha:0];
        placeHolderImage.hidden = YES;
    }

    if ([[self text] length] == 0) {
        [[self viewWithTag:998] setAlpha:0];
    }else{
        [[self viewWithTag:998] setAlpha:1];
    }

    NSInteger nowTextWordCount = [[self text] length];
    NSInteger leftWordCount = _rightBottomWordCount - nowTextWordCount;
    NSInteger tolWordCount = _rightBottomWordCount;

    NSString *wordString = [_rightBootomLeftWordString stringByReplacingOccurrencesOfString:@"{s}" withString:[NSString stringWithFormat:@"%li",(long)leftWordCount]];
    wordString = [wordString stringByReplacingOccurrencesOfString:@"{d}" withString:[NSString stringWithFormat:@"%li",(long)nowTextWordCount]];
    wordString = [wordString stringByReplacingOccurrencesOfString:@"{a}" withString:[NSString stringWithFormat:@"%li",(long)tolWordCount]];

    rightBottomWordLabel.text = wordString;
}

- (void)setText:(NSString *)text {
    
    [super setText:text];
    [self textChanged:nil];
}

- (void)setPlaceholderLabelLeft:(float)placeholderLabelLeft
{
    _placeholderLabelLeft = placeholderLabelLeft;
}

- (void)drawRect:(CGRect)rect
{
    if( [[self placeholder] length] > 0)
    {
        if (placeHolderImage == nil)
        {
            placeHolderImage = [[UIImageView alloc] initWithFrame:CGRectMake(8,10,19,15)];
//            placeHolderImage.image = [UIImage imageNamed:placeholderImg];
            [self addSubview:placeHolderImage];
        }
        if ( placeHolderLabel == nil )
        {
            placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(_placeholderLabelLeft == 0?30:_placeholderLabelLeft,10,self.bounds.size.width - 16,0)];
            placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            placeHolderLabel.numberOfLines = 0;
            placeHolderLabel.font = self.font;
            placeHolderLabel.backgroundColor = [UIColor clearColor];
            placeHolderLabel.textColor = self.placeholderColor;
            placeHolderLabel.alpha = 0;
            placeHolderLabel.tag = 999;
            [self addSubview:placeHolderLabel];
        }
        placeHolderLabel.text = self.placeholder;
        [placeHolderLabel sizeToFit];
        [self sendSubviewToBack:placeHolderLabel];
        
    }

    if (_rightBootomLeftWordString.length > 0) {
        rightBottomWordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,self.bounds.size.height - 20,self.bounds.size.width - 8,16)];
        rightBottomWordLabel.lineBreakMode = NSLineBreakByWordWrapping;
        rightBottomWordLabel.numberOfLines = 0;
        rightBottomWordLabel.textAlignment = NSTextAlignmentRight;
        rightBottomWordLabel.font = _rightBottomWordLabelFont == 0 ?self.font:[UIFont systemFontOfSize:_rightBottomWordLabelFont];
        rightBottomWordLabel.backgroundColor = [UIColor clearColor];
        rightBottomWordLabel.textColor = _rightBottomWordLabelColor == NULL?RGB(120, 120, 120):_rightBottomWordLabelColor;
        rightBottomWordLabel.alpha = 0;
        rightBottomWordLabel.tag = 998;
        [self addSubview:rightBottomWordLabel];
    }
    [self sendSubviewToBack:rightBottomWordLabel];


    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    [super drawRect:rect];
}

@end
