//
//  UserCenterHeaderView.h
//  YJ
//
//  Created by flowerflower on 2021/5/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserCenterHeaderView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitle;

@end

NS_ASSUME_NONNULL_END
