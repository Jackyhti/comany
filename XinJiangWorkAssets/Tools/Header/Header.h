#ifndef Header_h
#define Header_h
// 判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 4.屏幕大小尺寸
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

#define Kscreen_width [UIScreen mainScreen].bounds.size.width
#define Kscreen_height [UIScreen mainScreen].bounds.size.height


// 屏宽比上设计图宽的比例（量出的尺寸直接乘以该比例即可）
#define SCALE_SCREEN_W ((CGFloat)screen_width/1080.0)
#define SCALE(num)  (SCALE_SCREEN_W * (num))


// 2.获得RGB颜色
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)                        RGBA(r, g, b, 1.0f)

// 随机色
#define RandomColor                 RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

/***************标签颜色*******************/
#define K_TONG_GUO_COLOR            RGB(141, 203, 255)

#define K_FANG_KUAN_COLOR           RGB(132, 210, 155)

#define K_E_DU_COLOR                RGB(255, 144, 148)


#define K_TEXT_FONT_LIGHT_BK        RGB(50, 50, 50)             //字体黑

#define K_DARK_RED_COLOR            RGB(170, 0, 0) //标签文字暗红色


/**APP的主题色调-主题颜色-蓝色*/
#define K_Main_Theme_Color          RGB(255,128,0)//RGB(0,122,251)
//新添加的
#define kNavTitleFontSize 18

#define HEXCOLOR(rgbValue)                                                                                             \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0                                               \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0                                                  \
blue:((float)(rgbValue & 0xFF)) / 255.0                                                           \
alpha:1.0]

/**APP主题按钮颜色-蓝色-浅*/
#define K_Main_Button_Color         RGB(0, 133, 246)//RGB(11,130,254)//RGB(0,133,251)

/**APP统一页面背景色*/
#define K_Background_Color          [UIColor colorWithHexString:@"#eeeeee"]

//主题色
#define kHomeColor kColor(45,105,248,1)

//分割线颜色
#define kCellSpColor kColor(236, 238, 238, 1)

//十六进制颜色
#define kColor(R,G,B,A) [UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

/**列表分页的个数*/
#define K_List_limit_Count                  10
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//四寸屏幕
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)

#define iPhone6P (Kscreen_height == 736)
#define iPhone6 (Kscreen_height == 667)
#define iPhone5 (Kscreen_height == 568)
#define iPhone4 (Kscreen_height == 480)


//
//5.常用对象
#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)


#define BUTTWIDTH 25

#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"





//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLogs(FORMAT, ...) fprintf(stderr,"line%d content:%s\n",__LINE__,[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
//fprintf(stderr,"\nfunction:%s line:%d content:%s", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif


//新Bug打印机制，主要负责网络访问的参数、URL、结果等。
//----------------------下面↓----------------------------
#if DEBUG
#define NETLog(showText,FORMAT,...) fprintf(stderr,"line%d content:\n\n----------------%s↓----------------\n%s\n----------------%s↑----------------\n\n",__LINE__,[showText UTF8String],[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String],[showText UTF8String]);
//#define NETLog(showText,FORMAT,...) nil

#else
#define NETLog(showText,FORMAT,...) nil
#endif
//----------------------上面↑----------------------------


//----------------------其他----------------------------

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

//重新设定view的Y值
#define setFrameY(view, newY) view.frame = CGRectMake(view.frame.origin.x, newY, view.frame.size.width, view.frame.size.height)
#define setFrameX(view, newX) view.frame = CGRectMake(newX, view.frame.origin.y, view.frame.size.width, view.frame.size.height)
#define setFrameH(view, newH) view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, newH)
#define setFrameW(view, newW) view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, newW, view.frame.size.height)


// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

//取view的坐标及长宽
#define W(view)    view.frame.size.width
#define H(view)    view.frame.size.height
#define X(view)    view.frame.origin.x
#define Y(view)    view.frame.origin.y

/*********************沙盒路径*********************************/
#define KCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#define KdbPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

/**通用密码串*/
#define KTongYong_MIMA             @"WangDaiJuHe2017!@#$"
//图片上传、临时地址
#define K_IMAGE_FILEUP             @"http://www.baidu.com"

//获取定位X
#define KLocationX   [[UserInfoManager shareGlobalSettingInstance] getLocationStrX]
//获取定位Y
#define KLocationY   [[UserInfoManager shareGlobalSettingInstance] getLocationStrY]

#endif /* Header_h */
