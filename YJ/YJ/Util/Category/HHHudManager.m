//
//  SCHudManager.m
//  SamClub
//
//  Created by flowerflower on 2020/6/18.
//  Copyright © 2020 tencent. All rights reserved.
//

#import "HHHudManager.h"
#import "MBProgressHUD.h"
static CGFloat const defalutTime = 1.5;
static CGFloat const defalutAlpha = 1.0;
@implementation HHHudManager

+ (void)showHudLoadingView
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         dispatch_async(dispatch_get_main_queue(), ^{
             
             [self showHudLoadingToView:nil timer:defalutTime];
                  

         });
    });
}
+ (void)showHudLoadingToView:(UIView *)view timer:(int)timer{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
}

+ (void) hideHudLoadingView
{
   
    [self hideHUD];
}
+ (void)showHudWithText:(NSString *)text{
    
    [self showHudText:text toView:nil timer:defalutTime];
    
}

+ (void)showHudWithText:(NSString *)text toView:(UIView * _Nullable)view{
    
    [self showHudText:text toView:view timer:defalutTime];

}

+ (void)showHudWithText:(NSString*)text timer:(int)timer{

    [self showHudText:text toView:nil timer:timer];

}
+ (void)showSuccessText:(NSString *)text{
    
    [self showCustomIcon:@"HUD_Success" text:text];

}
+  (void)showErrorText:(NSString *)text{
    
    [self showCustomIcon:@"home_openScreen_close" text:text];

}
+ (void)showWarnText:(NSString *)text{
    
    [self showCustomIcon:@"HUD_Warn" text:text];
}

+ (void)showCustomIcon:(NSString *)iconName text:(NSString *)text {

    
}
+ (MBProgressHUD*)createMBProgressHUDviewWithMessage:(NSString*)message{
    [self hideHUD];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(defalutTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideHUD];
    });
    UIView  *view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.layer.cornerRadius = 0.0;
    hud.bezelView.backgroundColor = [UIColor colorWithHex:0x000000 alpha:defalutAlpha];
    
    
    return hud;
}

+ (void)hideHUD{
    UIView  *winView = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD hideHUDForView:winView animated:YES];
}
+ (void)showHudText:(NSString*)text toView:(UIView *)view timer:(int)timer{
    
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
         
     hud.mode = MBProgressHUDModeText;
     hud.label.text = text;
     hud.label.font = kFont(14);
     hud.label.textColor = [UIColor whiteColor];
     hud.label.numberOfLines = 0;
     hud.bezelView.layer.cornerRadius = 0;
     hud.margin = 12;
     hud.userInteractionEnabled = NO;
    [hud hideAnimated:YES afterDelay:timer];


}


@end
    
