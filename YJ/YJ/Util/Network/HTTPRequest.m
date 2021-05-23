//
//  HTTPRequest.m
//  Headline
//
//  Created by 花花 on 2017/2/14.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "HTTPRequest.h"

#import <AFNetworking/AFNetworking.h>
#import "AFHTTPSessionManager+Config.h"
#import "HTTPRequest+NotLogin.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
//#import "Reachability.h"

@implementation LYRequestModel

+ (LYRequestModel *)newWithTask:(id)task{
    LYRequestModel * model = [[LYRequestModel alloc]init];
    model.task = task;
    return  model;
}

- (BOOL)isFinish{
    NSURLSessionDataTask *task = self.task;
    return task.state == NSURLSessionTaskStateCompleted;
}

- (void)cancel{
    NSURLSessionDataTask *task = self.task;
    [task cancel];
}

@end

@implementation HTTPRequest

#pragma mark - 单例
+(AFHTTPSessionManager *)requestManager{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        [manager configSetting];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer.HTTPShouldHandleCookies = YES;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/jpeg",@"image/png", nil];
    });
    
    //检测网络状态的改变
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                break;
            default:
                break;
        }
    }];
    
    //3.开始监听
    [manager.reachabilityManager startMonitoring];
    return manager;
}

+ (BOOL)isNetworkAvailable{
//    Reachability *reach = [Reachability reachabilityForInternetConnection];
//    NetworkStatus status = [reach currentReachabilityStatus];
//    if (status == ReachableViaWiFi || status == ReachableViaWWAN) {
//        return YES;
//    }
    return NO;
}

#pragma mark - host管理
+ (NSString *)InterfaceUrl:(NSString *)url{
  NSString *baseUrl =  [[NSUserDefaults standardUserDefaults]valueForKey:kBaseUrl];
    NSString *urlstring = [NSString stringWithFormat:@"%@/%@",baseUrl,url];
    return urlstring;
}

#pragma mark - 网络请求
+ (LYRequestModel *)GET:(NSString *)urlString parameter:(NSDictionary *)parameter success:(requestSuccessCallBack)success failure:(requestErrorCallBack)failue
{
    AFHTTPSessionManager *manager = [HTTPRequest requestManager];
    // 如果已有Cookie, 则把你的cookie符上
    NSString *cookie = [YJLoginManager sharedInstance].token;
    if (cookie != nil) {
        [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Authorization"];
    }
    
    //配置公共参数
    parameter = [AFHTTPSessionManager configBaseParmars:parameter];
    NSURLSessionDataTask *task = [manager GET:[HTTPRequest InterfaceUrl:urlString] parameters:parameter headers:nil progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"urlString: %@ --\n parameter%@ \n responseObject: %@",[HTTPRequest InterfaceUrl:urlString],parameter, responseObject);
              NSString *response = nil;
              if ([responseObject isKindOfClass:[NSData class]]) {
                  response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                  NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
                  id dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                  
                  if ([dic isKindOfClass:[NSArray class]]) {
                      dic = [dic firstObject];
                  }
                  [HTTPRequest handelSuccessRequest:task responseObject:dic success:success fail:failue];
                  return;
              }
              
              if (responseObject&&[responseObject isKindOfClass:[NSDictionary class]]){
                  [HTTPRequest handelSuccessRequest:task responseObject:responseObject success:success fail:failue];
              }
              else if (responseObject&&[responseObject isKindOfClass:[NSArray class]]){
                  [HTTPRequest handelSuccessRequest:task responseObject:responseObject success:success fail:failue];
              }
              else {
                  NSError * error = [NSError errorWithDomain:@"服务器出错了" code:-100 userInfo:@{@"message":@"服务器返回的不是json或者是空对象"}];
                  [HTTPRequest handelFailRequest:task err:error fail:failue];
              }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       [HTTPRequest handelFailRequest:task err:error fail:failue];

    }];

    LYRequestModel *requestModel = [LYRequestModel newWithTask:task];
    return requestModel;
}

