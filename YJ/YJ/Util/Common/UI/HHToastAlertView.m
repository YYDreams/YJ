//
//  HHToastAlertView.m
//  SamClub
//
//  Created by huahua on 2020/3/25.
//  Copyright © 2020 tencent. All rights reserved.
//

#import "HHToastAlertView.h"

// 主按钮字体颜色
#define MAIN_BUTTON_COLOR kThemeColor

// 普通按钮字体颜色
#define NORMAL_BUTTON_COLOR [UIColor colorWithHex:0x323233]

// 按钮font
#define BUTTON_FONT [UIFont systemFontOfSize:16]

// 灰色线的颜色
#define LINE_COLOR [UIColor colorWithHex:0xDCE0E4]

//title高度
static NSInteger const kTitleHeight = 56;

//按钮高度
static NSInteger const kButtonHeight = 48;

//外边距
static NSInteger const kMargin = 32;

//内边距
static NSInteger const kPadding = 24;


@interface HHToastAlertView ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) NSArray *buttonTitles;

@property (nonatomic, strong) NSArray *buttonColors;

@property (nonatomic, strong) NSArray *clickableContents;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, copy) void (^buttonClickedBlock)(NSInteger index);

@property (nonatomic, copy) void (^contentClickedBlock)(NSInteger index);

@property(nonatomic, assign) NSTextAlignment  contentAlignment;

@property (nonatomic, assign) CGFloat contentMaxHeight;

@end
@implementation HHToastAlertView


+ (instancetype)showTitle:(nullable NSString *)title
                  content:(nullable NSString *)content
       buttonClickedBlock:(nullable HandlerButtonClickBlock)buttonClickedBlock{
    
    return  [[HHToastAlertView alloc]initWithTitle:title
                                           content:content
                                  contentAlignment:NSTextAlignmentCenter
                                      buttonTitles:@[(@"i.see")]
                                      buttonColors:nil
                                  contentMaxHeight:0
                                 clickableContents:nil
                               contentClickedBlock:nil
                                buttonClickedBlock:buttonClickedBlock];
    
}

+ (instancetype)showTitle:(nullable NSString *)title
                  content:(nullable NSString *)content
              Zengcontent:(NSArray*)contentArr
       buttonClickedBlock:(nullable HandlerButtonClickBlock)buttonClickedBlock{
    
    CGFloat ju = 50;
//    if ([[[SCLanguageTool sharedInstance] getCurrentLanguage] isEqualToString:EN]) {
//        ju += 30;
//    }
    
    HHToastAlertView * sctView = [[HHToastAlertView alloc] initWithTitle:title
                                           content:content
                                  contentAlignment:NSTextAlignmentCenter
                                      buttonTitles:@[(@"i.see")]
                                      buttonColors:nil
                                  contentMaxHeight:contentArr.count*40 + ju
                                 clickableContents:nil
                               contentClickedBlock:nil
                                buttonClickedBlock:buttonClickedBlock];
    
    UIView* backView = [[UIView alloc] initWithFrame:CGRectMake(0, ju, kSizeW([[UIApplication sharedApplication] keyWindow])-kMargin*2-SC_DP_375(kPadding)*2, contentArr.count*40)];
    backView.backgroundColor = [UIColor clearColor];
    [sctView.contentLabel.superview addSubview:backView];
    
    for (int i = 0; i<contentArr.count; i++) {
        UILabel* la = [[UILabel alloc] initWithFrame:CGRectMake(0, 9+40*i, 28, 15)];
        la.backgroundColor = [UIColor colorWithHex:0xDBEFFF];
        la.text = [NSString stringWithFormat:@"%@",(@"giveAway")];
        la.font = [UIFont systemFontOfSize:10];
        la.textAlignment = NSTextAlignmentCenter;
        [la sizeToFit];
        la.frame = CGRectMake(0, 9+40*i, kSizeW(la)+10, 15);
        [backView addSubview:la];
        
        UILabel* la2 = [[UILabel alloc] initWithFrame:CGRectMake(kSizeW(la)+4, 9+40*i, kSizeW(backView)-kSizeW(la)-8, 40)];
        la2.backgroundColor = [UIColor clearColor];
        la2.text = contentArr[i];
        la2.numberOfLines = 2;
        la2.lineBreakMode = NSLineBreakByCharWrapping;
        la2.font = [UIFont systemFontOfSize:10];
        [la2 sizeToFit];
        [backView addSubview:la2];
        
        if(i!=0){
            UIView* lineview = [[UIView alloc] initWithFrame:CGRectMake(0, 40*i, kSizeW(backView), 0.5)];
            lineview.backgroundColor = [UIColor colorWithHex:0xDCE0E4];
            [backView addSubview:lineview];
        }
    }
    
    
    return sctView;
}

