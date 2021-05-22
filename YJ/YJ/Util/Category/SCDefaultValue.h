//
//  SCDefaultValue.h
//  SamClub
//
//  Created by zoyagzhou on 2020/5/11.
//  Copyright © 2020 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern BOOL SCBool(id value, BOOL defaultValue);
extern NSInteger SCInteger(id value, NSInteger defaultValue);
extern double SCDouble(id value, double defaultValue);
extern NSString * SCString(id value, NSString * _Nullable defaultValue);
extern NSArray * SCArray(id value, NSArray * _Nullable defaultValue);
extern NSDictionary * SCDictionary(id value, NSDictionary * _Nullable defaultValue);

extern NSString * SCAppLink(id _Nullable linkModel);

NS_ASSUME_NONNULL_END
