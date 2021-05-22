//
//  Foundation+SCCategory.m
//  SamClub
//
//  Created by zoyagzhou on 2019/12/19.
//  Copyright © 2019 tencent. All rights reserved.
//

#import "Foundation+SCCategory.h"

@implementation NSArray (SCCategory)
//安全使用数组
-(id)safeObjectAtIndex:(NSUInteger)index
{
    if ([self isKindOfClass:[NSArray class]])
    {
        if (self.count)
        {
            if (self.count>index)
            {
                return self[index];
            }
        }
    }
    
    return nil;
}
@end

@implementation NSMutableArray (SCCategory)

- (void)sc_addObject:(id)anObject
{
    if (anObject) {
        [self addObject:anObject];
    }
    else {
    }
}

- (void)sc_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject) {
        if (index > [self count]) {
            index = [self count];
        }
        [self insertObject:anObject atIndex:index];
    }
    else {
    }
}

- (void)sc_removeObjectAtIndex:(NSUInteger)index
{
    if (index < [self count]) {
        [self removeObjectAtIndex:index];
    }
    else {
    }
}

@end

@implementation NSDictionary (SCCategory)

// 读取本地JSON文件
+ (NSDictionary *)readLocalFileWithName:(NSString *)name {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    
    return [NSJSONSerialization JSONObjectWithData:[[NSData alloc] initWithContentsOfFile:path] options:kNilOptions error:nil];
}
@end
