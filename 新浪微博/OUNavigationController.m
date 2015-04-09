//
//  OUNavigationController.m
//  新浪微博
//
//  Created by o3 on 15/4/7.
//  Copyright (c) 2015年 OU. All rights reserved.
//

#import "OUNavigationController.h"

@interface OUNavigationController ()

@end

@implementation OUNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/**
 *  重写这个方法，可以拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 *  @param animated       <#animated description#>
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed=YES;
        
        //设置左边的返回按钮
        viewController.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back"  highImage:@"navigationbar_back_highlighted"];
        
        
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}
@end
