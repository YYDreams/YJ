//
//  HomeViewController.h
//  YJ
//
//  Created by flowerflower on 2021/5/22.
//

#import <UIKit/UIKit.h>
#import <JXCategoryListContainerView.h>
NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : BaseTableViewController<JXCategoryListContentViewDelegate>
@property (nonatomic, assign) NSInteger type;
@end

NS_ASSUME_NONNULL_END