+ (instancetype)showTitle:(nullable NSString *)title
                  content:(nullable NSString *)content
         contentAlignment:(NSTextAlignment)contentAlignment
             buttonTitles:(nullable NSArray <NSString *> *)buttonTitles
       buttonClickedBlock:(nullable HandlerButtonClickBlock)buttonClickedBlock{
    
    return  [[HHToastAlertView alloc]initWithTitle:title
                                           content:content
                                  contentAlignment:contentAlignment
                                      buttonTitles:buttonTitles
                                      buttonColors:nil
                                  contentMaxHeight:0
                                 clickableContents:nil
                               contentClickedBlock:nil
                                buttonClickedBlock:buttonClickedBlock];
    
}

+ (instancetype)showTitle:(nullable NSString *)title
                  content:(nullable NSString *)content
         contentAlignment:(NSTextAlignment)contentAlignment
             buttonTitles:(nullable NSArray <NSString *> *)buttonTitles
             buttonColors:(nullable NSArray <UIColor *> *)buttonColors
       buttonClickedBlock:(nullable HandlerButtonClickBlock)buttonClickedBlock{
    
    return  [[HHToastAlertView alloc]initWithTitle:title
                                           content:content
                                  contentAlignment:contentAlignment
                                      buttonTitles:buttonTitles
                                      buttonColors:buttonColors
                                  contentMaxHeight:0
                                 clickableContents:nil
                               contentClickedBlock:nil
                                buttonClickedBlock:buttonClickedBlock];
    
}

+ (instancetype)showTitle:(nullable NSString *)title
                  content:(nullable NSString *)content
         contentAlignment:(NSTextAlignment)contentAlignment
             buttonTitles:(nullable NSArray <NSString *> *)buttonTitles
             buttonColors:(nullable NSArray <UIColor *> *)buttonColors
         contentMaxHeight:(CGFloat)contentMaxHeight
       buttonClickedBlock:(nullable HandlerButtonClickBlock)buttonClickedBlock{
    
    return  [[HHToastAlertView alloc]initWithTitle:title
                                           content:content
                                  contentAlignment:contentAlignment
                                      buttonTitles:buttonTitles
                                      buttonColors:buttonColors
                                  contentMaxHeight:contentMaxHeight
                                 clickableContents:nil
                               contentClickedBlock:nil
                                buttonClickedBlock:buttonClickedBlock];
    
}
+ (instancetype)showTitle:(nullable NSString *)title
                  content:(nullable NSString *)content
         contentAlignment:(NSTextAlignment)contentAlignment
             buttonTitles:(nullable NSArray<NSString *> *)buttonTitles
         contentMaxHeight:(CGFloat)contentMaxHeight
        clickableContents:(NSArray <NSString *> *)clickableContents
      contentClickedBlock:(nullable HandlerContentClickBlock)contentClickedBlock
       buttonClickedBlock:(nullable HandlerButtonClickBlock)buttonClickedBlock{
    return  [[HHToastAlertView alloc]initWithTitle:title
                                           content:content
                                  contentAlignment:contentAlignment
                                      buttonTitles:buttonTitles
                                      buttonColors:nil
                                  contentMaxHeight:contentMaxHeight
                                 clickableContents:clickableContents
                               contentClickedBlock:contentClickedBlock
                                buttonClickedBlock:buttonClickedBlock];
    
}
- (instancetype)initWithTitle:(nullable NSString *)title
                      content:(nullable NSString *)content
             contentAlignment:(NSTextAlignment)contentAlignment
                 buttonTitles:(nullable NSArray <NSString *> *)buttonTitles
                 buttonColors:(nullable NSArray <UIColor *> *)buttonColors
             contentMaxHeight:(CGFloat)contentMaxHeight
            clickableContents:(nullable NSArray <NSString *> *)clickableContents
          contentClickedBlock:(nullable HandlerContentClickBlock)contentClickedBlock
           buttonClickedBlock:(nullable HandlerButtonClickBlock)buttonClickedBlock{
    
    
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        
        __block BOOL has = NO;
        
        [window.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:self.class]) {
                has = YES;
            }
        }];
        if (has) {
            return nil;
            
        }
        
        _title = title;
        _content = content;
        _contentAlignment = contentAlignment;
        _buttonTitles = buttonTitles;
        _buttonColors = buttonColors;
        _contentMaxHeight = contentMaxHeight;
        _clickableContents = clickableContents;
        _buttonClickedBlock = [buttonClickedBlock copy];
        _contentClickedBlock = [contentClickedBlock copy];
        [self setupSubView];
        
    }
    
    return self;
    
}

