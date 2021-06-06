//
//  HomeModel.h
//  YJ
//
//  Created by flowerflower on 2021/5/23.
//

#import "BaseModel.h"
#import "YJJSONModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeModel : BaseModel
@property (nonatomic , copy) NSString              * id; //呼叫录音id
@property (nonatomic , copy) NSString              * createDate;
@property (nonatomic , copy) NSString              * updateDate;
@property (nonatomic , copy) NSString              * openid;
@property (nonatomic , strong) NSArray              * mahjongHallRoom;
@property (nonatomic , copy) NSString              * mahjongHallRoomQrcode;
@property (nonatomic , copy) NSString              * voicePath; //呼叫录音url
@property (nonatomic , assign) NSInteger              state; //1-待处理 2-已处理 3-处理中
@property (nonatomic , assign) NSInteger              duration; //呼叫录音时长 单位：秒
@property (nonatomic , copy) NSString              * hallName; //棋牌室名称
@property (nonatomic , copy) NSString              * hallRoomName; //棋牌室房间名称

@end

NS_ASSUME_NONNULL_END
