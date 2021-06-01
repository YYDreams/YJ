//
//  UserInfoModel.h
//  YJ
//
//  Created by flowerflower on 2021/5/23.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import <JSONModel/JSONModel.h>
#import "YJJSONModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CreateBy :YJJSONModel
@property (nonatomic , assign) NSInteger              money;
@property (nonatomic , copy) NSString              * loginFlag;
@property (nonatomic , copy) NSString              * roleNames;
@property (nonatomic , assign) BOOL              admin;

@end


@interface UpdateBy :YJJSONModel
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , assign) NSInteger              money;
@property (nonatomic , copy) NSString              * loginFlag;
@property (nonatomic , copy) NSString              * roleNames;
@property (nonatomic , assign) BOOL              admin;

@end


@interface MahjongHall :YJJSONModel
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * name;

@end


@interface UserInfoModel : YJJSONModel

@property (nonatomic , copy) NSString              * remarks;
@property (nonatomic , strong) CreateBy              * createBy;
@property (nonatomic , copy) NSString              * createDate;
@property (nonatomic , strong) UpdateBy              * updateBy;
@property (nonatomic , copy) NSString              * updateDate;
@property (nonatomic , strong) MahjongHall              * mahjongHall;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , assign) NSInteger              receiveCall;
@property (nonatomic , assign) NSInteger              workState;

@end




NS_ASSUME_NONNULL_END
