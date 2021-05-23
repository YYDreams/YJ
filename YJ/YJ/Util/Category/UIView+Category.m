//
//  UIView+Category.m
//  SamClub
//
//  Created by huahua on 2019/12/19.
//  Copyright © 2019 tencent. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Frame)

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)bottom
{
    CGRect frame = self.frame;
    return frame.origin.y + frame.size.height;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)right
{
    CGRect frame = self.frame;
    return frame.origin.x + frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (UIView *)sc_findFirstResponder
{
    if ([self isFirstResponder]) {
        return self;
    }
    for (UIView *subView in [self subviews]) {
        UIView *found = [subView sc_findFirstResponder];
        if (found != nil) return found;
    }
    return nil;
}

- (UIViewController *)sc_findViewController
{
    UIResponder *p = self;
    while (p != nil) {
        p = [p nextResponder];
        if ([p isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)p;
        }
    }
    return nil;
}

@end


@implementation UIColor (Category)

+ (UIColor *)colorWithHex:(NSUInteger)hex
{
    return [UIColor colorWithHex:hex alpha:1.0f];
}

+ (UIColor *)colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha
{
    NSUInteger red = ((hex & 0xff0000) >> 16);
    NSUInteger green = ((hex & 0xff00) >> 8);
    NSUInteger blue = (hex & 0xff);
    CGFloat r = (CGFloat)red / 255.0f;
    CGFloat g = (CGFloat)green  / 255.0f;
    CGFloat b = (CGFloat)blue / 255.0f;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

+ (UIColor *)colorWithColor:(UIColor *)color alpha:(CGFloat)alpha
{
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat al = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&al];
    
    UIColor *newColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return newColor;
}

@end

@implementation UIFont (Category)

+ (UIFont *)hhLightFontOfSize:(CGFloat)fontSize
{
    return [UIFont hhLightPingFangFontOfSize:fontSize];
}

+ (UIFont *)hhFontOfSize:(CGFloat)fontSize
{
    return [UIFont hhPingFangFontOfSize:fontSize];
}

+ (UIFont *)hhMediumFontOfSize:(CGFloat)fontSize
{
    return [UIFont hhMediumPingFangFontOfSize:fontSize];
}

+ (UIFont *)hhBoldFontOfSize:(CGFloat)fontSize
{
    return [UIFont hhBoldPingFangFontOfSize:fontSize];
}

+ (UIFont *)hhLightPingFangFontOfSize:(NSInteger)fontSize{
    
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Light" size:fontSize];//这个是9.0以后自带的平方字体
    
    if (font == nil) {
        //默认使用系统字体
        font = [UIFont systemFontOfSize:fontSize];
    }
    return font;
}

+ (UIFont *)hhPingFangFontOfSize:(NSInteger)fontSize{
    
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];//这个是9.0以后自带的平方字体
    
    if (font == nil) {
        //默认使用系统字体
        font = [UIFont systemFontOfSize:fontSize];
    }
    return font;
}

+ (UIFont *)hhMediumPingFangFontOfSize:(NSInteger)fontSize{
    
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize];//这个是9.0以后自带的平方字体
    if (font == nil) {
        //默认使用系统字体
        font = [UIFont boldSystemFontOfSize:fontSize];
    }
    return font;
}

+ (UIFont *)hhBoldPingFangFontOfSize:(NSInteger)fontSize{
    
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize];//这个是9.0以后自带的平方字体
    if (font == nil) {
        //默认使用系统字体
        font = [UIFont boldSystemFontOfSize:fontSize];
    }
    return font;
}

@end

@implementation UIImage (Category)

