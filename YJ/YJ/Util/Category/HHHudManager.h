//
//  SCHudManager.h
//  SamClub
//
//  Created by flowerflower on 2020/6/18.
//  Copyright © 2020 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface HHHudManager : UIView
//
+ (void)showHudLoadingView;

+ (void)hideHudLoadingView;

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


NS_ASSUME_NONNULL_END
