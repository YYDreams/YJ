//
//  AppDelegate+UI.m
//  YJ
//
//  Created by flowerflower on 2021/5/21.
//

#import "AppDelegate+UI.h"
#import "BaseTabBarViewController.h"
#import "BaseNavViewController.h"
#import "LoginViewController.h"
@implementation AppDelegate (UI)


- (void)initRootViewController{

    if ([YJLoginManager sharedInstance].isLogin) {
        [self setTabBar];
    }else{
        
        self.window.rootViewController =[[UINavigationController alloc]initWithRootViewController: [[LoginViewController alloc]init]];
    }
}
- (void)setTabBar{
    
    self.window.rootViewController = [[BaseTabBarViewController alloc]init];
    
}


//加载引导页
- (void)initLinkPage{

}

@end
