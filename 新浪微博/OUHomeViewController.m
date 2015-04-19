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
#import "OUStatus.h"
#import "OUUser.h"
#import "UIImageView+WebCache.h"
@interface OUHomeViewController ()

@property (nonatomic,strong) NSMutableArray *statuses;


@end

@implementation OUHomeViewController

-(NSMutableArray *)statuses{
    if (!_statuses) {
        self.statuses=[NSMutableArray array];
    }
    return _statuses;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏上面的内容

    //设置导航栏
    [self setupNav];
    
    //获取用户信息
    [self setupUserInfo];
    
    //集成下拉刷新功能
    [self setupDownRefresh];
    
    //获取最新微博信息
    //[self loadNewestStatuses];
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
 *  集成下拉刷新功能
 */
-(void)setupDownRefresh{
    UIRefreshControl *refreshControl=[[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(loadNewestStatuses:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    //马上加载数据
    [refreshControl beginRefreshing];
    [self loadNewestStatuses:refreshControl];
    
}

/**
 *  加载最新微博信息
 */
-(void)loadNewestStatuses:(UIRefreshControl *) refreshControl{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    OUAccount *account=[OUAccountTool account];
    params[@"access_token"]=account.access_token;
    
    //取出刚加载的微博里最前面的一条，获取比此更新的微博
    OUStatus *status=self.statuses.firstObject;
    if (status) {
        params[@"since_id"]=status.idstr;
    }
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //将获取到的微博字典数组转为模型数组
        NSArray *dictArray=responseObject[@"statuses"];
        
        NSMutableArray *newStatusesArray=[NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            OUStatus *status=[OUStatus statusWithDict:dict];
            [newStatusesArray addObject:status];
        }
        NSRange range=NSMakeRange(0, newStatusesArray.count);
        NSIndexSet *set=[NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStatusesArray atIndexes:set];
        
        //刷新表格
        [self.tableView reloadData];
        [refreshControl endRefreshing];
        
        [self showNewestStatusesCount:newStatusesArray.count];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"加载出错");
    }];
}

/**
 *  显示最新微博数
 *
 *  @param count <#count description#>
 */
-(void) showNewestStatusesCount:(int)count{
    UILabel *lable=[[UILabel alloc]init];
    lable.height=30;
    lable.width=[UIScreen mainScreen].bounds.size.width;
    [lable setBackgroundColor:[UIColor redColor]];
    if (count==0) {
        lable.text=@"没有新的微博数据，请重试";
    }else{
        lable.text=[NSString stringWithFormat:@"共有%d条微博数据",count];
    }
    lable.y=64-lable.height;
    lable.textAlignment=NSTextAlignmentCenter;
    lable.font=[UIFont systemFontOfSize:16];
    lable.textColor=[UIColor whiteColor];
    [self.navigationController.view insertSubview:lable belowSubview:self.navigationController.navigationBar];
    
    //通过动画，慢慢显示
    [UIView animateWithDuration:1.0 animations:^{
        lable.transform=CGAffineTransformMakeTranslation(0, lable.height);
    } completion:^(BOOL finished) {
        //延迟1秒后，lable再恢复回原来的位置
        [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
            lable.transform=CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [lable removeFromSuperview];
        }];
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
    return self.statuses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *ID=@"status";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    OUStatus *status=self.statuses[indexPath.row];
    OUUser *user=status.user;
    cell.textLabel.text=user.name;
    cell.detailTextLabel.text=status.text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"tabbar_profile"]];
    
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
