//
//  YJJSONModel.m
//  YJ
//
//  Created by flowerflower on 2021/5/23.
//

#import "YJJSONModel.h"

@implementation YJJSONModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    NSString *className = NSStringFromClass([self class]);
    NSError *error = nil;
    self = [self initWithDictionary:dict error:&error];
    if (error) {
        NSLog(@"create %@ failed.\nerror: %@\ndict: %@",
                   className, error, dict);
        return nil;
    }
    return self;
}


@end
