//
//  HomeViewController.m
//  YJ
//
//  Created by flowerflower on 2021/5/22.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "HomeModel.h"
#import "HHRefreshFactory.h"
#import <AVFoundation/AVFoundation.h>
#import "YJPlayMager.h"

static NSString * const HomeCellID = @"HomeCellID";

@interface HomeViewController ()

@property(nonatomic, strong)NSMutableArray *dataArr;

@property (nonatomic, strong) YJPlayMager *play;

@property (nonatomic, copy) NSString *currentPlayUrl;

@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, assign) NSInteger currentDuration;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.audioPlayer = [[AVAudioPlayer alloc]init];
    [self setupSubView];
    [self setupRefresh];
    
    
}
- (void)setupRefresh{
    
    [self setupRefreshTarget:self.tableView With:HHRefreshTypeHeader];
    
    [self loadDataFromNetworkWithPage:1 andStatu:3];
    
}

- (void)loadDataFromNetworkWithPage:(int)pageNum andStatu:(int)status{
    
    [HHHudManager showActivityMessageInView:@""];
    [self.dataArr removeAllObjects];
    WeakSelf;
    [HTTPRequest POST:kVoicesListUrl parameter:@{@"state":@(self.type)} success:^(id resposeObject) {
        [HHHudManager hideHUD];
        
        NSArray *data = resposeObject[@"body"][@"data"];
        
        if (Success && ![data isKindOfClass:[NSNull class]]) {
            self.dataArr = [HomeModel mj_objectArrayWithKeyValuesArray:data];
            
            [self.tableView reloadData];
            [weakSelf successEndRefreshStatus:status totalPage:1];
            
        }else{
            [weakSelf failEndRefreshStatus:status];
            
            [HHHudManager showTipMessageInWindow:resposeObject[@"msg"]?:@"获取失败"];
        }
        if(kArrayIsEmpty(data)){
            self.currentPageStatus = PageStatusSucceed;
        }
        
        
        
    } failure:^(NSError *error) {
        [HHHudManager hideHUD];
        self.currentPageStatus = PageStatusError;
        self.emptyViewTapBlock = ^{
            [weakSelf pullDownRefresh:1];
        };
    }];
    
}
- (void)pullDownRefresh:(int)page{
    
    [self.dataArr  removeAllObjects];
    //0 结束头部
    [self loadDataFromNetworkWithPage:page andStatu:0];
}

- (void)setupSubView{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:HomeCellID];
    self.tableView.backgroundColor = [UIColor colorWithHex:0xF9F9F9];
    //        _tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = 160;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.equalTo(self.view);
        }
        
    }];
}

#pragma mark - JXPagingViewListViewDelegate
- (UIView *)listView {
    return self.view;
}

- (UIScrollView *)listScrollView {
    return self.tableView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    //    self.scrollCallback = callback;
}

- (void)listWillAppear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}

- (void)listDidAppear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}

- (void)listWillDisappear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}

- (void)listDidDisappear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeCellID forIndexPath:indexPath];
    HomeModel *model  = [self.dataArr safeObjectAtIndex:indexPath.row];
    
    
    cell.model = model;
    
    WeakSelf;
    cell.handlerDoneCallBlock = ^{
        [weakSelf loadDataCompleteCallWithUrlString:kCompleteCallUrl ID:model.ID];
        
    };
    
    cell.handlerPlayBlock = ^() {
        [weakSelf handerPlayWithModel:model indexPath:indexPath];
    };
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeModel *model  = [self.dataArr safeObjectAtIndex:indexPath.row];
    [self handerPlayWithModel:model indexPath:indexPath];
}

- (void)handerPlayWithModel:(HomeModel *)model indexPath:(NSIndexPath *)indexPath{
    WeakSelf;
    weakSelf.currentDuration = model.duration;
    [weakSelf playWithUrl:model.voicePath state: model.state ID:model.ID];
    HomeCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell.imgView startAnimating];
    if (model.duration > 0 ) {
        NSTimer *timer  =  [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(numberCutDown:) userInfo:@(indexPath.row) repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}

-(void)numberCutDown:(NSTimer *)timer{
        
    //取出对应倒计时
    NSString * indexInteger = timer.userInfo;
    NSInteger index = [indexInteger integerValue];
    
    HomeModel *model = [self.dataArr safeObjectAtIndex:index];
    
    //修改模型时间
    model.duration --;
    //刷新界面
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    HomeCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    if (model.duration == 0)
    {
        [cell.imgView stopAnimating];
        model.duration = self.currentDuration;
        NSLog(@"第%ld行的",model.duration);
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        NSLog(@"第%ld行的定时器销毁了",index);
        [timer invalidate];
        timer = nil;
        return;
    }else{
        
    }
    
    
}
- (void)playWithUrl:(NSString *)url  state:(NSInteger)state ID:(NSString *)ID{
    WeakSelf;
    self.currentPlayUrl = url;
    YJPlayMager *audioPlayer =    [[YJPlayMager sharedInstance]initWithURL:[NSURL URLWithString:url relativeToURL:nil]];
    NSLog(@"audioPlayeraudioPlayer:%p %@",audioPlayer, url);
    [[YJPlayMager sharedInstance]play];
    //播放掉kResponseCallUrl
    if (state == 1) {
        [weakSelf loadDataCompleteCallWithUrlString:kResponseCallUrl ID:ID];

    }

    
}
//state == 1 ?kCompleteCallUrl : kResponseCallUrl
- (void)loadDataCompleteCallWithUrlString:(NSString *)urlString ID:(NSString *)ID{
    
    //state 1-待处理 2-已处理 3-处理中
    [HHHudManager showActivityMessageInView:@""];
    WeakSelf;
    
    [HTTPRequest PUT: urlString parameter:@{@"id":ID} success:^(id resposeObject) {
        [HHHudManager hideHUD];
        if (Success) {
            [weakSelf loadDataFromNetworkWithPage:1 andStatu:3];
        }
        [HHHudManager showTipMessageInWindow:resposeObject[@"msg"]?:@"获取失败"];
    } failure:^(NSError *error) {
        [HHHudManager hideHUD];
        [HHHudManager showActivityMessageInView:@"请求失败"];
        
    }];
    
}
- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"************ dealloc ***************");
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


@end
