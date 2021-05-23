#import <UIKit/UIKit.h>

/*---------------------------------通知 ---------------------------------*/

//退出账号
UIKIT_EXTERN NSString  * const kLogoutNotification;
//登陆成功
UIKIT_EXTERN NSString  * const kLoginSuccessNotification;


/*----------------------------------网络提示----------------------------------*/
//网络断开的提示语
UIKIT_EXTERN NSString  * const kNoNetworkTips;

/*----------------------------------网络请求平台key----------------------------------*/
//网络请求不需要平台参数key
UIKIT_EXTERN NSString  * const kNoTerminalKey;

/*-----------------------------NSUserDefaults-----------------------------*/


UIKIT_EXTERN NSString  * const kToken;

UIKIT_EXTERN NSString  * const kBaseUrl;



/*----------------------------------枚举----------------------------------*/


//header and footer
typedef NS_ENUM(NSUInteger, HHRefreshType) {
    HHRefreshTypeHeader,//只集成头部刷新
    HHRefreshTypeFooter,//只集成底部刷新
    HHRefreshTypeHeaderAndFooter,//集成头部和底部刷新
};



//单例创建
#undef    AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef    DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}