/*POST请求*/
+ (LYRequestModel *)POST:(NSString *)urlString  parameter:(NSDictionary *)parameter  success:(requestSuccessCallBack)success failure:(requestErrorCallBack)failue{
    
    AFHTTPSessionManager *manager = [HTTPRequest requestManager];
    if ([urlString isEqualToString:kSendWaiterCaptchaUrl]) {
        
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else{
        manager.requestSerializer = [AFJSONRequestSerializer serializer];

    }

    
    //配置公共参数  直接将token放到里面的  后来token作为请求头了
    parameter = [AFHTTPSessionManager configBaseParmars:parameter];
    
    // 如果已有Cookie, 则把你的cookie符上
    NSString *cookie = [YJLoginManager sharedInstance].token;
    if (cookie != nil) {
        [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Authorization"];
    }
    
    [HTTPRequest showActive];
    NSURLSessionDataTask *task =   [manager POST:[HTTPRequest InterfaceUrl:urlString] parameters:parameter headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"urlString: %@ --\n parameter%@ \n responseObject: %@",[HTTPRequest InterfaceUrl:urlString],parameter, responseObject);
        
//        NSHTTPURLResponse* urlresponse = (NSHTTPURLResponse* )task.response;
//        NSDictionary *allHeaderFieldsDic = urlresponse.allHeaderFields;
        NSString *setCookie = [YJLoginManager sharedInstance].token;
//        allHeaderFieldsDic[@"Authorization"];
        if (setCookie != nil) {
//            NSString *cookie = [[setCookie componentsSeparatedByString:@";"] objectAtIndex:0];
            // 这里对cookie进行存储
            [[NSUserDefaults standardUserDefaults] setObject:cookie forKey:@"Authorization"];
        }
        
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSString * response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSData * data = [response dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [HTTPRequest handelSuccessRequest:task responseObject:dic success:success fail:failue];
            return;
        }

        if (responseObject&&[responseObject isKindOfClass:[NSDictionary class]]) {
            [HTTPRequest handelSuccessRequest:task responseObject:responseObject success:success fail:failue];
        }
        else{
            NSError * error = [NSError errorWithDomain:@"服务器出错了" code:-100 userInfo:@{@"message":@"服务器返回的不是json或者是空对象"}];
            [HTTPRequest handelFailRequest:task err:error fail:failue];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [HTTPRequest handelFailRequest:task err:error fail:failue];
    }];
    
    LYRequestModel *requestModel = [LYRequestModel newWithTask:task];
    return requestModel;
}

/*PUT请求*/
+ (LYRequestModel *)PUT:(NSString *)urlString  parameter:(NSDictionary *)parameter  success:(requestSuccessCallBack)success failure:(requestErrorCallBack)failue{
    
    AFHTTPSessionManager *manager = [HTTPRequest requestManager];
    if ([urlString isEqualToString:kSendWaiterCaptchaUrl]) {
        
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else{
        manager.requestSerializer = [AFJSONRequestSerializer serializer];

    }

    
    //配置公共参数  直接将token放到里面的  后来token作为请求头了
    parameter = [AFHTTPSessionManager configBaseParmars:parameter];
    
    // 如果已有Cookie, 则把你的cookie符上
    NSString *cookie = [YJLoginManager sharedInstance].token;
    if (cookie != nil) {
        [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Authorization"];
    }
    
    [HTTPRequest showActive];
    NSURLSessionDataTask *task =   [manager PUT:[HTTPRequest InterfaceUrl:urlString] parameters:parameter headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"urlString: %@ --\n parameter%@ \n responseObject: %@",[HTTPRequest InterfaceUrl:urlString],parameter, responseObject);
        
//        NSHTTPURLResponse* urlresponse = (NSHTTPURLResponse* )task.response;
//        NSDictionary *allHeaderFieldsDic = urlresponse.allHeaderFields;
        NSString *setCookie = [YJLoginManager sharedInstance].token;
//        allHeaderFieldsDic[@"Authorization"];
        if (setCookie != nil) {
//            NSString *cookie = [[setCookie componentsSeparatedByString:@";"] objectAtIndex:0];
            // 这里对cookie进行存储
            [[NSUserDefaults standardUserDefaults] setObject:cookie forKey:@"Authorization"];
        }
        
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSString * response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSData * data = [response dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [HTTPRequest handelSuccessRequest:task responseObject:dic success:success fail:failue];
            return;
        }

        if (responseObject&&[responseObject isKindOfClass:[NSDictionary class]]) {
            [HTTPRequest handelSuccessRequest:task responseObject:responseObject success:success fail:failue];
        }
        else{
            NSError * error = [NSError errorWithDomain:@"服务器出错了" code:-100 userInfo:@{@"message":@"服务器返回的不是json或者是空对象"}];
            [HTTPRequest handelFailRequest:task err:error fail:failue];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [HTTPRequest handelFailRequest:task err:error fail:failue];
    }];
    
    LYRequestModel *requestModel = [LYRequestModel newWithTask:task];
    return requestModel;
}

+(void)UPLOAD:(NSString*)url image:(UIImage *)image parameter:(id)parameter  progress:(void(^)(CGFloat progress))progres        success:(void (^)(id responseOBj))success
      failure:(void (^)(NSError *error))failure{
    
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    NSLog(@"%@-----%zd",imageData, imageData.length);
    if (imageData.length>1024*1024) {
        
        imageData = UIImageJPEGRepresentation(image, 1024.0f *1024.0f/(CGFloat)imageData.length);
    }
    
    
    //    AFHTTPSessionManager *manager = [self requestManager];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //  [manager.requestSerializer setValue:LH.token forHTTPHeaderField:@"token"];
    
    
    //申明返回的结果是json类型
    //        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    //        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    
    
    //解决不接受类型为"text/html"
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/jpeg",@"image/png", nil];
    
    
    
    
    NSMutableURLRequest *request =[manager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[self InterfaceUrl:url] parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"image.jpg"
                                mimeType:@"image/jpg"];
        
    } error:nil];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            CGFloat progressValue =(CGFloat)uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
            if (progres) {
                progres(progressValue);
            }
            
        });
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        id jsonDic =[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSDictionary *dic;
        if ([jsonDic isKindOfClass:[NSArray class]]) {
            dic =[jsonDic firstObject];
        }else{
            dic = jsonDic;
        }
        [self hideActive];
        
        if (error) {
            
            
        }else{
            success(dic);
        }
    }];
    [uploadTask resume];
    
}

