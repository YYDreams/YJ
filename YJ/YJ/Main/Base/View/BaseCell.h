//
//  BaseCell.h
//  RMDart
//
//  Created by flowerflower on 2018/4/28.
//  Copyright © 2018年 花花. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView cellID:(NSString *)cellID;

@end
