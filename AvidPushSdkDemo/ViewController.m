//
//  ViewController.m
//  AvidPushSdkDemo
//
//  Created by Avidly on 2017/3/28.
//  Copyright © 2017年 Avidly. All rights reserved.
//

#import "ViewController.h"
#import <AvidlyPushSDK/AvidlyPushSDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendLocalNote:(id)sender {
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:5];    //5秒之后推送
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:@"testValue", @"testKey", nil];
    [[STAvidlyPushManager shareManager] sendLocalNotification:@"本地推送" badge:1 userInfo:userInfo fireDate:fireDate];
}

@end
