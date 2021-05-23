//
//  SCDeveloperHFView.m
//  SamClub
//
//  Created by Hua-cloud on 2020/1/3.
//  Copyright © 2020 tencent. All rights reserved.
//

#import "SCDeveloperHFView.h"

@implementation SCDeveloperHFView {
    UILabel *_label;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}


- (void)createUI {
    _label = [[UILabel alloc] init];
    _label.font = [UIFont systemFontOfSize:12];
    _label.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_label];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.contentView).offset(3);
    }];
}

#pragma get/set
- (void)setTextT:(NSString *)textT {
    _textT = textT;
    _label.text = textT;
}

@end
