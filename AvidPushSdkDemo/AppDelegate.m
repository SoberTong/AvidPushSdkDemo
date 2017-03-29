//
//  AppDelegate.m
//  AvidPushSdkDemo
//
//  Created by Avidly on 2017/3/28.
//  Copyright © 2017年 Avidly. All rights reserved.
//

#import "AppDelegate.h"
#import <AvidlyPushSDK/AvidlyPushSDK.h>

@interface AppDelegate () <STAvidlyPushManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [STAvidlyPushManager shareManager].delegate = self;
    [[STAvidlyPushManager shareManager] application:application didFinishLaunchingWithOptions:launchOptions];
    [[STAvidlyPushManager shareManager] requestDeviceToken];
    
    return YES;
}
    
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[STAvidlyPushManager shareManager] setDeviceToken:deviceToken gameAccountId:@"ssss" handler:^(id result, NSError *error) {
        if (error) {
            NSLog(@"set DeviceToken error:%@", error);
        }else {
            NSLog(@"set DeviceToken succeed.");
        }
    }];
}
    
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(nonnull NSError *)error {
    NSLog(@"get DeviceToken error:%@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
    {
        [[STAvidlyPushManager shareManager] application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
    }
    
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
    {
        [[STAvidlyPushManager shareManager] application:application didReceiveLocalNotification:notification];
    }
    
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
    {
        [[STAvidlyPushManager shareManager] userNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
    }
    
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler
    {
        [[STAvidlyPushManager shareManager] userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
    }
    
- (void)AvidlyPushCallback:(NSDictionary *)pushInfo type:(STAvidlyPushType)type state:(STAvidlyPushState)state
    {
        NSString *title = [NSString stringWithFormat:@"%@ %@",type==STAvidlyPushTypeLocal?@"本地推送":@"远程推送",state==STAvidlyPushStateActive?@"前台接收":@"后台接收"];
        NSString *message = [NSString stringWithFormat:@"%@",pushInfo];
        
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             title, @"title",
                             message,@"message",
                             nil];
        [self performSelector:@selector(showRemoteAlert:) withObject:dic afterDelay:1];
    }
- (void)showRemoteAlert:(NSDictionary *)dic
    {
        NSString *title = [dic objectForKey:@"title"];
        NSString *message = [dic objectForKey:@"message"];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self.window.rootViewController presentViewController:alertController animated:YES completion:^{
            
        }];
    }

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
