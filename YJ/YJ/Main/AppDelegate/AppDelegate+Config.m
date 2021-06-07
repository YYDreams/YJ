//
//  AppDelegate+Config.m
//  YJ
//
//  Created by flowerflower on 2021/5/21.
//

#import "AppDelegate+Config.h"
#import "HHNetworkConfig.h"
#import "HHSharedStorage.h"
#import <MMKV.h>
#import <AVFoundation/AVFoundation.h>
#import <MNFloatBtn/MNFloatBtn.h>
#import "HHDeveloperViewController.h"

@implementation AppDelegate (Config)


- (void)initMMKV{
    
    [MMKV initializeMMKV:nil];

}

//网络配置
- (void)initNetWorkConfig{
    
    NSInteger serverType = [HHSharedStorage sharedInstance].serverType;

    [HHNetworkConfig config:serverType];
    
    [HHNetworkConfig startMonitoringNetworkStatus];
}

- (void)initAudio{
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
}
- (void)initFloatBtn{
    
//    //延迟加载VersionBtn - 避免wimdow还没出现就往上加控件造成的crash
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self showFloatBtn];
//    });
//   
    
}
- (void)showFloatBtn{
    [MNFloatBtn showDebugModeWithType:MNAssistiveTypeNone];
    
#ifdef DEBUG
    //如果要实现MNFloatBtn 的切换环境功能，必须这样设置
    #define kAddress [[NSUserDefaults standardUserDefaults]objectForKey:@"MNBaseUrl"]
#else
    //正式环境地址
    #define kAddress kBaseUrlOnline
#endif
    
    NSDictionary *envMap = @{
                             @"开发":kBaseUrlDev,
                             @"测试":kBaseUrlTest,
                             @"生产":kBaseUrlOnline
                             };
    
    [MNFloatBtn showDebugModeWithType:MNAssistiveTypeNone];
//
//    //设置不同环境下，要展示的不同title，以及当前的Base Url
//    [MNFloatBtn setEnvironmentMap:envMap currentEnv:kAddress];
//
    
    [MNFloatBtn sharedBtn].btnClick = ^(UIButton *sender) {
//
//
//        HHDeveloperViewController *vc = [[HHDeveloperViewController alloc]init];
//        vc.view.frame = CGRectMake(0, 200, kScreenWidth, 400);
//        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//        [window addSubview:vc.view];
//        NSLog(@" btn.btnClick ~");

    };
    
    
}

- (void)showWindowLogger{
    

}


@end
