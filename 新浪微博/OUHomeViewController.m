//
//  OUHomeViewController.m
//  新浪微博
//
//  Created by o3 on 15/4/7.
//  Copyright (c) 2015年 OU. All rights reserved.
//

#import "OUHomeViewController.h"
#import "UIBarButtonItem+Extension.h"
@interface OUHomeViewController ()

@end

@implementation OUHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏上面的内容
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithTarget:self action:@selector(addFriendClick) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted" ];
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithTarget:self action:@selector(addFriendClick) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
}

-(void)addFriendClick{
    NSLog(@"添加朋友按钮被点击");
}
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
