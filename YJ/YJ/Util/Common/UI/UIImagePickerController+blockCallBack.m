//
//  UIImagePickerController+blockCallBack.m
//  CloudProcurement
//
//  Created by shayne on 2019/1/8.
//  Copyright © 2019 TsunamiLi. All rights reserved.
//

#import "UIImagePickerController+blockCallBack.h"
#import <objc/runtime.h>
@implementation UIImagePickerController (blockCallBack)

- (void)setMediaInfoCallBack:(imagePickerCallback)callBack{
    self.delegate = self;
    objc_setAssociatedObject(self, @selector(setMediaInfoCallBack:), callBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    if (objc_getAssociatedObject(self, @selector(setMediaInfoCallBack:))) {
        imagePickerCallback callBack = objc_getAssociatedObject(self, @selector(setMediaInfoCallBack:));
        if(callBack(info,NO)){
            if(picker.presentingViewController){
                [picker dismissViewControllerAnimated:YES completion:nil];
            }else{
                [picker popViewControllerAnimated:YES];
            }
        }
    }
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (objc_getAssociatedObject(self, @selector(setMediaInfoCallBack:))) {
        imagePickerCallback callBack = objc_getAssociatedObject(self, @selector(setMediaInfoCallBack:));
        if(callBack(nil,YES)){
            if(picker.presentingViewController){
                [picker dismissViewControllerAnimated:YES completion:nil];
            }else{
                [picker popViewControllerAnimated:YES];
            }
        }
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([UIDevice currentDevice].systemVersion.floatValue < 11) {
        return;
    }
    if ([viewController isKindOfClass:NSClassFromString(@"PUPhotoPickerHostViewController")]) {
        [viewController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.frame.size.width < 42) {
                [viewController.view sendSubviewToBack:obj];
                *stop = YES;
            }
        }];
    }
}


@end
