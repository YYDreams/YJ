//
//  HHSharedStorage.h
//  SamClub
//
//  Created by huahua on 2019/12/16.
//  Copyright © 2019 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHKeyValueStorage.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHSharedStorage : NSObject

SC_SINGLETON_DEF

@property (nonatomic, assign) int serverType;

@end

NS_ASSUME_NONNULL_END
