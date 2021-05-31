//
//  UIImagePickerController+blockCallBack.h
//  CloudProcurement
//
//  Created by shayne on 2019/1/8.
//  Copyright © 2019 TsunamiLi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef bool(^imagePickerCallback)(NSDictionary<UIImagePickerControllerInfoKey,id> * _Nullable  info,BOOL didCaceled);
@interface UIImagePickerController (blockCallBack)<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
- (void)setMediaInfoCallBack:(imagePickerCallback)callBack;
@end

NS_ASSUME_NONNULL_END
