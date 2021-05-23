//
//  HomeCell.m
//  YJ
//
//  Created by flowerflower on 2021/5/22.
//

#import "HomeCell.h"

@implementation HomeCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
    self.bgView.layer.cornerRadius = 10;
    self.bgView.layer.masksToBounds = true;
    
    self.playView.backgroundColor = [UIColor colorWithHex:0x5B9AF7 alpha:0.2];
    
    
    self.playView.layer.cornerRadius = 5;
    self.playView.layer.masksToBounds = true;
   
    self.bottomBtn.layer.cornerRadius = 15;
    self.bottomBtn.layer.masksToBounds = true;
    self.bottomBtn.layer.borderWidth = 1;
    self.bottomBtn.layer.borderColor = [UIColor colorWithHex:0x5B9AF7].CGColor;
    
    
}


- (IBAction)playBtn:(id)sender {
    
    if (self.handlerPlayBlock) {
        self.handlerPlayBlock();
    }
}

- (void)setModel:(HomeModel *)model{
 
    _model = model;

    self.hallNameLabel.text = HHString(model.hallName, @"");
    self.roomLabel.text = HHString(model.hallRoomName, @"");

    NSInteger  timeout = model.duration;
    int second = timeout%60;//秒
    int minutes = (timeout/60)%60;//分钟的。
    long hour = timeout/3600;//小时
    NSString *strTime = [NSString stringWithFormat:@"%02ld:%02d:%02d",hour,minutes,second];
    self.timeLabel.text = strTime;
    
    //1-待处理 2-已处理
    if (model.state == 1) {
        self.bottomWidthConst.constant = 80;
        [self.bottomBtn setTitle:@"完成呼叫" forState:UIControlStateNormal];
        self.bottomBtn.layer.borderColor = [UIColor redColor].CGColor;
        [self.bottomBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
    }else{
        self.bottomWidthConst.constant = 70;
        [self.bottomBtn setTitle:@"已处理" forState:UIControlStateNormal];
         self.bottomBtn.layer.borderColor = [UIColor colorWithHex:0x5B9AF7].CGColor;
        [self.bottomBtn setTitleColor:[UIColor colorWithHex:0x5B9AF7] forState:UIControlStateNormal];
    }
}

- (IBAction)bottomOnClick:(UIButton *)sender {
    
    if (_model.state == 1) {
        if (self.handlerDoneCallBlock) {
            self.handlerDoneCallBlock();
        }
    }
}


@end
