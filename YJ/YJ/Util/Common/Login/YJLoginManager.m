//
//  YJLoginManager.m
//  YJ
//
//  Created by flowerflower on 2021/5/23.
//

#import "YJLoginManager.h"
#import "HHAppStorage.h"
#import "JPUSHService.h"
@implementation YJLoginManager
@synthesize model = _model;

SC_SINGLETON_IMP;

- (void)setModel:(UserInfoModel *)model{
    _model = model;
    [self saveUserModel];
}

- (void)saveUserModel{
     
    [HHAppStorage sharedInstance].lastUserModel = _model;
    
    [self configAliases];
}
-(UserInfoModel *)model{
    if (!_model) {
        _model = [HHAppStorage sharedInstance].lastUserModel;
    }
    return _model;
}
- (BOOL)isLogin{
    
    return  (self.token.length > 0);
    
}

- (void)doLogout{
    //清空token
    [self setToken:@""];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kToken];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"khallIds"];
    self.model = nil;
    
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"rescode: %ld, \ntags: %@, \nalias:\n", (long)iResCode, iAlias);

    } seq:0];
    
}
- (void)setHallIds:(NSString *)hallIds{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    [userdefault  setValue:hallIds forKey:@"khallIds"];
    [userdefault synchronize];
}
- (NSString *)hallIds{
    
    return [[NSUserDefaults standardUserDefaults]valueForKey:@"khallIds"];

}

- (void)setToken:(NSString *)token{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    [userdefault  setValue:token forKey:kToken];
    [userdefault synchronize];
    
}
- (NSString *)token{
    
    return [[NSUserDefaults standardUserDefaults]valueForKey:kToken];
}

/////配置极光推送别名
- (void)configAliases{
    if ([[YJLoginManager sharedInstance] isLogin]) {
        //查询别名的设备数
        NSString *iAlias = HHString([YJLoginManager sharedInstance].model.mobile, @"");
        NSString *urlString = [NSString stringWithFormat:@"https://device.jpush.cn/v3/aliases/%@",iAlias];
        [HTTPRequest GETOriginal:urlString parameter:nil success:^(id resposeObject) {
            // 会返回指定别名绑定的所有RegistrationID(最多10个)
            // 如果设备数大于等于10，则进行删除操作
            NSArray *registration_ids = HHArray(resposeObject[@"registration_ids"], @[]);
            if (registration_ids.count >=10) {
                [self deleAliasRequestWithregistration_ids:registration_ids];
            }else{
                [self configAlias];
            }
            NSLog(@"resposeObjectresposeObject: %zd  %@ ",registration_ids.count,registration_ids);
        
        } failure:^(NSError *error) {
            [self configAlias];
        }];
    }
}
//配置别名
- (void)configAlias{
    
    [JPUSHService setAlias:HHString([YJLoginManager sharedInstance].model.mobile,@"匿名") completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"rescode: %ld, \ntags: %@, \nalias:\n", (long)iResCode, iAlias);
    } seq:0];
    
}
//批量解除绑定
- (void)deleAliasRequestWithregistration_ids:(NSArray *)registration_ids{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"registration_ids"] =  @{@"remove":registration_ids};
    NSString *iAlias = HHString([YJLoginManager sharedInstance].model.mobile, @"");
    NSString *urlString = [NSString stringWithFormat:@"https://device.jpush.cn/v3/aliases/%@",iAlias];
    [HTTPRequest POSTOriginal:urlString parameter:parameter success:^(id resposeObject) {
        NSLog(@"批量解除绑定: %@ ",resposeObject);
        [self configAlias];
    } failure:^(NSError *error) {
        [self configAlias];
    }];
}

@end
