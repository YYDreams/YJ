//
//  HHActionSheetAction.h
//  YJ
//
//  Created by flowerflower on 2021/5/31.


#import <Foundation/Foundation.h>
#import "HHActionSheetView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHActionSheetAction : NSObject
@property (nonatomic, copy, readonly) NSString * title;
@property (nonatomic, assign, readonly) HHActionSheetViewTitleAlignment alignment;

+ (HHActionSheetAction *)actionWithTitle:(NSString *)title
                               handler:(void(^)(HHActionSheetAction * action))handler;

+ (HHActionSheetAction *)actionWithCenterTitle:(NSString *)title
                                 handler:(void(^)(HHActionSheetAction * action))handler;
@end


NS_ASSUME_NONNULL_END
