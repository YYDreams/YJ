//
//  UserCenterViewController.m
//  YJ
//
//  Created by flowerflower on 2021/5/23.
//

#import "UserCenterViewController.h"
#import "UserCenterCell.h"
#import "UserCenterHeaderView.h"
#import "HHToastAlertView.h"
#import "LoginViewController.h"
@interface UserCenterViewController ()


@property(nonatomic,strong)NSArray *dataArr;

@property(nonatomic,assign)NSInteger receiveCall; //是否接收语音推送 0-不接收 1-接收


@property(nonatomic,assign)NSInteger workState;  //工作状态 0-休息中 1-工作中




@end
static NSString * const UserCenterCellID = @"UserCenterCellID";
static NSString * const UserCenterHeaderID = @"UserCenterHeaderID";

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    [self getUserInfo];
    [self setupInit];
}

- (void)getUserInfo{
    [HTTPRequest GET:kGetAndroidMahjongHallWaiterInfoUrl parameter:nil success:^(id resposeObject) {
       
        if (Success) {
            UserInfoModel *model = [[UserInfoModel alloc]initWithDictionary:resposeObject[@"body"][@"data"]];
            [YJLoginManager sharedInstance].model = model;
            [[YJLoginManager sharedInstance] saveUserModel];
            [self.tableView reloadData];

        }else{
            [HHHudManager showTipMessageInWindow:resposeObject[@"msg"]?:@""];
            
        }
        
    } failure:^(NSError *error) {
       
    }];
}
- (void)updateMahjongHallWaiter{

//    receiveCall 是否接收语音推送 0-不接收 1-接收
//    workState 工作状态 0-休息中 1-工作中    
    [HTTPRequest PUT:kUpdateMahjongHallWaiterUrl parameter:@{@"receiveCall":@(self.receiveCall),@"workState":@(self.workState)} success:^(id resposeObject) {
       
        if (Success) {
            [self getUserInfo];
        }
        
        [HHHudManager showTipMessageInWindow:resposeObject[@"msg"]?:@"更新失败"];
        
    } failure:^(NSError *error) {
        [HHHudManager showTipMessageInWindow:@"更新失败"];
    }];
    
}

- (void)setupInit{
    self.tableView.rowHeight = 55;
    [self.tableView registerNib:[UINib nibWithNibName:@"UserCenterCell" bundle:nil] forCellReuseIdentifier:UserCenterCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"UserCenterHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:UserCenterHeaderID];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:UserCenterCellID forIndexPath:indexPath];
    MineModel *model = [self.dataArr safeObjectAtIndex:indexPath.row];
    cell.model = model;
    WeakSelf;
    cell.handerSwitchBlock = ^(BOOL isSeleted) {
        if (model.cellType == MineCellTypePush) {
            weakSelf.receiveCall = isSeleted;
            [weakSelf updateMahjongHallWaiter];
            
        }else{
            weakSelf.workState = isSeleted;
            [weakSelf updateMahjongHallWaiter];
        }
    };
    return  cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UserCenterHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:UserCenterHeaderID];
    headerView.backgroundColor = [UIColor clearColor];
    headerView.titleLabel.text = [YJLoginManager sharedInstance].model.name;
    headerView.subTitle.text = [YJLoginManager sharedInstance].model.mobile;
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 65)];
    footerView.backgroundColor = kBgColor;
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"退出" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitleColor:[UIColor colorWithHex:0xF75B5B] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.left.right.mas_equalTo(footerView);
        make.height.mas_equalTo(45);
    }];
    return  footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  65;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  110;
}

- (void)logout{
    
    [HHToastAlertView showTitle:@"提示" content:@"确定要退出登录吗?" contentAlignment:1 buttonTitles:@[@"取消",@"确定"] buttonClickedBlock:^(NSInteger index) {
        if (index == 1) {
            [[YJLoginManager sharedInstance] doLogout];
            LoginViewController*loginVc = [[LoginViewController  alloc]init];
            loginVc.modalPresentationStyle = 0;
            [self presentViewController:loginVc animated:YES completion:nil];
        }
    }];
}
- (NSArray *)dataArr{
    if (!_dataArr) {
    NSString *version = [NSString stringWithFormat:@"v%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    NSArray *titles = @[@"语音推送",@"版本管理",@"上班"];
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0 ; i < titles.count; i++) {
        MineModel *model = [[MineModel alloc]init];
        model.title = [titles safeObjectAtIndex:i];
        model.switchHidden = (i == 1);
        model.cellType = i;
        model.subTitle = (i == 1) ? version : nil;
        if (model.cellType == MineCellTypePush) {
            model.selected = [YJLoginManager sharedInstance].model.receiveCall;
        }else if (model.cellType == MineCellTypeWork) {
            model.selected = [YJLoginManager sharedInstance].model.workState;
        }else{
            model.selected = NO;
        }
        self.receiveCall = [YJLoginManager sharedInstance].model.receiveCall;
        self.workState = [YJLoginManager sharedInstance].model.workState;
        [temp addObject:model];
       }
        _dataArr = temp.copy;
    }
    return _dataArr;
}

@end
