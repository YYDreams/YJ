//
//  MineModel.h
//  YJ
//
//  Created by flowerflower on 2021/5/23.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,MineCellType){
    MineCellTypePush,//语音推送
    MineCellTypeVersion,//版本管理
    MineCellTypeWork //上班
};
    
@interface MineModel : BaseModel

@property(nonatomic ,assign)MineCellType cellType;

@property(nonatomic ,copy)NSString *title;
    
@property(nonatomic ,copy)NSString *subTitle;

@property(nonatomic ,assign)BOOL selected;

@property(nonatomic ,assign)BOOL switchHidden;

@end

NS_ASSUME_NONNULL_END
