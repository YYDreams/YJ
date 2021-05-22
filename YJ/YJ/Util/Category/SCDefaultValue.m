//
//  SCDefaultValue.m
//  SamClub
//
//  Created by zoyagzhou on 2020/5/11.
//  Copyright © 2020 tencent. All rights reserved.
//

#import "SCDefaultValue.h"

BOOL SCBool(id value, BOOL defaultValue)
{
    if ([value isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)value boolValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [(NSString *)value boolValue];
    }

    return defaultValue;
}

NSInteger SCInteger(id value, NSInteger defaultValue)
{
    if ([value isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)value integerValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [(NSString *)value integerValue];
    }

    return defaultValue;
}

double SCDouble(id value, double defaultValue)
{
    if ([value isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)value doubleValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [(NSString *)value doubleValue];
    }

    return defaultValue;
}

NSString * SCString(id value, NSString * _Nullable defaultValue)
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

NSArray * SCArray(id value, NSArray * _Nullable defaultValue)
{
    if ([value isKindOfClass:[NSArray class]]) {
        return (NSArray *)value;
    }

    return defaultValue;
}

NSDictionary * SCDictionary(id value, NSDictionary * _Nullable defaultValue)
{
    if ([value isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)value;
    }

    return defaultValue;
}




