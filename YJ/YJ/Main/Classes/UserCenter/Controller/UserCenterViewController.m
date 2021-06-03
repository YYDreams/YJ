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
#import "HHActionSheetController.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <TZImageManager.h>
#import "UIImagePickerController+blockCallBack.h"
#import <UserNotifications/UserNotifications.h>
@interface UserCenterViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate,UNUserNotificationCenterDelegate>


@property(nonatomic,strong)NSArray *dataArr;

@property(nonatomic,assign)NSInteger receiveCall; //是否接收语音推送 0-不接收 1-接收

@property(nonatomic,assign)NSInteger workState;  //工作状态 0-休息中 1-工作中

@property(nonatomic,strong)UserCenterHeaderView * headerView;

@property(nonatomic,assign)BOOL isOpenSystemNotice;



//只关闭语音推送，但还是上班的状态，消息列表是可以收到消息的
@end
static NSString * const UserCenterCellID = @"UserCenterCellID";
static NSString * const UserCenterHeaderID = @"UserCenterHeaderID";

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
//
    NSLog(@"个人中心个人中心:%d,",[self getNoticeSetting]);
//    self.isOpenSystemNotice = [self getNoticeSetting];
    
//    UIApplication.didBecomeActiveNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:UIApplicationDidBecomeActiveNotification object:nil];
    [self getUserInfo];
    [self setupInit];
}
- (void)reloadData{
    
    NSLog(@"reloadDatareloadDatareloadDatareloadData");
// _isOpenSystemNotice = [self getNoticeSetting];
    [self.tableView reloadData];
}



//检查通知状态
- (void)checkNotifiState{
    
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            
            switch (settings.authorizationStatus) {
                case UNAuthorizationStatusDenied:
                case UNAuthorizationStatusNotDetermined:
                    
                default:
                    break;
            }
        }];
    }
//    typedef NS_ENUM(NSInteger, UNAuthorizationStatus) {
//        // The user has not yet made a choice regarding whether the application may post user notifications.
//        UNAuthorizationStatusNotDetermined = 0,
//
//        // The application is not authorized to post user notifications.
//        UNAuthorizationStatusDenied,
//
//        // The application is authorized to post user notifications.
//        UNAuthorizationStatusAuthorized,
//
//        // The application is authorized to post non-interruptive user notifications.
//        UNAuthorizationStatusProvisional __API_AVAILABLE(macos(10.14), ios(12.0), watchos(5.0), tvos(12.0)),
//
//        // The application is temporarily authorized to post notifications. Only available to app clips.
//        UNAuthorizationStatusEphemeral __API_AVAILABLE(ios(14.0)) __API_UNAVAILABLE(macos, watchos, tvos)
//    }
    
//    if #available(iOS 10.0, *) {
//        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
//            switch settings.authorizationStatus {
//            case .denied, .notDetermined:
//                self.isOpenSystemNotice = false
//            default:
//                self.isOpenSystemNotice = true
//            }
//            isOn?()
//        }
//    } else {}
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"个人中心viewWillAppear中心:%d,",[self getNoticeSetting]);
//
    //iOS 10 later
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        
        NSLog(@"settingssettingssettings:%@",settings);
    }];
    
    
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
    headerView.userInteractionEnabled = true;
    [headerView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionSheetphoto)]];
    headerView.titleLabel.text = [YJLoginManager sharedInstance].model.name;
    headerView.subTitle.text = [YJLoginManager sharedInstance].model.mobile;
    [headerView.headImgView sd_setImageWithURL:[NSURL URLWithString: [YJLoginManager sharedInstance].model.avatar] placeholderImage:[UIImage imageNamed:@"icon_login"]];
    _headerView = headerView;
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

