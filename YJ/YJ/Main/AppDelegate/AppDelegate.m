//
//  AppDelegate.m
//  YJ
//
//  Created by flowerflower on 2021/5/21.
//

#import "AppDelegate.h"
#import "AppDelegate+UI.h"
#import "AppDelegate+Config.h"
#import "AppDelegate+JPush.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self initRootViewController];
    
    [self initAudio];
    
    [self initNetWorkConfig];
    
    [self initMMKV];
    
    
//    [self initFloatBtn];
    
#if TARGET_IPHONE_SIMULATOR //模拟器
 
#elif TARGET_OS_IPHONE //真机
    
    [self initJPushWithLanchOption:launchOptions];
 
#endif
    
//
    
    
    [self.window makeKeyAndVisible];
    
    [self showWindowLogger];

    
    return YES;
}



@end
