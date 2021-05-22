//
//  MBProgressHUD+LYProgressHUD.h
//  LYLawyerPlatform
//
//  Created by caohuihui on 16/9/7.
//  Copyright © 2016年 华海乐盈. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Category)

+ (void)LY_ShowHUD:(BOOL)animation;
+ (void)LY_HideHUD:(BOOL)animation;

+ (void)LY_ShowHUD:(UIView *)toView animation:(BOOL)animation;

+ (void)LY_HideHUD:(UIView *)toView animation:(BOOL)animation;

+ (void)LY_ShowSuccess:(NSString *)success toView:(UIView *)view;
+ (void)LY_ShowError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)LY_ShowMessage:(NSString *)message toView:(UIView *)view;


+ (void)LY_ShowSuccess:(NSString *)success;
+ (void)LY_ShowError:(NSString *)error;
+ (void)LY_ShowError:(NSString *)error time:(int) time;

+ (MBProgressHUD *)LY_ShowMessage:(NSString *)message;

+ (void)LY_HideHUDForView:(UIView *)view;
+ (void)LY_HideHUD;

//显示菊花转圈
+ (MBProgressHUD *)LY_ShowProgress:(NSString *)message;


+ (void)showHudWithText:(NSString *)text;

+ (void)showHudWithText:(NSString *)text toView:(UIView * _Nullable)view;

+ (void)showHudWithText:(NSString*)text timer:(int)timer;

// 显示成功  带勾勾图标
+ (void)showSuccessText:(NSString *)text;

// 显示失败 带x图标
+ (void)showErrorText:(NSString *)text;

// 显示警告 带⚠️图标
+ (void)showWarnText:(NSString *)text;

// 显示自定义图片和提示语
+ (void)showCustomIcon:(NSString *)iconName text:(NSString *)text;
@end
