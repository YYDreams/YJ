//
//  HHDefaultValue.m
//  SamClub
//
//  Created by huahua on 2020/5/11.
//  Copyright © 2020 tencent. All rights reserved.
//

#import "HHDefaultValue.h"

BOOL HHBool(id value, BOOL defaultValue)
{
    if ([value isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)value boolValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [(NSString *)value boolValue];
    }

    return defaultValue;
}

NSInteger HHInteger(id value, NSInteger defaultValue)
{
    if ([value isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)value integerValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [(NSString *)value integerValue];
    }

    return defaultValue;
}

double HHDouble(id value, double defaultValue)
{
    if ([value isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)value doubleValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [(NSString *)value doubleValue];
    }

    return defaultValue;
}

NSString * HHString(id value, NSString * _Nullable defaultValue)
{
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString *)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)value stringValue];
    }
    if ([value isKindOfClass:[NSNull class]]) {
        return defaultValue;
    }

    return defaultValue;
}

NSArray * HHArray(id value, NSArray * _Nullable defaultValue)
{
    if ([value isKindOfClass:[NSArray class]]) {
        return (NSArray *)value;
    }

    return defaultValue;
}

NSDictionary * HHDictionary(id value, NSDictionary * _Nullable defaultValue)
{
    if ([value isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)value;
    }

    return defaultValue;
}




