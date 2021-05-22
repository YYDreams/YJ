//
//  UIView+Category.h
//  SamClub
//
//  Created by zoyagzhou on 2019/12/19.
//  Copyright © 2019 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//#define SC_TOPBAR_HEIGHT            (StatusBarHeight + NavigationBarHeight)
//#define SC_TOPVIEW_HEIGHT           (SCREEN_HEIGHT >= 812.0 ? 88 : 64)



#define kCurrAppBuild ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]) //(build)
#define kCurrAppVersion ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]) //(version)
#define kSystemVersion     ([UIDevice currentDevice].systemVersion)     //系统版本

#define kStringFormat(a, ...) ([NSString stringWithFormat:a, ##__VA_ARGS__])

//弱引用
#define weakSelf(self) __weak typeof(self)weakSelf = self

@interface UIView (Frame)

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

- (UIView *)sc_findFirstResponder;

- (UIViewController *)sc_findViewController;

@end


@interface UIColor (Category)

+ (UIColor *)colorWithHex:(NSUInteger)hex;

+ (UIColor *)colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha;

+ (UIColor *)colorWithColor:(UIColor *)color alpha:(CGFloat)alpha;

@end

@interface UIFont (Category)

+ (UIFont *)hhLightFontOfSize:(CGFloat)fontSize;

+ (UIFont *)hhFontOfSize:(CGFloat)fontSize;

+ (UIFont *)hhMediumFontOfSize:(CGFloat)fontSize;

+ (UIFont *)hhBoldFontOfSize:(CGFloat)fontSize;

@end

typedef NS_ENUM(NSInteger, GradientType) {
    GradientFromTopToBottom = 1,            //从上到下
    GradientFromLeftToRight,                //从做到右
    GradientFromLeftTopToRightBottom,       //从上到下
    GradientFromLeftBottomToRightTop        //从上到下
};

@interface UIImage (Category)


/**
 *  根据给定的颜色，生成渐变色的图片
 *  @param imageSize        要生成的图片的大小
 *  @param colorArr         渐变颜色的数组
 *  @param percents          渐变颜色的占比数组
 *  @param gradientType     渐变色的类型
 */
- (UIImage *)hh_createImageWithSize:(CGSize)imageSize gradientColors:(NSArray *)colorArr percentage:(NSArray *)percents gradientType:(GradientType)gradientType;


@end

typedef enum : NSInteger {
    /// 图片在左，文字在右
    SGImagePositionStyleDefault,
    /// 图片在右，文字在左
    SGImagePositionStyleRight,
    /// 图片在上，文字在下
    SGImagePositionStyleTop,
    /// 图片在下，文字在上
    SGImagePositionStyleBottom,
}FPImagePositionStyle;


@interface UIButton (Category)

- (void)hh_imagePositionStyle: (FPImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing;


/**
 *  根据给定的颜色，设置按钮的颜色
 *  @param btnSize  这里要求手动设置下生成图片的大小，防止coder使用第三方layout,没有设置大小
 *  @param clrs     渐变颜色的数组
 *  @param percent  渐变颜色的占比数组
 *  @param type     渐变色的类型
 */
- (UIButton *)hh_gradientButtonWithSize:(CGSize)btnSize colorArray:(NSArray *)clrs percentageArray:(NSArray *)percent gradientType:(GradientType)type;

@end

NS_ASSUME_NONNULL_END
