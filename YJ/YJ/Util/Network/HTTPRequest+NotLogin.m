//
//  HTTPRequest+NotLogin.m
//  JYFarm
//
//  Created by LOVE on 2017/12/11.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "HTTPRequest+NotLogin.h"
//#import "BaseNavViewController.h"
//#import "QFLoginViewController.h"
//#import "QFRevisePwdViewController.h"
//#import "AppDelegate.h"


@implementation HTTPRequest (NotLogin)

// 用户未登录
+ (BOOL) singleLoginWithResult:(NSInteger)result msg:(NSString *)msg{
    //避免下面的弹窗被MBProgressHUD盖住
//    [MBProgressHUD LY_HideHUD];

    if (result == resultCode_401) {
        [self  showLoginTips:@"登录状态异常，请重新登录" resultCode:result];
        return  YES;
    }
    else if(result == resultCode_501){
        [self  showLoginTips:msg resultCode:result];
        return YES;
    }
    else if(result == resultCode_1032){  //系统检测到您的登录地址发生了变更，请使用短信验证码登录
        [self showLoginTips:msg resultCode:result];
        return YES;
    }
    return NO;
}

+ (void)showLoginTips:(NSString *)tip resultCode:(NSInteger)resultCode
{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:(tip) preferredStyle:UIAlertControllerStyleAlert];
//
//    __block UIViewController * rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
//    UIAlertAction *loginOutAction = [UIAlertAction actionWithTitle:(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        // 清空用户登录信息
//        [LH loginOutDataHandle];
//        QFLoginViewController *loginVc = [[QFLoginViewController alloc]init];
//        loginVc.showType = LoginVcShowTypePresent;
//        if (resultCode == resultCode_1032) {
//            loginVc.isLogInCode = YES;
//        }
//        BaseNavViewController *nav = [[BaseNavViewController alloc]initWithRootViewController:loginVc];
//        [rootVC presentViewController:nav animated:YES completion:nil];
//    }];
//
//    NSMutableAttributedString * att = [[NSMutableAttributedString alloc] initWithString:tip attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
//    [alertController setValue:att forKey:@"attributedMessage"];
//    [loginOutAction setValue:[UIColor colorWithHexString:@"#0099FF"] forKey:@"titleTextColor"];
//    [alertController addAction:loginOutAction];
//    alertController.modalPresentationStyle = UIModalPresentationFullScreen;
//    [rootVC presentViewController:alertController animated:YES completion:nil];
}

@end
