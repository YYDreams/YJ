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
    
    [self initNetWorkConfig];
    
    [self initMMKV];
    
    [self initRootViewController];
    
    [self initAudio];
    
    
    [self initFloatBtn];
    
//    [self initJPushWithLanchOption:launchOptions];
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}



@end
