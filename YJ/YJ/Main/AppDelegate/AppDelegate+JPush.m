//
//  AppDelegate+JPush.m
//  YJ
//
//  Created by flowerflower on 2021/5/23.
//

#import "AppDelegate+JPush.h"
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用 idfa 功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

#import <AppTrackingTransparency/AppTrackingTransparency.h>

#import "BaseTabBarViewController.h"

#import "BaseNavViewController.h"
#import "HHToastAlertView.h"
@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate (JPush)


- (void)initJPushWithLanchOption:(NSDictionary *)launchOptions{
    
    //添加初始化 APNs
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
      // 可以添加自定义 categories
      // NSSet<UNNotificationCategory *> *categories for iOS10 or later
      // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    //添加初始化 JPush
    
    // Optional
    // 获取 IDFA
    // 如需使用 IDFA 功能请添加此代码并在初始化方法的 advertisingIdentifier 参数中填写对应值
//      NSString *advertisingId;
//      if (@available(iOS 14, *)) {
//            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
//                if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
//                    advertisingId = [[ASIdentifierManager sharedManager] advertisingIdentifier].UUIDString;
//                }
//            }];
//        } else {
//            // 使用原方式访问 IDFA
//            advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//        }
//
//    // Required
//    // init Push
//    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey
                          channel:@"App Store"
                 apsForProduction:false
            advertisingIdentifier:nil];
    if (launchOptions) {
        NSDictionary * remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        //这个判断是在程序没有运行的情况下收到通知，点击通知跳转页面
        if (remoteNotification) {
            NSLog(@"推送消息==== %@",remoteNotification);
            [self goToMssageViewControllerWith:remoteNotification];
        }
    }
    //设置别名
    [self setupAlias];
    
    //检测通知授权情况。可选项，不一定要放在此处，可以运行一定时间后再调用
    [self performSelector:@selector(checkNotificationAuthorization) withObject:nil afterDelay:10];
}
#pragma mark - 通知权限引导

// 检测通知权限授权情况
- (void)checkNotificationAuthorization {
  [JPUSHService requestNotificationAuthorization:^(JPAuthorizationStatus status) {
    // run in main thread, you can custom ui
    NSLog(@"notification authorization status:%lu", status);
    [self alertNotificationAuthorization:status];
  }];
}

// 通知未授权时提示，是否进入系统设置允许通知，仅供参考
- (void)alertNotificationAuthorization:(JPAuthorizationStatus)status {
  if (status < JPAuthorizationStatusAuthorized) {
      [HHToastAlertView showTitle:@"允许通知" content:@"是否进入设置允许通知？"  contentAlignment:1 buttonTitles:@[@"取消",@"确定"] buttonClickedBlock:^(NSInteger index) {
          if (index == 1) {
              if(@available(iOS 8.0, *)) {
                [JPUSHService openSettingsForNotification:^(BOOL success) {
                  NSLog(@"open settings %@", success?@"success":@"failed");
                }];
              }
          }
      }];
  }
}

- (void)setupAlias{
    if ([[YJLoginManager sharedInstance] isLogin]) {
        [JPUSHService setAlias:HHString([YJLoginManager sharedInstance].model.mobile, @"匿名") completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            NSLog(@"rescode: %ld, \ntags: %@, \nalias:\n", (long)iResCode, iAlias);
        } seq:0];
    }
}

#pragma mark - SEL

- (void)goToMssageViewControllerWith:(NSDictionary*)msgDic{
    
    NSLog(@"msgDicmsgDicmsgDic%@,",msgDic);
    [self pushToViewControllerWithVC:nil];
}

//注册 APNs 成功并上报 DeviceToken
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

  /// Required - 注册 DeviceToken
  [JPUSHService registerDeviceToken:deviceToken];
    
}
//实现注册 APNs 失败接口（可选）
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
  //Optional
  NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

//添加处理 APNs 通知回调
#pragma mark- JPUSHRegisterDelegate

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
    NSLog(@"notification:%@",notification);
    
    NSDictionary * userInfo = notification.request.content.userInfo;

  if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    //从通知界面直接进入应用
      [self pushToViewControllerWithVC:nil];
      
  }else{
    //从通知设置界面进入应用
      [self pushToViewControllerWithVC:nil];
      
  }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
  // Required
  NSDictionary * userInfo = notification.request.content.userInfo;
    
  if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    [JPUSHService handleRemoteNotification:userInfo];
  }
  completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
  // Required
     NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
  if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    [JPUSHService handleRemoteNotification:userInfo];
      [self pushToViewControllerWithVC:nil];
  }
  completionHandler();  // 系统要求执行这个方法
    NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

  // Required, iOS 7 Support
  [JPUSHService handleRemoteNotification:userInfo];
  completionHandler(UIBackgroundFetchResultNewData);
}
- (void)applicationDidEnterBackground:(UIApplication *)application{
    //清除角标
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

  // Required, For systems with less than or equal to iOS 6
  [JPUSHService handleRemoteNotification:userInfo];
}

-(void)pushToViewControllerWithVC:(UIViewController *)vc {
    BaseTabBarViewController *tab = (BaseTabBarViewController *)self.window.rootViewController;
    tab.selectedIndex = 0;
}


@end
