#import <UIKit/UIKit.h>

/*----------------------------------购物车数量----------------------------------*/

NSInteger shopCartTotal = 0;

NSString *locationStr = nil;

NSInteger margin = 10;

//底部按钮的高度
NSInteger kBottomHeight = 54;

/*----------------------------------通知----------------------------------*/

//退出登录
NSString  * const kLogoutNotification = @"kLogoutNotification";
//登陆成功
NSString  * const kLoginSuccessNotification = @"kLoginSuccessNotification";


/*----------------------------------网络提示----------------------------------*/
NSString  * const kNoNetworkTips = @"当前网络不可用,请检查网络设置";


/*----------------------------------网络请求平台key----------------------------------*/
//网络请求不需要平台参数key
NSString  * const kNoTerminalKey = @"noTerminal";


/*-----------------------------NSUserDefaults-----------------------------*/

NSString  * const kBaseUrl = @"kBaseUrl";

NSString  * const kToken = @"kToken";









