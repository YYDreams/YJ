//
//  HHActionSheetView.m
//  YJ
//
//  Created by flowerflower on 2021/5/31.
//

#import "HHActionSheetView.h"

@interface HHActionSheetView()
@property (nonatomic, assign) HHActionSheetViewTitleAlignment alignment;

@end

@implementation HHActionSheetView

- (instancetype)initWithAlignment:(HHActionSheetViewTitleAlignment)alignment{
    if (self = [super init]) {
        self.alignment = alignment;
        [self setupView];
    }
    return self;
}


- (void)setupView{
    self.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taped:)];
    [self addGestureRecognizer:tap];
    
    [self addSubview:self.title];
    
    if (self.alignment == HHActionSheetViewTitleAlignMentCenter) {
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.right.mas_offset(0.f);
        }];
    }else{
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.left.right.mas_offset(0.f);
        }];
    }
}

- (void)taped:(UITapGestureRecognizer *)gestureRecognizer{
    if (self.tapHandler) {
        self.tapHandler();
    }
}
#pragma mark - getterMethod

- (UILabel *)title{
    if (!_title) {
        _title = [UILabel new];
        _title.textColor = [UIColor colorWithHex:0x0165B8];
        _title.font = [UIFont systemFontOfSize:16.f];
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return _title;
}
@end
