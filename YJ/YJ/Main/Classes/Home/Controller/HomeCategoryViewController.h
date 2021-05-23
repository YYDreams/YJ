//
//  HomeCategoryViewController.h
//  YJ
//
//  Created by flowerflower on 2021/5/23.
//

#import <UIKit/UIKit.h>
#import "JXCategoryView.h"
#import <JXPagerView.h>
#import "JXCategoryTitleView.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeCategoryViewController : UIViewController
@property (nonatomic, assign) NSInteger selectedIndex;

- (instancetype)initWithSelectedIndex:(NSInteger)Index;
@end

NS_ASSUME_NONNULL_END
