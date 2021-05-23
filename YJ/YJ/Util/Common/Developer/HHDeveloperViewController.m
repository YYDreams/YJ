//
//  HHDeveloperViewController.m
//  YJ
//
//  Created by flowerflower on 2021/5/23.
//

#import "HHDeveloperViewController.h"
#import "SCDeveloperTableViewCell.h"
#import "HHSharedStorage.h"
#import "SCDeveloperHFView.h"
#import "YJLoginManager.h"
#import "HHNetworkConfig.h"
@interface HHDeveloperViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSArray *_netArray;
    NSArray *_infoArray;
    NSArray *_elseArray;
    UITableView *_tableView;
}

@end
#define TAG_TVERSION  1003

@implementation HHDeveloperViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self createUI];
}

- (void)initData {
    _netArray = @[@"开发服务器",@"测试服务器",@"线上服务器"];
    _infoArray = @[@"当前服务器",@"推送Token",@"设备型号和分辨率",@"版本号"];
    _elseArray = @[@"泳道名"];
}

- (void)createUI {
    
    self.title = @"开发人员选项";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma custom

- (void)showInfo:(NSString *)info {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:info preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:(@"alert.ButtonSure") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];

        pasteboard.string = info;
    }] ;
    [controller addAction:actionConfirm];
    [self presentViewController:controller animated:YES completion:nil];
}


- (void)writeTversion {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"设置泳道" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [controller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        NSString *key = [HHDeveloperViewController getKey:TAG_TVERSION];
        NSString *tversion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        textField.placeholder = @"泳道名";
        textField.clearButtonMode=UITextFieldViewModeWhileEditing;

        if (tversion && tversion.length > 0) {
            textField.text = tversion;
        }
    }];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:(@"alert.ButtonCancel") style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:(@"alert.ButtonSure") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = controller.textFields.firstObject;
        
        NSString *textFieldText = HHString(textField.text, @"");
        NSString *key = [HHDeveloperViewController getKey:TAG_TVERSION];
        [[NSUserDefaults standardUserDefaults] setObject:textFieldText forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [_tableView reloadData];
    }] ;
    [controller addAction:actionCancel];
    [controller addAction:actionConfirm];
    [self presentViewController:controller animated:YES completion:nil];
}



#pragma  UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return _netArray.count;
        }
            break;
        case 1:
        {
            return _infoArray.count;
        }
            break;
        case 2:
        {
            return _elseArray.count;
        }
            break;
            
        default:
        {
            return 1;
        }
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *iCell = @"iCell";
    SCDeveloperTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:iCell];
    if (!cell) {
        cell = [[SCDeveloperTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iCell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    switch (indexPath.section) {
        case 0:
        {
            cell.textT = _netArray[indexPath.row];
            cell.isHaveSelView = YES;
            if (indexPath.row == [HHSharedStorage sharedInstance].serverType) {
                cell.isSel = YES;
            } else {
                cell.isSel = NO;
            }
        }
            break;
        case 1:
        {
            cell.textT = _infoArray[indexPath.row];
            cell.isHaveSelView = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
            switch (indexPath.row) {
                case 0:
                {
                NSString *baseUrl =   [[NSUserDefaults standardUserDefaults] valueForKey:kBaseUrl];
                cell.desText = baseUrl;
                }
                    break;
                case 1:
                {
//                    cell.desText = [NSString stringWithFormat:@"%@", [[XGPushTokenManager defaultTokenManager] xgTokenString]];
                }
                    break;
                case 2:
                {
                    NSString *deviceInfo = [NSString stringWithFormat:@"%@; iOS %@\n Scale/%0.2f", [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
                    cell.desText = deviceInfo;
                }
                    break;
                case 3:
                {
                    NSString *versionInfo = [NSString stringWithFormat:@"Version:%@ Build:%@", [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"], [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"]];
                    cell.desText = versionInfo;
                }
                    break;
                    
                case 4:
                {
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

//                    [QMUIConsole sharedInstance].canShow = YES;
//                    [QMUIConsole show];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            cell.textT = _elseArray[indexPath.row];
            cell.isHaveSelView = NO;
            
            switch (indexPath.row) {
                case 0:
                    break;
                case 1:

                    break;
                case 2:{
                    NSString *key = [HHDeveloperViewController getKey:TAG_TVERSION];
                    NSString * tversion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
                    if (tversion && tversion.length > 0) {
                        cell.desText = [NSString stringWithFormat:@"tversion:%@",tversion];
                    }else {
                        cell.desText = @"";
                    }
                }
                    break;
                default:
                    break;
            }

        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    static NSString *iHFView = @"iHFView";
    
    SCDeveloperHFView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:iHFView];
    if (!view) {
        view =  [[SCDeveloperHFView alloc] initWithReuseIdentifier:iHFView];
    }
    
    switch (section) {
        case 0:
        {
            view.textT = @"网络设置";
        }
            break;
        case 1:
        {
            view.textT = @"信息查看";
        }
            break;
        case 2:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UITableViewHeaderFooterView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (section == 2)?0.01:44.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        
        [HHSharedStorage sharedInstance].serverType = indexPath.row;
        
        [_tableView reloadData];
        
        [HHNetworkConfig config:indexPath.row];
        [[YJLoginManager sharedInstance] doLogout];
        exit(0);
    }
    
    switch (indexPath.section) {
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    NSString *baseUrl =   [[NSUserDefaults standardUserDefaults] valueForKey:kBaseUrl];

                    [self showInfo:baseUrl];
                }
                    break;
                case 1:
                {
//                    [self showInfo:[NSString stringWithFormat:@"%@",  [[XGPushTokenManager defaultTokenManager] xgTokenString]]];
                }
                    break;
                case 2:
                {
                    NSString *deviceInfo = [NSString stringWithFormat:@"%@; iOS %@\n Scale/%0.2f", [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
                    [self showInfo:deviceInfo];
                }
                    break;
                case 3:
                {
                    NSString *versionInfo = [NSString stringWithFormat:@"Version:%@ Build:%@", [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"], [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"]];
                    [self showInfo:versionInfo];
                }
                    break;
                    
                case 4:
                {
//                    [QMUIConsole sharedInstance].canShow = YES;
//                    [QMUIConsole show];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    [self writeTversion];

                }
                break;
                    break;
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}



#pragma mark - 读写配置文件

+ (NSString *)getKey:(NSInteger)tag {
    return [NSString stringWithFormat:@"SC_DEBUG_SETTING__%ld", tag];
}

@end
