//
//  HHSharedStorage.m
//  SamClub
//
//  Created by huahua on 2019/12/16.
//  Copyright © 2019 tencent. All rights reserved.
//

#import "HHSharedStorage.h"

static NSString * const HHSharedStorageKeyServerType = @"serverType";

@implementation HHSharedStorage
{
    HHKeyValueStorage *storage;
}

SC_SINGLETON_IMP

- (instancetype)init
{
    self = [super init];
    if (self) {
        storage = [[HHKeyValueStorage defaultStorage] subStorage:@"shared_"];
    }
    return self;
}

- (int)serverType
{
    NSNumber *value = [storage objectForKey:HHSharedStorageKeyServerType ofClass:NSNumber.class];
    if (!value) {
        value = @(2);
        [storage setObject:value forKey:HHSharedStorageKeyServerType];
    }
    return [value intValue];
}

- (void)setServerType:(int)serverType
{
    if ([self serverType] != serverType) {
        [storage setObject:@(serverType)
                    forKey:HHSharedStorageKeyServerType];
        
        //do notification
    }
}

@end
