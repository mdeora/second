//
//  EaseMobProcessor.m
//  TeachThin
//
//  Created by myStyle on 14-11-26.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "EaseMobProcessor.h"
#import "ApplyFriendControllerViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "ManageVC.h"
@interface  EaseMobProcessor()

@property (nonatomic, strong) NSOperationQueue *queue;

@end
@implementation EaseMobProcessor
+(void) init:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions{
    
    [[NSNotificationCenter defaultCenter] addObserver:[EaseMobProcessor sharedInstance]
                                             selector:@selector(loginStateChange:)
                                                 name:KNOTIFICATION_LOGINCHANGE
                                               object:nil];
    //13334564646465464561312345464645646461321314646
#warning SDK注册 APNS文件的名字, 需要与后台上传证书时的名字一一对应
      NSString *apnsCertName = nil;
  #if DEBUG
      apnsCertName = @"jiaoshou";
  #else
      apnsCertName = @"jiaoshou";
  #endif
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"1309#jiaoshou" apnsCertName:apnsCertName];
    
#if DEBUG
    [[EaseMob sharedInstance] enableUncaughtExceptionHandler];
#endif
    [[[EaseMob sharedInstance] chatManager] setAutoFetchBuddyList:YES];
    
    //以下一行代码的方法里实现了自动登录，异步登录，需要监听[didLoginWithInfo: error:]
    //demo中此监听方法在MainViewController中
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
#warning 注册为SDK的ChatManager的delegate (及时监听到申请和通知)
    [[EaseMob sharedInstance].chatManager removeDelegate:[EaseMobProcessor sharedInstance]];
    [[EaseMob sharedInstance].chatManager addDelegate:[EaseMobProcessor sharedInstance] delegateQueue:nil];
    
#warning 如果使用MagicalRecord, 要加上这句初始化MagicalRecord
    //demo coredata, .pch中有相关头文件引用
    [MagicalRecord setupCoreDataStackWithStoreNamed:[NSString stringWithFormat:@"%@.sqlite", @"UIDemo"]];
    
    //    [[EaseMobProcessor sharedInstance] loginStateChange:nil];
    [[EaseMobProcessor sharedInstance] registerRemoteNotification];
    NSLog(@">>>>>>>>>>>>>>>>>>>>init ease mob");
    
}


+(void) login:(BOOL)delay{
    double delayInSeconds = delay?0:2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [[EaseMobProcessor sharedInstance] doLogin];
    });
}

-(void) doLogin{
    
    NSLog(@">>>>>>>>>>>>>登陆了！！！！");
     NSLog(@">>>>>>>>>>>>%@, %@",[ManageVC sharedManage].name,[ManageVC sharedManage].pwd);
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:[MyMD5 md5HexDigest:[ManageVC sharedManage].uid]
                                                        password:[ManageVC sharedManage].pwd
                                                      completion:
     ^(NSDictionary *loginInfo, EMError *error) {
         if (loginInfo && !error) {
             [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
             EMError *error = [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
             if (!error)
             {
                 NSLog(@"环信登录成功");
                 error = [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
             };
             
         }else {
             NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:[ManageVC sharedManage].uid,@"uid",[ManageVC sharedManage].pwd,@"pwd", nil];
             
             NSString *url  = URL_Register_huanxin;
             
             JSHttpRequest *request = [[JSHttpRequest alloc] init];
             [request StartWorkPostWithurlstr:url pragma:postDic ImageData:nil];
             request.successGetData = ^(id obj){
                 NSLog(@"^^successGetData^^^%@",obj);
                 NSString * result = [obj valueForKey:@"code"];
                 if ([result isEqualToString:@"01"]) {
                     [EaseMobProcessor login:NO];
                 }else if ([result isEqualToString:@"00"]){
                     
                 }
             };
         }
     } onQueue:nil];
}

+(void)registUser{

    NSLog(@">>>>>>>>>>>>%@, %@",[ManageVC sharedManage].name,[ManageVC sharedManage].pwd);
    
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:[ManageVC sharedManage].name
                                                         password:[ManageVC sharedManage].pwd
                                                   withCompletion:
     ^(NSString *username, NSString *password, EMError *error) {
         if (!error) {
             //TTAlertNoTitle(@"注册成功,请登录");
             //[EaseMobProcessor login:NO];//登录
         }else{
             switch (error.errorCode) {
                 case EMErrorServerNotReachable:
                    // TTAlertNoTitle(@"连接服务器失败!");
                     break;
                 case EMErrorServerDuplicatedAccount:
                     //TTAlertNoTitle(@"您注册的用户已存在!");
                     //[EaseMobProcessor login:NO];
                     break;
                 case EMErrorServerTimeout:
                     //TTAlertNoTitle(@"连接服务器超时!");
                     break;
                 default:
                     //TTAlertNoTitle(@"注册失败");
                     break;
             }
         }
     } onQueue:nil];
    
}

