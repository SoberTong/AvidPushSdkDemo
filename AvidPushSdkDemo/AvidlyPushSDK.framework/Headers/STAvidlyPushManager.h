//
//  STAvidlyPushManager.h
//  AvidlyPushSDK
//
//  Created by steve on 2017/3/15.
//  Copyright © 2017年 liuguojun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

@protocol STAvidlyPushManagerDelegate;

@interface STAvidlyPushManager : NSObject

+ (instancetype)shareManager;

@property (nonatomic,assign) id<STAvidlyPushManagerDelegate> delegate;

/**
 获取SDK版本

 @return SDK版本
 */
- (NSString *)SDKVersion;

/**
 请求设备Token
 */
- (void)requestDeviceToken;

/**
 设置设备token

 @param deviceToken 设备token
 @param gameAccountId 游戏中的用户id
 @param completionHandler 回调
 */
- (void)setDeviceToken:(NSData *)deviceToken gameAccountId:(NSString *)gameAccountId handler:(void (^)(id result, NSError *error))completionHandler;

#pragma iOS10 before local Notification

/**
 iOS10之前 用于获取本地后台推送
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

/**
 iOS10之前 用于获取本地前台推送
 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;

#pragma iOS10 before Remote Notification

/**
 iOS10之前 用于获取远程推送
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;

#pragma After iOS10 Notification

/**
 iOS10之后 用于获取前台推送
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler;

/**
 iOS10之后 用于获取后台推送
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler;

#pragma Send Local Notification

/**
 发送本地推送

 @param body 要显示的推送内容
 @param badge 角标
 @param userInfo 要传递的信息
 @param fireDate 本地推送发送时间
 */
- (void)sendLocalNotification:(NSString *)body badge:(int)badge userInfo:(NSDictionary *)userInfo fireDate:(NSDate *)fireDate;

#pragma Badge角标

/**
 获取当前角标数字

 @return 当前角标数字
 */
- (NSInteger)currentBadge;

/**
 清除角标
 */
- (void)clearBadge;

@end

typedef NS_ENUM(NSInteger, STAvidlyPushType) {
    STAvidlyPushTypeLocal,  //本地推送
    STAvidlyPushTypeRemote  //远程推送
};

typedef NS_ENUM(NSInteger, STAvidlyPushState) {
    STAvidlyPushStateActive,        //推送时，应用处于前台
    STAvidlyPushStateBackground     //推送时，应用处于后台
};

@protocol STAvidlyPushManagerDelegate <NSObject>

- (void)AvidlyPushCallback:(NSDictionary *)pushInfo type:(STAvidlyPushType)type state:(STAvidlyPushState)state;

@end

