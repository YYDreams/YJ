//
//  RMBaseGoodsModel.m
//  RMDart
//
//  Created by flowerflower on 2018/6/13.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "RMBaseGoodsModel.h"

@implementation RMBaseGoodsModel

- (NSString *)price{
    
    return [NSString stringWithFormat:@"%.2f",[_price doubleValue]];
    
}

- (NSString *)originalPrice{
    
    return [NSString stringWithFormat:@"%.2f",[_originalPrice doubleValue]];

    
}



@end
