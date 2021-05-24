//
//  HHMacros.h
//  RACProject
//
//  Created by flowerflower on 2020/4/23.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#ifndef HHMacros_h
#define HHMacros_h

#define Screen_Bounds [UIScreen mainScreen].bounds
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define SC_DP_375(size)   ((CGFloat)(size) / (375.0) * (MIN(kScreenWidth, kScreenHeight)))


// iPhone X系列判断
//#define  IS_iPhoneX (CGSizeEqualToSize(CGSizeMake(375.f, 812.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(812.f,375.f), [UIScreen mainScreen].bounds.size)  || CGSizeEqualToSize(CGSizeMake(414.f,896.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(896.f,414.f), [UIScreen mainScreen].bounds.size))

#define IS_iPhoneX ({\
BOOL isiPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
UIWindow *window = [UIApplication sharedApplication].delegate.window;\
if (window.safeAreaInsets.bottom > 0.0) {\
isiPhoneX = YES;\
}\
}\
isiPhoneX;\
})



/**
 
 非iPhone X ：
 StatusBar 高20px，NavigationBar 高44px，底部TabBar高49px
 iPhone X：
 StatusBar 高44px，NavigationBar 高44px，底部TabBar高83px
 */

// 状态栏高度`

#define StatusBarHeight (IS_iPhoneX ? 44.f : 20.f)


//#define kStatusHeight (IS_iPhoneX ? 0.f : 0.f)
// 导航栏高度
#define kNavHeight (IS_iPhoneX ? 88.f : 64.f)
// tabBar高度
#define kTabBarHeight (IS_iPhoneX ? 83 : 49.f)

// 安全区域高度`

#define kTabbarSafeBottomMargin     (IS_iPhoneX ? 34.f : 0.f)


// 开发服务器地址
#define kBaseUrlDev @"http://47.110.49.157:8090"

//测试服务器地址
#define kBaseUrlTest @"http://47.110.49.157:8090"

//正式服务器地址
#define kBaseUrlOnline @"http://47.110.49.157:8090"


/*--------------------------------- key 相关----------------------------------*/

// JPush
#define JPushAppKey @"655289800951f457cf6f3203"
#define JPushAppSecret @"50b5d35b94b1383a901b119c"




#define  Success [resposeObject[@"success"] boolValue]



//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || (![str isKindOfClass:[NSString class]]) || [str length] < 1 ? YES : NO )

//数组是否为空
#define kArrayIsEmpty(array) (array == nil || (![array isKindOfClass:[NSArray class]]) || array.count == 0)

//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || (![dic isKindOfClass:[NSDictionary class]]) || dic.allKeys == 0)

//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))




/*----------------------------------字体 相关----------------------------------*/
// 系统字体大小定义
#define kFont(FontSize)    ([UIFont hhFontOfSize:FontSize])

#define kFontWithMedium(FontSize)    ([UIFont hhMediumFontOfSize:FontSize])
#define kFonWithLight(FontSize)    ([UIFont hhLightFontOfSize:FontSize])

#define kFontWithBold(FontSize)    [UIFont hhBoldFontOfSize:FontSize]


/*----------------------------------function 相关----------------------------------*/
// 设置view圆角
#define kViewRadius(view, radius)\
\
[view.layer setCornerRadius:(radius)];\
[view.layer setMasksToBounds:YES]

#define KImageNamed(name)\
 [UIImage imageNamed:name]


#define HHLocalizedString(s)                    NSLocalizedString(s, nil)//国际化字符串

//适配屏幕尺寸大小



#define WeakSelf __weak typeof(self) weakSelf = self


//打印
#if DEBUG
#define NSLog(fmt,...) NSLog((@"%s [Line %d]" fmt),__PRETTY_FUNCTION__,__LINE__,##__VA_ARGS__)
#else
#define NSLog(...)
#endif


/*----------------------------------color 相关----------------------------------*/
//背景色 浅灰色

//#define kGlobalColor  [UIColor colorWithHex:0xF2F2F2"]
//背景色
#define kBgColor [UIColor colorWithHex:0xF2F2F2]
//主色 浅蓝色  如导航栏、商品按钮
#define kThemeColor   [UIColor colorWithHex:0x5B9AF7]

//辅主色
#define K2FF2CF  [UIColor colorWithHex:0x2FF2CF]

#define kRedColor  [UIColor colorWithHex:0xFD5A6A]

//辅色 红色  如价格、删除
//#define kRedColor   [UIColor colorWithHex:0xFB483E"]
//辅色 蓝色 如我的页面图标
#define kBlueColor   [UIColor colorWithHex:0x39A1ED]

//文字  黑色 如导航、标题、正文
#define k3Color   [UIColor colorWithHex:0x333333]
//文字   浅灰色  如提示、正文
#define k6Color   [UIColor colorWithHex:0x666666]
//文字 浅灰色 如提示、正文
#define k9Color   [UIColor colorWithHex:0x999999]
//文字  白色
#define kfColor   [UIColor colorWithHex:0xffffff]
//分割线颜色
#define kSeparatedLineColor   [UIColor colorWithHex:0xDCDDDD]

#define kD0Color  [UIColor colorWithHex:0xD0D0D0]


//浅灰色
#define kf2Color   [UIColor colorWithHex:0xF2F2F2]



#define SC_SINGLETON_DEF \
+ (instancetype)sharedInstance;

#define SC_SINGLETON_IMP \
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } ); \
return __singleton__; \
}

#endif /* HHMacros_h */
