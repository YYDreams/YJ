////
//  HHActionSheetAction.m
//  YJ
//
//  Created by flowerflower on 2021/5/31.


#import "HHActionSheetAction.h"

@interface HHActionSheetAction()
@property (nonatomic, assign, readwrite) HHActionSheetViewTitleAlignment alignment;
@property (nonatomic, copy, readwrite) NSString * title;
@property (nonatomic, copy) void(^handler)(HHActionSheetAction * action);

+ (HHActionSheetAction *)actionWithTitle:(NSString *)title
                                 handler:(void(^)(HHActionSheetAction * action))handler;
@end

@implementation HHActionSheetAction

+ (HHActionSheetAction *)actionWithTitle:(NSString *)title handler:(void(^)(HHActionSheetAction * action))handler{
    HHActionSheetAction *  action = [HHActionSheetAction new];
    action.title = title;
    action.handler = handler;
    action.alignment = HHActionSheetViewTitleAlignMentBottom;
    return action;
}

+ (HHActionSheetAction *)actionWithCenterTitle:(NSString *)title handler:(void (^)(HHActionSheetAction * _Nonnull))handler{
    HHActionSheetAction *  action = [HHActionSheetAction new];
    action.title = title;
    action.handler = handler;
    action.alignment = HHActionSheetViewTitleAlignMentCenter;
    return action;
}

- (void)responseAction{
    if (self.handler) {
        self.handler(self);
    }
}
@end
