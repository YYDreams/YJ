//
//  HomeCell.h
//  YJ
//
//  Created by flowerflower on 2021/5/22.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "BaseCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeCell : BaseCell
@property (weak, nonatomic) IBOutlet UILabel *hallNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *roomLabel;
@property (weak, nonatomic) IBOutlet UIView *playView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;

@property(strong , nonatomic) HomeModel *model;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomWidthConst;

//完成呼叫回调
@property(nonatomic ,copy)void(^handlerDoneCallBlock)(void);

//播放音频回调
@property(nonatomic ,copy)void(^handlerPlayBlock)(void);

@end

NS_ASSUME_NONNULL_END
