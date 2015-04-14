//
//  OUHomeViewController.m
//  新浪微博
//
//  Created by o3 on 15/4/7.
//  Copyright (c) 2015年 OU. All rights reserved.
//

#import "OUHomeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "OUTitleButton.h"
#import "AFNetworking.h"
#import "OUAccount.h"
#import "OUAccountTool.h"
@interface OUHomeViewController ()

@end

@implementation OUHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏上面的内容

    //设置导航栏
    [self setupNav];
    
    //获取用户信息
    [self setupUserInfo];
}

/**
 *  设置导航栏
 */
-(void)setupNav{
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithTarget:self action:@selector(friendSearchClick) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted" ];
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithTarget:self action:@selector(popClick) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    OUTitleButton *titleBtn=[[OUTitleButton alloc] init];
    [titleBtn setTitle:@"coder_o3" forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(titleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView=titleBtn;
}
/**
 *  获取用户信息
 */
-(void)setupUserInfo{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    OUAccount *account = [OUAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] =account.access_token;//account.access_token;
    params[@"uid"] = account.uid;
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        //重写设置用户名
        UIButton *titleBtn=(UIButton *)self.navigationItem.titleView;
        [titleBtn setTitle:responseObject[@"name"] forState:UIControlStateNormal];
        account.userName=responseObject[@"name"];
        [OUAccountTool saveAccount:account];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];

}
/**
 *  添加好友按钮被点击
 */
-(void)friendSearchClick{
    NSLog(@"friendSearchClick被点击");
}
-(void)popClick{
    NSLog(@"popClick被点击");
}
-(void)titleBtnClick{
    NSLog(@"titleBtnClick被点击");
}
/**
 *  内存警告
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --Table view data source
/*
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}*/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc] init];
    cell.textLabel.text=@"111";
    cell.textLabel.backgroundColor=[UIColor blackColor];
    return cell;
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
