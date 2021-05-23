//
//  HHAppStorage.h
//  SamClub
//
//  Created by huahua on 2019/12/16.
//  Copyright © 2019 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHKeyValueStorage.h"
#import "UserInfoModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface HHAppStorage : NSObject

SC_SINGLETON_DEF

@property (nonatomic, strong) UserInfoModel *lastUserModel;


@end

NS_ASSUME_NONNULL_END
