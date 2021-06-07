//
//  YJLoginManager.h
//  YJ
//
//  Created by flowerflower on 2021/5/23.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YJLoginManager : NSObject
@property (nonatomic, strong) UserInfoModel *model;

@property (nonatomic, copy) NSString  *token;

@property (nonatomic, copy) NSString  *hallIds; //棋牌室id


SC_SINGLETON_DEF;

- (void)saveUserModel;

- (BOOL)isLogin;

- (void)doLogout;

//配置极光推送别名
- (void)configAliases;


@end

NS_ASSUME_NONNULL_END
