//
//  SCToastAlertView.h
//  SamClub
//
//  Created by huahua on 2020/3/25.
//  Copyright © 2020 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//按钮回调
typedef void(^HandlerButtonClickBlock)(NSInteger index);

//可点击的content的回调
typedef void(^HandlerContentClickBlock)(NSInteger index);

@interface HHToastAlertView : UIView

/// 普通弹框 默认底部一个按钮（我知道了）
/// @param title 标题
/// @param content 内容  默认content中的内容居中显示
/// @param buttonClickedBlock  按钮回调

+ (instancetype)showTitle:(nullable NSString *)title
                  content:(nullable NSString *)content
             buttonTitles:(nullable NSArray <NSString *> *)buttonTitles
       buttonClickedBlock:(nullable HandlerButtonClickBlock)buttonClickedBlock;


/// 普通弹框
/// @param title 标题
/// @param content 内容
/// @param contentAlignment  0: 靠左显示   1：居中显示   2:靠右显示
/// @param buttonTitles  按钮标题数组
/// @param buttonClickedBlock  按钮回调

+ (instancetype)showTitle:(nullable NSString *)title
                  content:(nullable NSString *)content
         contentAlignment:(NSTextAlignment)contentAlignment
             buttonTitles:(nullable NSArray <NSString *> *)buttonTitles
       buttonClickedBlock:(nullable HandlerButtonClickBlock)buttonClickedBlock;


/// 普通弹框可设置buttonColors
/// @param title 标题
/// @param content 内容
/// @param contentAlignment  0: 靠左显示   1：居中显示   2:靠右显示
/// @param buttonTitles  按钮标题数组
/// @param buttonColors  按钮字体颜色数组 eg:@[[UIColor redColor],[UIColor yellowColor]]
/// @param buttonClickedBlock  按钮回调
+ (instancetype)showTitle:(nullable NSString *)title
                  content:(nullable NSString *)content
         contentAlignment:(NSTextAlignment)contentAlignment
             buttonTitles:(nullable NSArray <NSString *> *)buttonTitles
             buttonColors:(nullable NSArray <UIColor *> *)buttonColors
       buttonClickedBlock:(nullable HandlerButtonClickBlock)buttonClickedBlock;


/// 普通弹框可设置buttonColors, contentMaxHeight
/// @param title 标题
/// @param content 内容
/// @param contentAlignment  0: 靠左显示   1：居中显示   2:靠右显示
/// @param buttonTitles  按钮标题数组
/// @param buttonColors  按钮字体颜色数组  eg:@[[UIColor redColor],[UIColor yellowColor]]
/// @param contentMaxHeight content内容的最大高度 如设置最大高度 当内容超过 则content可滚动
/// @param buttonClickedBlock  按钮回调

+ (instancetype)showTitle:(nullable NSString *)title
                  content:(nullable NSString *)content
         contentAlignment:(NSTextAlignment)contentAlignment
             buttonTitles:(nullable NSArray <NSString *> *)buttonTitles
             buttonColors:(nullable NSArray <UIColor *> *)buttonColors
         contentMaxHeight:(CGFloat)contentMaxHeight
       buttonClickedBlock:(nullable HandlerButtonClickBlock)buttonClickedBlock;


/// 特殊情况 eg: 购物须知 弹框里面content还有点击事件
/// @param title 标题
/// @param content 内容
/// @param contentAlignment  0: 靠左显示   1：居中显示   2:靠右显示
/// @param buttonTitles  按钮标题数组
/// @param contentMaxHeight content内容的最大高度 如设置最大高度 当内容超过 则content可滚动
/// @param clickableContents 可点击的文字内容
/// @param contentClickedBlock content可点击的回调
/// @param buttonClickedBlock  按钮回调

+ (instancetype)showTitle:(nullable NSString *)title
                  content:(nullable NSString *)content
         contentAlignment:(NSTextAlignment)contentAlignment
             buttonTitles:(nullable NSArray<NSString *> *)buttonTitles
         contentMaxHeight:(CGFloat)contentMaxHeight
        clickableContents:(nullable NSArray <NSString *> *)clickableContents
      contentClickedBlock:(nullable HandlerContentClickBlock)contentClickedBlock
       buttonClickedBlock:(nullable HandlerButtonClickBlock)buttonClickedBlock;



+ (instancetype)showTitle:(nullable NSString *)title
           content:(nullable NSString *)content
       Zengcontent:(NSArray*)contentArr
       buttonClickedBlock:(nullable HandlerButtonClickBlock)buttonClickedBlock;

@end

NS_ASSUME_NONNULL_END
