

//
//  BaseCell.m
//  RMDart
//
//  Created by flowerflower on 2018/4/28.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
    }
    
    
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView cellID:(NSString *)cellID{
    //获取子类名
    NSString * className =  [NSString stringWithUTF8String:object_getClassName(self)];
    
    NSString *ID = className;
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
//    NSLog(@"%@----------------",className);
    
    if (cell == nil) {
        cell = [[NSClassFromString(className)  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//        NSLog(@"++++++++++++++++++++++++");
    }
    return cell;
    
}

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.selectionStyle =  UITableViewCellSelectionStyleNone;

    
    
}


@end
