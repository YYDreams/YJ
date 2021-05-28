//
//  SCHudManager.m
//  SamClub
//
//  Created by flowerflower on 2020/6/18.
//  Copyright © 2020 tencent. All rights reserved.
//

#import "HHHudManager.h"
#import "MBProgressHUD.h"
#define imageHeight 228
#define imageWidth 172
static CGFloat const defalutTime = 1.5;
static CGFloat const defalutAlpha = 1.0;
@implementation HHHudManager
+ (MBProgressHUD*)createMBProgressHUDviewWithMessage:(NSString*)message isWindiw:(BOOL)isWindow backGroundColor: (UIColor *)backColor
{
    [self hideHUD];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideHUD];
    });
    
    
    
    UIView  *view = isWindow ? [UIApplication sharedApplication].keyWindow :[self getCurrentUIVC].view;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    hud.label.text=message?(message):@"";// 加载中.....
    hud.label.font=[UIFont systemFontOfSize:15];
    
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.88];
//    hud.animationType = MBProgressHUDAnimationZoomIn;//放大消失
    hud.activityIndicatorColor = [UIColor whiteColor];
//    hud.backgroundView.color = backColor? backColor:[UIColor clearColor];
    hud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    
    return hud;
}
#pragma mark-------------------- show Tip----------------------------

// clearColor
+ (void)showTipMessageInWindow:(NSString*)message
{
    [self showTipMessage:message isWindow:true timer:1 backColor:nil];
}
+ (void)showTipMessageInView:(NSString*)message
{
    [self showTipMessage:message isWindow:false timer:1 backColor:nil];
}
+ (void)showTipMessageInWindow:(NSString*)message timer:(int)aTimer
{
    [self showTipMessage:message isWindow:true timer:aTimer backColor:nil];
}
+ (void)showTipMessageInView:(NSString*)message timer:(int)aTimer
{
    [self showTipMessage:message isWindow:false timer:aTimer backColor:nil];
}

// WithColor
+ (void)showTipMessageInWindow:(NSString*)message backColor:(UIColor *)color
{
    [self showTipMessage:message isWindow:true timer:1 backColor:color];
}
+ (void)showTipMessageInView:(NSString*)message backColor:(UIColor *)color
{
    [self showTipMessage:message isWindow:false timer:1 backColor:color];
}
+ (void)showTipMessageInWindow:(NSString*)message timer:(int)aTimer backColor:(UIColor *)color
{
    [self showTipMessage:message isWindow:true timer:aTimer backColor:color];
}
+ (void)showTipMessageInView:(NSString*)message timer:(int)aTimer backColor:(UIColor *)color
{
    [self showTipMessage:message isWindow:false timer:aTimer backColor:color];
}

+ (void)showTipMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(int)aTimer backColor: (UIColor *)backColor
{
    MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow backGroundColor:backColor];
    hud.mode = MBProgressHUDModeText;
    hud.label.textColor = [UIColor whiteColor];
    [hud hideAnimated:YES afterDelay:aTimer];
}



#pragma mark-------------------- show Activity----------------------------

// clearColor
+ (void)showActivityMessageInWindow:(NSString*)message
{
    [self showActivityMessage:@"" isWindow:true timer:0 backColr:nil];
}
+ (void)showActivityMessageInView:(NSString*)message
{
    [self showActivityMessage:@"" isWindow:false timer:0 backColr:nil];
}
+ (void)showActivityMessageInWindow:(NSString*)message timer:(int)aTimer
{
    [self showActivityMessage:message isWindow:true timer:aTimer backColr:nil];
}
+ (void)showActivityMessageInView:(NSString*)message timer:(int)aTimer
{
    [self showActivityMessage:message isWindow:false timer:aTimer backColr:nil];
}


// backColor
+ (void)showActivityMessageInWindow:(NSString*)message backColor:(UIColor *)color
{
    [self showActivityMessage:message isWindow:true timer:0 backColr:color];
}
+ (void)showActivityMessageInView:(NSString*)message backColor:(UIColor *)color
{
    [self showActivityMessage:message isWindow:false timer:0 backColr:color];
}
+ (void)showActivityMessageInWindow:(NSString*)message timer:(int)aTimer backColor:(UIColor *)color
{
    [self showActivityMessage:message isWindow:true timer:aTimer backColr:color];
}
+ (void)showActivityMessageInView:(NSString*)message timer:(int)aTimer backColor:(UIColor *)color
{
    [self showActivityMessage:message isWindow:false timer:aTimer backColr:color];
}


+ (void)showActivityMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(int)aTimer backColr :(UIColor *)color
{
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow backGroundColor:color];
//    hud.mode = MBProgressHUDModeCustomView;
//    hud.customView = [self gifImages];
    hud.bezelView.backgroundColor = [UIColor clearColor];
    hud.bezelView.color = [UIColor colorWithWhite:1 alpha:0.0];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.label.textColor = [UIColor whiteColor];
    if (aTimer>0) {
        [hud hideAnimated:YES afterDelay:aTimer];
    }
}
#pragma mark-------------------- show Image----------------------------

