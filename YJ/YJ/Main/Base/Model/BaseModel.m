//
//  BaseModel.m
//  JYShop
//
//  Created by 花花 on 2017/9/28.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID":@"id"};
}

+ (instancetype)objectWithDic:(NSDictionary *)dic
{
    //容错处理
    if (![dic isKindOfClass:[NSDictionary class]]||!dic)
    {
        return nil;
    }
    
    //获取子类名
    NSString * className =  [NSString stringWithUTF8String:object_getClassName(self)];
    
    return [NSClassFromString(className) mj_objectWithKeyValues:dic];
}

+ (NSMutableArray*)objectsInArray:(id)arr
{
    //获取子类名
    NSString * className =  [NSString stringWithUTF8String:object_getClassName(self)];
    
    return [NSClassFromString(className) mj_objectArrayWithKeyValuesArray:arr];
}
@end
