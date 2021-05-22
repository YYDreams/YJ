//
//  HTTPRequest+NotLogin.h
//  JYFarm
//
//  Created by LOVE on 2017/12/11.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "HTTPRequest.h"
static NSInteger const resultCode_401 = 401;
static NSInteger const resultCode_501 = 501;
static NSInteger const resultCode_1032 = 1032;

@interface HTTPRequest (NotLogin)
// 用户未登录
+ (BOOL) singleLoginWithResult:(NSInteger)result msg:(NSString *)msg;
@end
