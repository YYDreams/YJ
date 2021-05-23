//
//  HHAppStorage.m
//  SamClub
//
//  Created by huahua on 2019/12/16.
//  Copyright © 2019 tencent. All rights reserved.
//

#import "HHAppStorage.h"

@implementation HHAppStorage
{
    HHKeyValueStorage *storage;
}

+ (void)initialize
{
}

SC_SINGLETON_IMP

- (instancetype)init
{
    self = [super init];
    if (self) {
        storage = [[HHKeyValueStorage defaultStorage] subStorage:@"app_"];
    }
    return self;
}

- (UserInfoModel *)lastUserModel
{
    return [storage objectForKey:@"lastInfoModel" ofClass:[UserInfoModel class]];
}
- (void)setLastUserModel:(UserInfoModel *)lastUserModel
{
    [storage setObject:lastUserModel forKey:@"lastInfoModel"];
}


@end
