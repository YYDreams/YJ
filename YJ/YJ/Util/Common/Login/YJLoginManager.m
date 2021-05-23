//
//  YJLoginManager.m
//  YJ
//
//  Created by flowerflower on 2021/5/23.
//

#import "YJLoginManager.h"
#import "HHAppStorage.h"
@implementation YJLoginManager
@synthesize model = _model;

SC_SINGLETON_IMP;


- (void)setModel:(UserInfoModel *)model{
    _model = model;
    [self saveUserModel];
}

- (void)saveUserModel{
     
    [HHAppStorage sharedInstance].lastUserModel = _model;
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

@end