- (void)setupSubView{
    
    CGFloat margin = SC_DP_375(kMargin * 2 + kPadding * 2);
    
    CGFloat titleHeight = !kStringIsEmpty(_title) ? (kStringIsEmpty(_content) ? SC_DP_375(68) : SC_DP_375(kTitleHeight)): 0;
    
    CGSize maxSize = CGSizeMake(kScreenWidth - margin, _contentMaxHeight>0?_contentMaxHeight:MAXFLOAT);
    
    CGFloat contentHeight =  [_content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    
    CGFloat defalutContentHeight  = kScreenHeight  - kTabBarHeight - kNavHeight - titleHeight - SC_DP_375(48);
    if (contentHeight > defalutContentHeight) {
        
        self.contentMaxHeight = defalutContentHeight;
        
    }
    CGFloat contentBottom = !kStringIsEmpty(_content)?SC_DP_375(kPadding): 0;
    
    CGFloat alertrViewHeight = titleHeight + (self.contentMaxHeight > 0 ? self.contentMaxHeight : contentHeight) + contentBottom + SC_DP_375(kButtonHeight);
    
    [self showContentHeight:alertrViewHeight];
    
    //title
    if (!kStringIsEmpty(_title)) {
        
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.text = (_title);
        
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(!kStringIsEmpty(_content)?SC_DP_375(kTitleHeight): SC_DP_375(68));
            make.left.mas_offset(12);
            make.right.mas_offset(-12);
            make.top.mas_equalTo(0);
        }];
        
    }
    
    //scrollView
    [self.contentView addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(SC_DP_375(kPadding));
        make.right.mas_equalTo(self.contentView).mas_offset(SC_DP_375(-kPadding));
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        if (self.contentMaxHeight> 0) {
            make.height.mas_equalTo(self.contentMaxHeight);
        }else{
            make.height.mas_equalTo(contentHeight);
        }
        
    }];
    if (self.contentMaxHeight > 0 ) {
        self.scrollView.scrollEnabled = YES;
        self.scrollView.contentSize = CGSizeMake(0, self.contentMaxHeight);
    }else{
        self.scrollView.scrollEnabled = NO;
    }
    
    //content
    [self.scrollView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.bottom.mas_equalTo(self.scrollView);
        
    }];
    
    self.contentLabel.textAlignment = self.contentAlignment;
    
    if (kArrayIsEmpty(self.clickableContents)) {
        self.contentLabel.text = (_content);
        
    }else{
        
//        self.contentLabel.attributedText = [SCAttributedTextTool getAttributeWithAttributes:self.clickableContents totalString:_content orginFont:14 orginColor:[UIColor colorWithHex:0x4F5356] attributeFont:14 attributeColor:[UIColor colorWithHex:0x0165B8]];
//        @weakify(self);
//        [self.contentLabel sc_addAttributeTapActionWithStrings:self.clickableContents tapClicked:^(UILabel * _Nonnull label, NSString * _Nonnull string, NSRange range, NSInteger index) {
//            @strongify(self);
//            if (self.contentClickedBlock) {
//                self.contentClickedBlock(index);
//                [self hide];
//
//            }
//        }];
    }
    
    //line
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    lineView.backgroundColor = LINE_COLOR;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.scrollView.mas_bottom).mas_offset(!kStringIsEmpty(_content)?SC_DP_375(kPadding): 0);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(1);
    }];
    
    //buttons
    if (kArrayIsEmpty(self.buttonTitles)) {
        NSLog(@"弹窗按钮数量不能为0");
        return;
    }
    if (self.buttonTitles.count == 1){
        UIButton *btn = [[UIButton alloc]init];
        
        [btn setTitle:([self.buttonTitles safeObjectAtIndex:0])?:(@"i.see") forState:UIControlStateNormal];
        btn.tag = 0;
        [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:BUTTON_FONT];
        [btn setTitleColor:MAIN_BUTTON_COLOR forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lineView.mas_bottom);
            make.height.mas_equalTo(SC_DP_375(kButtonHeight));
            make.left.right.mas_equalTo(self.contentView);
            
        }];
    }else if (self.buttonTitles.count >= 2){
        
        if (self.buttonTitles.count > 2) {
            NSLog(@"弹窗按钮数量大于2，则默认取前2个");
        }
        NSInteger count = (self.buttonTitles.count > 2 ? 2 : self.buttonTitles.count);
        NSMutableArray *btns = [NSMutableArray array];
        for (int i = 0; i < count; i++) {
            UIButton *btn = [[UIButton alloc]init];
            btn.tag = i;
            [btn setTitle:(self.buttonTitles[i]) forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btns addObject:btn];
            [self.contentView addSubview:btn];
            if (i == (count - 1)) {
                // 最右边的按钮
                [btn.titleLabel setFont:BUTTON_FONT];
                [btn setTitleColor:MAIN_BUTTON_COLOR forState:UIControlStateNormal];
            } else {
                [btn.titleLabel setFont:BUTTON_FONT];
                [btn setTitleColor:NORMAL_BUTTON_COLOR forState:UIControlStateNormal];
                // 添加灰色竖线
                UIView *lineView1 = [[UIView alloc] init];
                [btn addSubview:lineView1];
                lineView1.backgroundColor = LINE_COLOR;
                [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.mas_equalTo(btn);
                    make.width.mas_equalTo(0.5);
                    make.right.mas_offset(-0.5);
                }];
            }
            if (!kArrayIsEmpty(self.buttonColors)) {
                [btn setTitleColor:self.buttonColors[i] forState:UIControlStateNormal];
                
            }
        }
        [btns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
        [btns mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kButtonHeight);
            make.bottom.mas_offset(0);
        }];
    }
}

#pragma mark – Action Method

- (void)buttonClicked:(UIButton *)sender {
    !self.buttonClickedBlock ?: self.buttonClickedBlock(sender.tag);
    [self removeFromSuperview];
}

- (void)hide {
    
    self.backgroundColor = [UIColor clearColor];
    [self removeFromSuperview];
    
}
#pragma mark – Private Methods
- (void)showContentHeight:(CGFloat)contentHeight{
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.contentView];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(self);
            make.left.mas_equalTo(kMargin);
            make.right.mas_equalTo(-kMargin);
            make.height.mas_equalTo(contentHeight);
        }];
    }];
}

#pragma mark - getter Methods
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithHex:0x222427];
    }
    return _titleLabel;
}
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor colorWithHex:0x4F5356];
        _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = LINE_COLOR;
    }
    return _lineView;
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
    }
    return _scrollView;
}

#pragma mark – dealloc
- (void)dealloc{
    
    NSLog(@"-HHToastAlertView dealloc-");
}

@end
