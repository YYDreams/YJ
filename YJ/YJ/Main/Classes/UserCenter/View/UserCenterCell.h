//
//  UserCenterCell.h
//  YJ
//
//  Created by flowerflower on 2021/5/23.
//

#import "BaseCell.h"
#import "MineModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserCenterCell : BaseCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *yjSwitch;


@property(strong, nonatomic)MineModel *model;

@property(copy, nonatomic)void(^handerSwitchBlock)(BOOL isSeleted);
@end

NS_ASSUME_NONNULL_END