- (void)actionSheetphoto{
    UIActionSheet *actionSheet =[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消"  destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"选择照片", nil];
    
    [actionSheet showInView:self.view];
}

#pragma mark - <UIActionSheetDelegate>

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 0){
        
        [self takePhotoWithTakePhoto:YES];
//        [self chooseImaage:UIImagePickerControllerSourceTypeCamera]; //拍照
        
    }else if(buttonIndex == 1){
        
        [self takePhotoWithTakePhoto:NO];
//        [self chooseImaage:UIImagePickerControllerSourceTypePhotoLibrary]; //选择照片
        
    }
}



#pragma mark - Custom Method

-(void)chooseImaage:(UIImagePickerControllerSourceType)soureType{
    
    
    UIImagePickerController *pickerVc =[[UIImagePickerController alloc]init];
    pickerVc.delegate = self;
    pickerVc.sourceType = soureType;
    pickerVc.allowsEditing = YES;
    [self presentViewController:pickerVc animated:YES completion:nil];
}



#pragma mark - <UIImagePickerControllerDelegate>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image =[info objectForKey:UIImagePickerControllerOriginalImage];
 
    
    [self uploadImage:image];
    
}

-(void)uploadImage:(UIImage *)image{
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);

    NSString *encodedImageString = [data base64Encoding];

    [HTTPRequest POST:kUploadAvatarUrl parameter:@{@"base64Data":encodedImageString} success:^(id resposeObject) {
        
        
        if (Success) {
            NSString * headImg =  resposeObject[@"body"][@"data"];
            NSLog(@"headImgheadImgheadImg:%@",headImg);
            self.headerView.headImgView.image = image;
            [YJLoginManager sharedInstance].model.avatar = headImg;
            [[YJLoginManager sharedInstance] saveUserModel];
            NSLog(@"avataravataravatar:%@",[YJLoginManager sharedInstance].model.avatar);
        }else{
            [HHHudManager showErrorMessage:@"上传失败"];
        }
    } failure:^(NSError *error) {
        [HHHudManager showErrorMessage:@"上传失败"];
    }];


    
    
}
- (BOOL)getNoticeSetting{

    
    UIUserNotificationSettings *setting = UIApplication.sharedApplication.currentUserNotificationSettings;
 
    setting.types != UIUserNotificationTypeNone;

//    setting =
//    UIApplication.shared.currentUserNotificationSettings
    return  YES;
}





//- (void)actionSheetphoto {
//    WeakSelf;
//    HHActionSheetController * alert = [HHActionSheetController new];
//    HHActionSheetAction * action0 = [HHActionSheetAction actionWithTitle:@"拍照" handler:^(HHActionSheetAction * _Nonnull action) {
//
//        [weakSelf takePhotoWithTakePhoto:YES];
//    }];
//    [alert addAction:action0];
//
//    HHActionSheetAction * action1 = [HHActionSheetAction actionWithTitle:@"我的相册" handler:^(HHActionSheetAction * _Nonnull action) {
//
//        [weakSelf takePhotoWithTakePhoto:NO];
//    }];
//    [alert addAction:action1];
//
//    [self presentViewController:alert animated:YES completion:nil];
//
//}
//
- (void)takePhotoWithTakePhoto:(BOOL)isTakePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的“隐私-设置”选项中，允许app访问您的相册" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhotoWithTakePhoto:isTakePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法访问相册" message:@"请在iPhone的“隐私-设置”选项中，允许app访问您的相册" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消"  style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhotoWithTakePhoto:isTakePhoto];
        }];
    } else {
        [self seletedPhotoWithTakePhoto:isTakePhoto];
    }
}


- (void)seletedPhotoWithTakePhoto:(BOOL)isTakePhoto{
    WeakSelf;
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = isTakePhoto ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary;
    [imagePicker setMediaInfoCallBack:^bool(NSDictionary<UIImagePickerControllerInfoKey,id> * _Nullable info, BOOL didCaceled) {

        UIImage *image = info[UIImagePickerControllerEditedImage];
        NSLog(@"imageimage:>%@",image);
        
        if (!kObjectIsEmpty(image)) {
            [self uploadImage:image];
        }
        return YES;
    }];
    imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePicker animated:YES completion:nil];
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

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}
@end