- (UIImage *)hh_createImageWithSize:(CGSize)imageSize gradientColors:(NSArray *)colors percentage:(NSArray *)percents gradientType:(GradientType)gradientType {
    
    NSAssert(percents.count <= 5, @"输入颜色数量过多，如果需求数量过大，请修改locations[]数组的个数");
    
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    
//    NSUInteger capacity = percents.count;
//    CGFloat locations[capacity];
    CGFloat locations[5];
    for (int i = 0; i < percents.count; i++) {
        locations[i] = [percents[i] floatValue];
    }
    
    
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, locations);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case GradientFromTopToBottom:
            start = CGPointMake(imageSize.width/2, 0.0);
            end = CGPointMake(imageSize.width/2, imageSize.height);
            break;
        case GradientFromLeftToRight:
            start = CGPointMake(0.0, imageSize.height/2);
            end = CGPointMake(imageSize.width, imageSize.height/2);
            break;
        case GradientFromLeftTopToRightBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imageSize.width, imageSize.height);
            break;
        case GradientFromLeftBottomToRightTop:
            start = CGPointMake(0.0, imageSize.height);
            end = CGPointMake(imageSize.width, 0.0);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}


@end

@implementation UIButton (Category)

/**
 * 设置图片与文字样式
 *
 * @param imagePositionStyle     图片设置样式
 * @param spacing                图片与文字之间的距离
 */
- (void)hh_imagePositionStyle: (FPImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing {
    if (imagePositionStyle == SGImagePositionStyleDefault) {
        self.imageEdgeInsets = UIEdgeInsetsMake(0, - 0.5 * spacing, 0, 0.5 * spacing);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0.5 * spacing, 0, - 0.5 * spacing);
    } else if (imagePositionStyle == SGImagePositionStyleRight) {
        CGFloat imageW = self.imageView.image.size.width;
        CGFloat titleW = self.titleLabel.frame.size.width;
        CGFloat imageOffset = titleW + 0.5 * spacing;
        CGFloat titleOffset = imageW + 0.5 * spacing;
        self.imageEdgeInsets = UIEdgeInsetsMake(0, imageOffset, 0, - imageOffset);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, - titleOffset, 0, titleOffset);
    } else if (imagePositionStyle == SGImagePositionStyleTop) {
        CGFloat imageW = self.imageView.frame.size.width;
        CGFloat imageH = self.imageView.frame.size.height;
        CGFloat titleIntrinsicContentSizeW = self.titleLabel.intrinsicContentSize.width;
        CGFloat titleIntrinsicContentSizeH = self.titleLabel.intrinsicContentSize.height;
        self.imageEdgeInsets = UIEdgeInsetsMake(- titleIntrinsicContentSizeH - spacing, 0, 0, - titleIntrinsicContentSizeW);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageW, - imageH - spacing, 0);
    } else if (imagePositionStyle == SGImagePositionStyleBottom) {
        CGFloat imageW = self.imageView.frame.size.width;
        CGFloat imageH = self.imageView.frame.size.height;
        CGFloat titleIntrinsicContentSizeW = self.titleLabel.intrinsicContentSize.width;
        CGFloat titleIntrinsicContentSizeH = self.titleLabel.intrinsicContentSize.height;
        self.imageEdgeInsets = UIEdgeInsetsMake(titleIntrinsicContentSizeH + spacing, 0, 0, - titleIntrinsicContentSizeW);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageW, imageH + spacing, 0);
    }
}


- (UIButton *)hh_gradientButtonWithSize:(CGSize)btnSize colorArray:(NSArray *)clrs percentageArray:(NSArray *)percent gradientType:(GradientType)type {
    
    UIImage *backImage = [[UIImage alloc]hh_createImageWithSize:btnSize gradientColors:clrs percentage:percent gradientType:type];
    
    [self setBackgroundImage:backImage forState:UIControlStateNormal];
    
    return self;
}
@end


@implementation UIBarButtonItem (HHAddition)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)hightImage target:(id)target action:(SEL)action{

    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];

    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.size = btn.currentBackgroundImage.size;
    
    return [[self alloc]initWithCustomView:btn];
}
+ (instancetype)itemWithtitle:(NSString *)title  target:(id)target action:(SEL)action{

    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.size = btn.currentBackgroundImage.size;
    
    return [[self alloc]initWithCustomView:btn];
}


@end
