//
//  SCDeveloperTableViewCell.h
//  SamClub
//
//  Created by Hua-cloud on 2020/1/3.
//  Copyright © 2020 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCDeveloperTableViewCell : UITableViewCell

@property (nonatomic,copy) NSString *textT;
@property (nonatomic,assign) BOOL isSel;
@property (nonatomic,assign) BOOL isHaveSelView;
@property (nonatomic,copy) NSString *desText;

@end

NS_ASSUME_NONNULL_END
