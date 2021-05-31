//
//  HHActionSheetController.m
//  YJ
//
//  Created by flowerflower on 2021/5/31.
//

#import "HHActionSheetController.h"
#import "HHActionSheetView.h"

@interface HHActionSheetController ()
@property (nonatomic, strong) UIView * maskView;
@property (nonatomic, strong) UIView * containerView;
@property (nonatomic, strong) UIStackView * actionsView;
@property (nonatomic, strong) UIButton * cancelButton;
@property (nonatomic, strong) NSMutableArray<HHActionSheetAction *> * mutiActions;
@end

@implementation HHActionSheetController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self show];
}

- (void)setupView{
    self.view.backgroundColor = [UIColor clearColor];
    UIView * backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0.f);
        make.bottom.equalTo(@(-10));
        make.height.equalTo(@(30));
    }];
    
    
    UIView * graySpaceView = [UIView new];
    graySpaceView.backgroundColor = [UIColor colorWithHex:0xF0F2F4];
    
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.actionsView];
    [self.containerView addSubview:graySpaceView];
    [self.containerView addSubview:self.cancelButton];
    
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_offset(0.f);
    }];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0.f);
        make.top.equalTo(self.maskView.mas_bottom);
       
    }];
    
    [self.actionsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_offset(0.f);
        make.bottom.equalTo(graySpaceView.mas_top);
    }];
    
    [graySpaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.actionsView.mas_bottom);
        make.left.right.mas_offset(0.f);
        make.height.mas_equalTo(12.f);
        make.bottom.equalTo(self.cancelButton.mas_top);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(graySpaceView.mas_bottom);
        make.left.right.mas_offset(0.f);
        make.height.mas_equalTo(50.f);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_offset(- [[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom);
        } else {
            make.bottom.mas_offset(0.f);
        }
    }];
}

- (void)addAction:(HHActionSheetAction *)action
{
    [self.mutiActions addObject:action];
    HHActionSheetView * view = [[HHActionSheetView alloc] initWithAlignment:action.alignment];
    view.title.text = action.title;
    [view setTapHandler:^{
        [self dismissWithCompletion:^{
            #pragma GCC diagnostic ignored "-Wundeclared-selector"
            if ([action respondsToSelector:@selector(responseAction)]) {
                [action performSelector:@selector(responseAction)];
            }
        }];
    }];
    [self.actionsView addArrangedSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50.f);
    }];
    if (self.mutiActions.count != 0) {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithHex:0xDCE0E4];
        [view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.right.top.equalTo(view);
        }];
    }
}

- (void)show{
    [self.maskView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-self.containerView.height);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}


- (void)dismissWithCompletion:(void (^ __nullable)(void))completion{
    [self.maskView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:completion];
    }];
}

- (void)dismiss{
    [self.maskView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}


#pragma mark - getterMethod
- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [UIView new];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    }
    return _maskView;
}

- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [UIView new];
    }
    return _containerView;
}

- (UIStackView *)actionsView{
    if (!_actionsView) {
        _actionsView = [UIStackView new];
        _actionsView.axis = UILayoutConstraintAxisVertical;
        _actionsView.distribution = UIStackViewDistributionFill;
        _actionsView.alignment = UIStackViewAlignmentFill;
    }
    return _actionsView;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_cancelButton setTintColor:[UIColor colorWithHex:0x222427]];
        [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setBackgroundColor:[UIColor whiteColor]];
        [_cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (NSMutableArray<HHActionSheetAction *> *)mutiActions{
    if (!_mutiActions) {
        _mutiActions = @[].mutableCopy;
    }
    return _mutiActions;
}

- (NSMutableArray<HHActionSheetAction *> *)actions{
    return self.mutiActions.copy;
}
@end
