//
//  UserCenterHeaderView.m
//  YJ
//
//  Created by flowerflower on 2021/5/23.
//

#import "UserCenterHeaderView.h"

@implementation UserCenterHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.headImgView.layer.masksToBounds = true;
    self.headImgView.layer.cornerRadius = 45;
}

@end
