//
//  SCDeveloperTableViewCell.m
//  SamClub
//
//  Created by Hua-cloud on 2020/1/3.
//  Copyright © 2020 tencent. All rights reserved.
//

#import "SCDeveloperTableViewCell.h"
@interface SCDeveloperTableViewCell()
@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UILabel *desLabel;

@end

@implementation SCDeveloperTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}


- (void)createUI {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _imgView = [[UIImageView alloc] init];
    _imgView.image = [UIImage imageNamed:@"pc_collect_unSelect"];
    [self.contentView addSubview:_imgView];
    
    _label = [[UILabel alloc] init];
    _label.font = [UIFont systemFontOfSize:14];
    _label.textColor = [UIColor blackColor];
    [self.contentView addSubview:_label];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(60);
        make.centerY.equalTo(self.contentView);
    }];
    
    _desLabel = [[UILabel alloc] init];
    _desLabel.font = [UIFont systemFontOfSize:9];
    _desLabel.numberOfLines = 2;
    _desLabel.textColor = [UIColor blackColor];
    _desLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_desLabel];
    
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-20);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(@(180));
    }];
}
#pragma get/set
- (void)setTextT:(NSString *)textT {
    _textT = textT;
    _label.text = textT;
}

- (void)setIsSel:(BOOL)isSel {
    _isSel = isSel;
    if (isSel) {
        _imgView.image = [UIImage imageNamed:@"pc_collect_Selected"];
    } else {
        _imgView.image = [UIImage imageNamed:@"pc_collect_unSelect"];
    }
}

- (void)setIsHaveSelView:(BOOL)isHaveSelView {
    _isHaveSelView = isHaveSelView;
    if (isHaveSelView) {
        [_imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.contentView);
            make.width.height.equalTo(@(21));
        }];
        [_label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(60);
            make.right.equalTo(self.contentView).offset(60);
            make.centerY.equalTo(self.contentView);
        }];
    } else {
        [_imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(0));
        }];
        [_label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(60);
            make.centerY.equalTo(self.contentView);
        }];
    }
}

- (void)setDesText:(NSString *)desText
{
    _desText = desText;
    _desLabel.text = desText;
}

@end
