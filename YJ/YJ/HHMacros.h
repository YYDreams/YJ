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


/*上传APP Store用woyin20190916*/
//#define MAIN_URL @"http://portal.ewoyin.cn"
//#define kApiKey @"3fd27fbeef88dd998637b0a2406bd5e5"

/*上传Fir 正式环境用woyin20190918*/
//#define MAIN_URL @"http://portal.ewoyin.cn"
//#define kApiKey @"2e77b4b881eca2eeab9007f4e1f19280"
 
//上传Fir 测试环境用woyin20190916
#define MAIN_URL @"http://47.110.49.157:8090"


//#define MAIN_URL @"https://uatmer.ewoyin.com"
#define kApiKey @"3fd27fbeef88dd998637b0a2406bd5e5"

/*--------------------------------- key 相关----------------------------------*/


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


#endif /* HHMacros_h */