// clearColor
+ (void)showSuccessMessage:(NSString *)Message
{
    NSString *name =@"MBHUD_Success";
    [self showCustomIconInWindow:name message:Message];
}
+ (void)showErrorMessage:(NSString *)Message
{
    NSString *name =@"MBHUD_Error";
    [self showCustomIconInWindow:name message:Message];
}
+ (void)showInfoMessage:(NSString *)Message
{
    NSString *name =@"MBHUD_Info";
    [self showCustomIconInWindow:name message:Message];
}
+ (void)showWarnMessage:(NSString *)Message
{
    NSString *name =@"MBHUD_Warn";
    [self showCustomIconInWindow:name message:Message];
}
+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message
{
    [self showCustomIcon:iconName message:message isWindow:true backColor:nil];
    
}
+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message
{
    [self showCustomIcon:iconName message:message isWindow:false backColor:nil];
}

// backColor
+ (void)showSuccessMessage:(NSString *)Message backColor:(UIColor *)color
{
    NSString *name =@"MBHUD_Success";
    [self showCustomIconInWindow:name message:Message backColor:color];
}
+ (void)showErrorMessage:(NSString *)Message backColor:(UIColor *)color
{
    NSString *name =@"MBHUD_Error";
    [self showCustomIconInWindow:name message:Message backColor:color];
}
+ (void)showInfoMessage:(NSString *)Message backColor:(UIColor *)color
{
    NSString *name =@"MBHUD_Info";
    [self showCustomIconInWindow:name message:Message backColor:color];
}
+ (void)showWarnMessage:(NSString *)Message backColor:(UIColor *)color
{
    NSString *name =@"MBHUD_Warn";
    [self showCustomIconInWindow:name message:Message backColor:color];
}
+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message backColor:(UIColor *)color
{
    [self showCustomIcon:iconName message:message isWindow:true backColor:color];
    
}
+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message backColor:(UIColor *)color
{
    [self showCustomIcon:iconName message:message isWindow:false backColor:color];
}

+ (void)showCustomIcon:(NSString *)iconName message:(NSString *)message isWindow:(BOOL)isWindow backColor:(UIColor *)color
{
    
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow backGroundColor:color];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.textColor = [UIColor whiteColor];
    hud.label.numberOfLines = 0;
    [hud hideAnimated:YES afterDelay:2];
    
}
+ (void)hideHUD
{
    UIView  *winView =[UIApplication sharedApplication].keyWindow;
    [MBProgressHUD hideHUDForView:winView animated:YES];
    [MBProgressHUD hideHUDForView:[self getCurrentUIVC].view animated:YES];
}

//获取当前屏幕显示的viewcontroller
+(UIViewController *)getCurrentWindowVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows)
        {
            if (tempWindow.windowLevel == UIWindowLevelNormal)
            {
                window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
    {
        result = nextResponder;
    }
    else
    {
        result = window.rootViewController;
    }
    return  result;
}
+(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [[self class]  getCurrentWindowVC ];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}


+(void)setBackGroundColor:(UIColor *)backGroundColor {
    MBProgressHUD * hud = [MBProgressHUD new];
    hud.backgroundView.backgroundColor = backGroundColor;
}


/**
 view展示activity提示语
 
 @param message 提示语内容
 */
+ (void)showActivityMessageInView:(NSString*)message inView:(UIView *)view{
    MBProgressHUD * hud = [MBProgressHUD HUDForView:view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.margin = 10;
        hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.label.font=[UIFont systemFontOfSize:14];
        hud.label.textColor = [UIColor whiteColor];
        hud.removeFromSuperViewOnHide = YES;
        hud.bezelView.backgroundColor = [UIColor blackColor];
        hud.animationType = MBProgressHUDAnimationFade;
        hud.activityIndicatorColor = [UIColor whiteColor];
        hud.backgroundView.color = [UIColor clearColor];
    }
    hud.label.text = message;// 加载中.....
}
+ (void)hideHUDFromView:(UIView *)view{
    [MBProgressHUD hideHUDForView:view animated:YES];
}

// clearColor
+ (void)showSucc:(NSString *)msg inView:(UIView *)view
{
    MBProgressHUD * hud = [self getDefaultHUD:view];
    hud.label.text = msg;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBHUD_Success"]];
    [hud hideAnimated:YES afterDelay:1];
    hud.label.textColor = [UIColor whiteColor];
}
+ (void)showErr:(NSString *)msg inView:(UIView *)view
{
    MBProgressHUD * hud = [self getDefaultHUD:view];
    hud.label.text = msg;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBHUD_Error"]];
    [hud hideAnimated:YES afterDelay:1];
    hud.label.textColor = [UIColor whiteColor];
}
+ (void)showTip:(NSString *)msg inView:(UIView *)view
{
    if (!msg) {
        return;
    }
    MBProgressHUD * hud = [self getDefaultHUD:view];
    hud.label.text = msg;
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:1];
    hud.label.textColor = [UIColor whiteColor];
}
+ (MBProgressHUD *)getDefaultHUD:(UIView *)view{
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD * hud = [MBProgressHUD HUDForView:view];
    if (hud) {
        return hud;
    }
    hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.margin = 10;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.label.font = [UIFont systemFontOfSize:15];
    hud.label.numberOfLines = 0;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.animationType = MBProgressHUDAnimationFade;
    hud.backgroundView.color = [UIColor clearColor];
    return hud;
}

@end
    
