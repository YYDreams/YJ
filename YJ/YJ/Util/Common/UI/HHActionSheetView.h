//
//  HHActionSheetView.h
//  YJ
//
//  Created by flowerflower on 2021/5/31.


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, HHActionSheetViewTitleAlignment) {
    HHActionSheetViewTitleAlignMentCenter,
    HHActionSheetViewTitleAlignMentBottom,
};

@interface HHActionSheetView : UIView

@property (nonatomic, strong) UILabel * title;
@property (nonatomic, copy) dispatch_block_t tapHandler;

- (instancetype)initWithAlignment:(HHActionSheetViewTitleAlignment)alignment;
@end

NS_ASSUME_NONNULL_END
