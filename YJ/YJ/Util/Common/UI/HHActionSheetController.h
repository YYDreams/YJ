//
//  HHActionSheetController.h
//  YJ
//
//  Created by flowerflower on 2021/5/31.
//

#import <UIKit/UIKit.h>
#import "HHActionSheetAction.h"
NS_ASSUME_NONNULL_BEGIN

@interface HHActionSheetController : UIViewController
@property (nonatomic, readonly, copy) NSMutableArray<HHActionSheetAction *> * actions;

- (void)addAction:(HHActionSheetAction *)action;

@end

NS_ASSUME_NONNULL_END
