//
//  BaseTabBarViewController.m
//  JYShop
//
//  Created by 花花 on 2017/9/28.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseUIViewController.h"
#import "BaseNavViewController.h"
@interface BaseTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupControllers];
    
    

}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}


- (void)setupControllers{
    //控制器的名字HomeViewController  TestViewController
    
    NSArray *ControllerViews = @[@"HomeCategoryViewController",@"UserCenterViewController"];
    //TabBar图片
    NSArray *normalImageNames = @[@"tabbar_home_normal", @"tabbar_mine_normal"];
    //TabBar选中的图片
    NSArray *selectImageNames = @[@"tabbar_home_selected", @"tabbar_mine_selected"];
    
    //TabBarItem标题
    NSArray *titles = @[@"首页",@"个人中心"];
    
    
    for (int i = 0; i< ControllerViews.count; i++)
    {
        //1.获取类名字符串
        NSString *className= ControllerViews[i];
        //2。获取类名
        Class class = NSClassFromString(className);
        //3.创建对象
        BaseUIViewController * viewController  = [[class alloc] init];
        viewController.tabBarItem.title = titles[i];
        self.tabBar.tintColor = kThemeColor;
        
//        self.tabBar.translucent = NO;
        self.delegate = self;
        viewController.tabBarItem.image = [[UIImage imageNamed:normalImageNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.tabBarItem.selectedImage =  [[UIImage imageNamed:selectImageNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        BaseNavViewController *Nav = [[BaseNavViewController alloc]initWithRootViewController:viewController];
    
//        Nav.navigationBar.translucent = NO;
        [self addChildViewController:Nav];
        
        //        if (i==0) viewController.hiddenNavBar = YES;
        
    }
    //默认选中第一个
    self.selectedIndex = 0;
    
    
    
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

    
//    if ([viewController isKindOfClass:[BaseNavViewController class]]) {
//
//        BaseNavViewController *viewCtrl = (BaseNavViewController *)viewController;
//
//        if ([viewCtrl.viewControllers.firstObject isKindOfClass:[JYHomeViewController class]]) {
//
//            [[NSNotificationCenter defaultCenter]postNotificationName:kTabBarDidSelectedNotification object:nil];
//        }
//
//    }
    
  

}

@end
