//
//  HHNetworkConfig.h
//  YJ
//
//  Created by flowerflower on 2021/5/23.
//

#import <Foundation/Foundation.h>

#import <AFNetworking/AFNetworkReachabilityManager.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HHServiceType) {
    
    HHServiceTypeDev = 0,
    HHServiceTypeTest,
    HHServiceTypeOnline ,
};

@interface HHNetworkConfig : NSObject

+ (NSString *)config:(HHServiceType)sever;

+ (void)startMonitoringNetworkStatus;

+ (BOOL)isNetworkReachable;

+ (AFNetworkReachabilityStatus)networkReachabilityStatus;


@end

NS_ASSUME_NONNULL_END
