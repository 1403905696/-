//
//  OUTabBarController.m
//  新浪微博
//
//  Created by o3 on 15/4/7.
//  Copyright (c) 2015年 OU. All rights reserved.
//

#import "OUTabBarController.h"
#import "OUProfileViewController.h"
#import "OUMessageCenterViewController.h"
#import "OUDiscoverViewController.h"
#import "OUHomeViewController.h"
#import "OUNavigationController.h"

@interface OUTabBarController ()

@end

@implementation OUTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    OUHomeViewController *homeVC=[[OUHomeViewController alloc] init];
    [self addChildVC:homeVC title:@"首页" image:@"tabbar_home" selectImage:@"tabbar_home_selected"];
    
    OUMessageCenterViewController *messageCenterVC=[[OUMessageCenterViewController alloc] init];
    [self addChildVC:messageCenterVC title:@"消息" image:@"tabbar_home" selectImage:@"tabbar_home_selected"];

    OUDiscoverViewController *discoverVC=[[OUDiscoverViewController alloc] init];
    [self addChildVC:discoverVC title:@"发现" image:@"tabbar_home" selectImage:@"tabbar_home_selected"];

    OUProfileViewController *profileVC=[[OUProfileViewController alloc] init];
    [self addChildVC:profileVC title:@"我" image:@"tabbar_home" selectImage:@"tabbar_home_selected"];

    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  添加子控制器
 *
 *  @param childVC     <#childVC description#>
 *  @param title       <#title description#>
 *  @param image       <#image description#>
 *  @param selectImage <#selectImage description#>
 */
- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image
       selectImage:(NSString *) selectImage{
    childVC.title=title;//同时设置tabbar和navigationBar的文字
    childVC.tabBarItem.image=[UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage=[UIImage imageNamed:selectImage];
    childVC.view.backgroundColor=[UIColor redColor];
    OUNavigationController *nac=[[OUNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nac];
    

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
