//
//  HHDefaultValue.h
//  SamClub
//
//  Created by huahua on 2020/5/11.
//  Copyright © 2020 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern BOOL HHBool(id value, BOOL defaultValue);
extern NSInteger HHInteger(id value, NSInteger defaultValue);
extern double HHDouble(id value, double defaultValue);
extern NSString * HHString(id value, NSString * _Nullable defaultValue);
extern NSArray * HHArray(id value, NSArray * _Nullable defaultValue);
extern NSDictionary * HHDictionary(id value, NSDictionary * _Nullable defaultValue);

NS_ASSUME_NONNULL_END
