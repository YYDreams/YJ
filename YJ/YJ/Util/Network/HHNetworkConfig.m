//
//  HHNetworkConfig.m
//  YJ
//
//  Created by flowerflower on 2021/5/23.
//

#import "HHNetworkConfig.h"

@implementation HHNetworkConfig


+ (NSString *)config:(HHServiceType)sever{

    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
        
    NSString *msg = @"";
    NSString *baseUrl = @"";
    switch (sever) {
        case HHServiceTypeDev:     // 开发服务器地址
            baseUrl = kBaseUrlDev;
            
            msg = [NSString stringWithFormat:@"开发环境%@",baseUrl];
            break;
        case HHServiceTypeTest:     //测试服务器地址
            baseUrl = kBaseUrlTest;
            msg = [NSString stringWithFormat:@"测试环境%@",baseUrl];
            break;
        case HHServiceTypeOnline:     //正式服务器地址
            baseUrl = kBaseUrlOnline;
            msg = [NSString stringWithFormat:@"正式环境%@",baseUrl];
            break;
        default:
            break;
    }
    [userdefault  setValue:baseUrl forKey:kBaseUrl];
    [userdefault synchronize];

    NSLog(@"当前环境处于:%@ baseUrl:%@",msg,baseUrl);
    return msg;
    
}

+ (void)startMonitoringNetworkStatus{
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch ((NSInteger)status) {
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"网络连接中断");
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"noHaveNetworking" object:self userInfo:nil];
                
                break;
            }
            case AFNetworkReachabilityStatusUnknown:{
                NSLog(@"网络连接中断");
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"noHaveNetworking" object:self userInfo:nil];
                
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"当前WiFi网络");
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"haveNetworking" object:self userInfo:nil];
                
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog(@"当前3G网络");
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"haveNetworking" object:self userInfo:nil];
                
                break;
            }
        }
    }];
}

//返回网络状态
+ (AFNetworkReachabilityStatus)networkReachabilityStatus{
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}

+ (BOOL)isNetworkReachable{
    if ([HHNetworkConfig networkReachabilityStatus] == AFNetworkReachabilityStatusReachableViaWiFi || [HHNetworkConfig networkReachabilityStatus] == AFNetworkReachabilityStatusReachableViaWWAN  ) {
        return YES;
    }else{
        return NO;
    }
}
@end
