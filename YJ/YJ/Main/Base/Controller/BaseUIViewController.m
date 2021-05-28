//
//  BaseUIViewController.m
//  JYShop
//
//  Created by 花花 on 2017/9/28.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "BaseUIViewController.h"
#import "LoginViewController.h"
#import "BaseNavViewController.h"
//#import "RMNoviceWelfareView.h"
@interface BaseUIViewController (){
    
    NSInteger isPacket;
    
}

@end

@implementation BaseUIViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBgColor;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showLoginVC) name:kNotLoginNotification object:nil];
    
//    
    
}
//- (void)loadIsRedPacketDataFormNetwork{
//
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"bizCode"] = @(1);
//
//    [HTTPRequest POST:kIsRedPacketUrl parameter:params success:^(id resposeObject) {
//        if (Success) {
//
//            isPacket = [resposeObject[@"data"][@"isPacket"] integerValue];//0：代表未领取 1：代表领取过
//
//            if (isPacket == 0) {
//
//                [self setupPackView];
//            }
//        }
//    } failure:^(NSError *error) {}];
//}
//
//- (void)setupPackView{
//
//    RMNoviceWelfareView *view = [[RMNoviceWelfareView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
//    view.isPacket = isPacket;
//    __weak RMNoviceWelfareView *noviceView = view;
//
//    view.handlerRemoveCallBack = ^{
//        [noviceView removeView];
//    };
//    view.handlerReceiveCallBack = ^{
//        [noviceView removeView];
//
//    };
//    [view showInView:self.navigationController.view];
//
//}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏导航栏
    if (self.isHiddenNavBar==YES)
    {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //显示导航栏
    if (self.isHiddenNavBar==YES)
    {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
    
}

//显示登录界面
- (void)showLoginVC{
    
    LoginViewController*loginVc = [[LoginViewController  alloc]init];
    loginVc.modalPresentationStyle = 0;
    [self presentViewController:loginVc animated:YES completion:nil];
    

}

#pragma mark - loadData

//加载网络数据 子类需要重写
- (void)loadDataFromNetwork{
    
    
}
#pragma mark - setupUI

//子类重写 自定义导航栏
- (void)setupNav{
    
    
}

//子类重写
- (void)setupUI{
    
}

//网络从无网状态变为有网状态回调这个方法
- (void)autoDoRetryRequest
{
    
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

@end