//
+(void) logout{
    [[EaseMob sharedInstance].chatManager asyncLogoff];
    [ManageVC sharedManage].LoginState = NO;
}


-(void)registerRemoteNotification{
#if !TARGET_IPHONE_SIMULATOR
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
    
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
    
#endif
    
}

#pragma mark - private

-(void)loginStateChange:(NSNotification *)notification
{
    
    NSLog(@">>>>>>>>>>>>>>>>登录状态改变！！！！！");
    BOOL isAutoLogin = [[[EaseMob sharedInstance] chatManager] isAutoLoginEnabled];
    BOOL loginSuccess = [notification.object boolValue];
    
    if (isAutoLogin || loginSuccess) {
        [[ApplyFriendControllerViewController shareController] loadDataSourceFromLocalDB];
     
    }
}

+(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken{
    // 让SDK得到App目前的各种状态，以便让SDK做出对应当前场景的操作
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

+(void) registeDeviceToken:(UIApplication *)application deviceToken:(NSData *)deviceToken{
    // 让SDK得到App目前的各种状态，以便让SDK做出对应当前场景的操作
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

+(void) applicationWillResignActive:(UIApplication *)application{
    // 让SDK得到App目前的各种状态，以便让SDK做出对应当前场景的操作
    [[EaseMob sharedInstance] applicationWillResignActive:application];
}

+(void) applicationDidEnterBackground:(UIApplication *)application{
    // 让SDK得到App目前的各种状态，以便让SDK做出对应当前场景的操作
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

+(void) applicationWillEnterForeground:(UIApplication *)application{
    // 让SDK得到App目前的各种状态，以便让SDK做出对应当前场景的操作
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

+(void) applicationDidBecomeActive:(UIApplication *)application{
    // 让SDK得到App目前的各种状态，以便让SDK做出对应当前场景的操作
    [[EaseMob sharedInstance] applicationDidBecomeActive:application];
    NSLog(@">>>>>>>applicationDidBecomeActive>>>>>>>>>>>");
    if ([ManageVC sharedManage].LoginState == YES) {
        [EaseMobProcessor login:NO];
    }
}

+(void) applicationWillTerminate:(UIApplication *)application{
    // 让SDK得到App目前的各种状态，以便让SDK做出对应当前场景的操作
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

#pragma mark - IChatManagerDelegate 好友变化

- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message
{
    if (!username) {
        return;
    }
    if (!message) {
        message = [NSString stringWithFormat:@"%@ 添加你为好友", username];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"title":username, @"username":username, @"applyMessage":message, @"applyStyle":[NSNumber numberWithInteger:ApplyStyleFriend]}];
    [[ApplyFriendControllerViewController shareController] addNewApply:dic];
//    NSMutableArray *dicArray = [NSMutableArray new];
//    [dicArray addObject:dic];
//    
//    [ApplyFriendControllerViewController shareController].dataSource = dicArray;
//    NSLog(@">>>>>>>>>[ApplyFriendControllerViewController shareController].dataSource>>>>>>>>%ld", [ApplyFriendControllerViewController shareController].dataSource.count);
}


+ (EaseMobProcessor *) sharedInstance{
    static EaseMobProcessor *sharedInstance = nil;
    if(sharedInstance == nil){
        sharedInstance = [[EaseMobProcessor alloc] init];
        sharedInstance.queue = [[NSOperationQueue alloc]init];
    }
    
    return sharedInstance;
}
@end
