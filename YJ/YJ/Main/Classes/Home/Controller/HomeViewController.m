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
        
        
        self.currentPageStatus = PageStatusSucceed;
       
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
         make.left.right.top.bottom.equalTo(self.view);
         
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
        [weakSelf loadDataCompleteCallWithID:model.ID];
    };
    cell.handlerPlayBlock = ^{
        if (self.currentPlayUrl != model.voicePath) {
            
            [[YJPlayMager sharedInstance]pause];
        }
        [weakSelf playWithUrl:model.voicePath];
      
    };
    return  cell;
}

- (void)playWithUrl:(NSString *)url{
    self.currentPlayUrl = url;
    
 YJPlayMager *audioPlayer =    [[YJPlayMager sharedInstance]initWithURL:[NSURL URLWithString:url relativeToURL:nil]];
    NSLog(@"audioPlayeraudioPlayer:%p %@",audioPlayer, url);
    [[YJPlayMager sharedInstance]play];

    
}

- (void)loadDataCompleteCallWithID:(NSString *)ID{
    
    [HHHudManager showActivityMessageInView:@""];
    WeakSelf;
    [HTTPRequest PUT:kCompleteCallUrl parameter:@{@"id":ID} success:^(id resposeObject) {
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

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


@end
