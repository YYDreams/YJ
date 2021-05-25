//
//  UserCenterCell.m
//  YJ
//
//  Created by flowerflower on 2021/5/23.
//

#import "UserCenterCell.h"

@implementation UserCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.yjSwitch.onTintColor = kThemeColor;
}

- (void)setModel:(MineModel *)model{
    _model = model;
    NSLog(@"setModel:%d,",model.selected);
    self.titleLabel.text = model.title;
    self.subTitleLabel.text = model.subTitle;
    self.yjSwitch.hidden = model.switchHidden;
    self.yjSwitch.on = model.selected;
}

- (IBAction)switchOnClick:(UISwitch *)sender {
    sender.selected = !sender.selected;
    self.model.selected = sender.selected;
    
    if (self.handerSwitchBlock) {
        self.handerSwitchBlock(self.model.selected);
    }
    
}



@end