+ (LYRequestModel *)UPLOAD:(NSString *)url uploadParam:(NSDictionary *)uploadParam params:(id)params progress:(void (^)(NSProgress * uploadProgress))progress success:(requestSuccessCallBack)success  failure:(requestErrorCallBack)failure{
    [HTTPRequest showActive];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    
    
    //解决不接受类型为"text/html"
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/jpeg",@"image/png", nil];
    
    //配置公共参数
    params = [AFHTTPSessionManager configBaseParmars:params];
    

    NSURLSessionDataTask *task = [manager POST:url parameters:params   headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSString *key in uploadParam.allKeys) {
             [formData appendPartWithFileData:uploadParam[key] name:key fileName:[NSString stringWithFormat:@"%@.jpg",key] mimeType:@"image/jpg"];
         }
    } progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [HTTPRequest handelSuccessRequest:task responseObject:responseObject success:success fail:failure];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [HTTPRequest handelFailRequest:task err:error fail:failure];

    }];
    
    LYRequestModel *requestModel = [LYRequestModel newWithTask:task];
    return requestModel;
}


#pragma mark - 请求处理
+ (void)handelSuccessRequest:(NSURLSessionDataTask * _Nonnull)task responseObject:(id _Nullable)responseObject success:(requestSuccessCallBack)success fail:(requestErrorCallBack)fail{
    
    [HTTPRequest hideActive];
    
    
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    NSInteger statusCode = response.statusCode;
    
    if (statusCode == resultCode_1032) {  //您的登录地址发生了改变，请通过短信验证码登录'
        
        BOOL isSingle  =  [HTTPRequest singleLoginWithResult:statusCode msg:responseObject[@"msg"]];
        if (isSingle){
            return;
        }
    }else{
        if (success) {
            success(responseObject);
        }
    }
}


+ (void)handelFailRequest:(NSURLSessionDataTask * _Nonnull)task err:(NSError * _Nullable)err fail:(requestErrorCallBack)fail{
    [self hideActive];
    
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    NSInteger statusCode = response.statusCode;
    
    NSDictionary *dic = response.allHeaderFields;
    
    
    NSLog(@"errstatusCode %ld===============",statusCode);
    //如果响应头http状态码是401 则重新登录   501:您已在其他设备登录，如非本人操作，请尽快修改密码
    if (statusCode == 401 ) {
        NSLog(@"重新登录--------");
        BOOL isSingle  =  [HTTPRequest singleLoginWithResult:statusCode msg:@""];
        if (isSingle){ return; }
        
    }else if(statusCode == 501){
//        NSString *time = dic[@"time"];
//        NSString *msgTip  = [HTTPRequest HeaderFieldWithMsg:[dic[@"msg"] integerValue]];
//        NSString *msg = [NSString stringWithFormat:@"您的账号于%@在另一台设备登录。登录方式:%@。如非本人操作，请及时修改密码",time,msgTip];
//        BOOL isSingle  =  [HTTPRequest singleLoginWithResult:statusCode msg:msg];
//        if (isSingle){ return; }
        
    }
    
    if (fail) {
        fail(err);
    }
    
}

+(NSString *)HeaderFieldWithMsg:(NSInteger)msg{
    NSString *str;
    switch (msg) {
        case 0:
            str = @"沃银企服公众号";
            break;
        case 1:
            str = @"壹企服APP苹果端";
            break;
        case 2:
            str = @"壹企服APP安卓端";
            break;
        default:
            break;
    }
    return str;
}

#pragma mark - 状态栏网络请求图标
+ (void)showActive {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

+ (void)hideActive {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
