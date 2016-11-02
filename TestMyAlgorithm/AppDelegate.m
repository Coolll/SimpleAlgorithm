//
//  AppDelegate.m
//  TestMyAlgorithm
//
//  Created by 龙培 on 16/10/21.
//  Copyright © 2016年 龙培. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //注册
//    [self loadWQLLocalNotificationWithApplication:application];
    
    //触发
//    [self startTriggerNotification];
    
    return YES;
}


//注册本地通知
- (void)loadWQLLocalNotificationWithApplication:(UIApplication*)application{
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=10.0) {
        
        
        //iOS10才有的
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
        //必须写代理，否则无法监听通知的接收与点击
        center.delegate = self;
        
        
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
           
            if (granted) {
                
                //用户允许推送
                NSLog(@"注册成功");
                
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                   
                    NSLog(@"settings: %@",settings);
                }];

            }else{
            
                //用户不允许推送
                NSLog(@"注册失败");
                
            }
            
            
        }];
    
    
    }else if ([[UIDevice currentDevice].systemVersion floatValue]  >8.0){
    
        //iOS8 iOS9
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound |UIUserNotificationTypeBadge categories:nil]];
    }else if ([[UIDevice currentDevice].systemVersion floatValue]< 8.0){
    
    
        //iOS 8以下
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeAlert |UIUserNotificationTypeAlert ];
    }
    
    
    //注册获得Device Token
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    

}

//创建本地通知
- (void)startTriggerNotification
{

    //创建通知内容
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    
    content.title = @"WQL NNNNNNN Test";
    
    content.subtitle = @"Test subtitle NNNNN";
    
    content.body = @"来自WQL的测试";
    
    content.badge = @1;
    
    NSError *error = nil;
    
    //文件路径
    NSString *path = [[NSBundle mainBundle]pathForResource:@"icon@2x" ofType:@"png"];
    
    //设置通知附件内容
    UNNotificationAttachment *att = [UNNotificationAttachment attachmentWithIdentifier:@"att1" URL:[NSURL fileURLWithPath:path] options:nil error:&error];
    
    if (error) {
        NSLog(@"attach error :%@",error);
    }
    
    content.attachments = @[att];
    
    content.launchImageName = @"icon@2x";
    
    
    //设置声音
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    
    content.sound = sound;
    
    //触发模式
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:61 repeats:YES];
    
    
    //设置UNNotificationRequest
    NSString *requestIdentifier = @"TestRequest";
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:trigger];
    
    //把通知添加到UNUserNotificationCenter，到指定触发点会被触发
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request  withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
    
}


// 获得Device Token
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
}


// 获得Device Token失败
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}



//iOS 10 收到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    //收到推送的请求
    UNNotificationRequest *request = notification.request;
    
    
    //收到推送的消息内容
    UNNotificationContent *content = request.content;
    
    //推送消息的角标
    NSNumber *badge = content.badge;
    
    //推送消息体
    NSString *body = content.body;
    
    //推送消息的声音
    UNNotificationSound *sound = content.sound;
    
    //推送消息的副标题
    NSString *subtitle = content.subtitle;
    
    //推送消息的标题
    NSString *title = content.title;
    
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        NSLog(@"iOS 10 前台收到远程通知:%@",userInfo);

    }else{
        
        NSLog(@"iOS 10 收到本地通知:\n\n\nbody:%@，\n\n\ntitle:%@,\n\n\nsubtitle:%@,\n\n\nbadge：%@，\n\n\nsound：%@，\n\n\nuserInfo：%@\n\n\n}",body,title,subtitle,badge,sound,userInfo);

    }
    
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound);
    
}


//通知的点击事件
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler
{
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    
    //收到推送的请求
    UNNotificationRequest *request = response.notification.request;
    
    //收到推送的消息内容
    UNNotificationContent *content = request.content;
    
    //推送消息的角标
    NSNumber *badge = content.badge;
    
    //推送的消息体
    NSString *body = content.body;

    //推送消息的声音
    UNNotificationSound *sound = content.sound;
    
    //推送消息的副标题
    NSString *subtitle = content.subtitle;
    
    //推送消息的标题
    NSString *title = content.title;
    
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        //远程推送
        NSLog(@"iOS 10 前台收到远程通知:%@",userInfo);
        
    }else{
        
        
        //本地通知
        NSLog(@"iOS 10 收到本地通知:\n\n\nbody:%@，\n\n\ntitle:%@,\n\n\nsubtitle:%@,\n\n\nbadge：%@，\n\n\nsound：%@，\n\n\nuserInfo：%@\n\n\n}",body,title,subtitle,badge,sound,userInfo);
        
    }
    
    //系统要求执行此方法
    completionHandler();
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
