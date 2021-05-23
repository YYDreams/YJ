//
//  HomeCategoryViewController.m
//  YJ
//
//  Created by flowerflower on 2021/5/23.
//

#import "HomeCategoryViewController.h"
#import "HomeViewController.h"
@interface HomeCategoryViewController ()<UIScrollViewDelegate, JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) NSArray <NSString *> *titles;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;


@end

@implementation HomeCategoryViewController

- (instancetype)initWithSelectedIndex:(NSInteger)Index
{
    self = [super init];
    if (self) {
        self.selectedIndex = Index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    self.navigationItem.title =  [YJLoginManager sharedInstance].model.mahjongHall.name;
//    UIButton * logoutBtn= [[UIButton alloc]init];
//        logoutBtn.backgroundColor = [UIColor redColor];
//        [logoutBtn setTitle:@"注销" forState:UIControlStateNormal];
//        [logoutBtn setBackgroundColor:[UIColor redColor]];
//        logoutBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    logoutBtn.layer.masksToBounds = true;
//    logoutBtn.layer.cornerRadius = 15;
//    logoutBtn.width = 60;
//        [logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:logoutBtn];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    //处于第一个item的时候，才允许屏幕边缘手势返回
    self.navigationController.interactivePopGestureRecognizer.enabled = (_categoryView.selectedIndex == 0);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)setupView{
    JXCategoryListContainerView * listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    self.categoryView.listContainer = listContainerView;
    [self.view addSubview:listContainerView];
   
    UIView * topView = [UIView new];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView addSubview:self.categoryView];
    
    [listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0.f);
        make.height.mas_equalTo(50);
    }];
    
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topView);
        make.left.right.mas_offset(0.f);
        make.height.mas_equalTo(35.f);
    }];
}
#pragma mark - JXPagerMainTableViewGestureDelegate

- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //禁止categoryView左右滑动的时候，上下和左右都可以滚动
    if (otherGestureRecognizer == self.categoryView.collectionView.panGestureRecognizer) {
        return NO;
    }
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


#pragma mark - JXCategoryListContainerViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index
{
    HomeViewController * list = [HomeViewController new];
    if (index == 0) {
        list.type = 1;
    }else{
        list.type = 2;
    }
    return list;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView
{
    return self.categoryView.titles.count;
}


#pragma mark - getterMethod

- (JXCategoryTitleView *)categoryView{
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectZero];
        _categoryView.titles = self.titles;
        _categoryView.defaultSelectedIndex = self.selectedIndex;
        _categoryView.backgroundColor = [UIColor whiteColor];
        _categoryView.delegate = self;
        _categoryView.titleSelectedColor = [UIColor colorWithHex:0x0165B8];
        _categoryView.titleColor = [UIColor colorWithHex:0x222427];
        _categoryView.titleSelectedFont = [UIFont systemFontOfSize:14.f weight:UIFontWeightMedium];
        _categoryView.titleFont = [UIFont systemFontOfSize:14.f weight:UIFontWeightRegular];
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.averageCellSpacingEnabled = true;
        _categoryView.titles = @[@"待处理呼叫",
                                 @"已完成"];
//        _categoryView.contentEdgeInsetLeft = 24.f;
//        _categoryView.contentEdgeInsetRight = 24.f;
        _categoryView.cellSpacing = 0;
        _categoryView.contentEdgeInsetLeft = 0;
        _categoryView.contentEdgeInsetRight = 0;
        _categoryView.averageCellSpacingEnabled = NO;
        _categoryView.cellWidth = [UIScreen mainScreen].bounds.size.width/(_categoryView.titles.count);
        
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorColor = [UIColor colorWithHex:0x0165b8];
        lineView.indicatorWidth = 16.f;
        lineView.indicatorHeight = 2.f;
        lineView.indicatorCornerRadius = 0;
        _categoryView.indicators = @[lineView];
    }
    return _categoryView;
}

@end
