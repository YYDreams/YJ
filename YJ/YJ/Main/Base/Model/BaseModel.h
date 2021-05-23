//
//  BaseModel.h
//  JYShop
//
//  Created by 花花 on 2017/9/28.
//  Copyright © 2017年 花花. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
@property(nonatomic,copy) NSString *ID;  // <#注释#>
+ (instancetype)objectWithDic:(NSDictionary*)dic;

+ (NSMutableArray*)objectsInArray:(id)array;
@end
