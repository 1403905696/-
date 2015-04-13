//
//  UIWindow+Extension.m
//  新浪微博
//
//  Created by o3 on 15/4/13.
//  Copyright (c) 2015年 OU. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "OUNewFeatureViewController.h"
#import "OUHomeViewController.h"
#import "OUTabBarController.h"
@implementation UIWindow (Extension)
-(void)switchRootViewController{
    NSString *key=@"CFBundleVersion";
    //从沙盒中获取上一版本号
    NSString *lastVersion=[[NSUserDefaults standardUserDefaults] objectForKey:key];
    //从info.plist中获取当前版本号
    NSString *currentVersion=[NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        //进入主页面
        self.rootViewController=[[OUTabBarController alloc] init];
    }else{
        //进入版本新特性界面
        self.rootViewController=[[OUNewFeatureViewController alloc] init];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
