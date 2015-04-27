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
#import "OULoadMoreFooter.h"
#import "OUStatusCell.h"
#import "OUStatusFrame.h"
#import "MJExtension.h"
@interface OUHomeViewController ()

@property (nonatomic,strong) NSMutableArray *statusFrames;


@end

@implementation OUHomeViewController

-(NSMutableArray *)statusFrames{
    if (!_statusFrames) {
        self.statusFrames=[NSMutableArray array];
    }
    return _statusFrames;
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
    
    //集成上拉加载更多的功能
    [self setupUpRefresh];
    //获取最新微博信息
    //[self loadNewestStatuses];
}

-(void)setupUpRefresh{
    OULoadMoreFooter *footer=[OULoadMoreFooter footer];
    footer.hidden=YES;
    self.tableView.tableFooterView=footer;
}

/**
 *  将HWStatus模型转为HWStatusFrame模型
 */
- (NSArray *)stausFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (OUStatus *status in statuses) {
        OUStatusFrame *f = [[OUStatusFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
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
    OUStatus *status=[self.statusFrames.firstObject status];
    if (status) {
        params[@"since_id"]=status.idstr;
    }
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //将获取到的微博字典数组转为模型数组
//        NSArray *dictArray=responseObject[@"statuses"];
//        
//        NSMutableArray *newStatusesArray=[NSMutableArray array];
//        for (NSDictionary *dict in dictArray) {
//            OUStatus *status=[OUStatus statusWithDict:dict];
//            OUStatusFrame *statusFrame=[[OUStatusFrame alloc] init];
//            statusFrame.status=status;
//            [newStatusesArray addObject:statusFrame];
//        }
        NSArray *newStatusesArray=[OUStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSRange range=NSMakeRange(0, newStatusesArray.count);
        NSIndexSet *set=[NSIndexSet indexSetWithIndexesInRange:range];
        
        NSArray *newStatusFramesArray=[self stausFramesWithStatuses:newStatusesArray];
        [self.statusFrames insertObjects:newStatusFramesArray atIndexes:set];
        
        //刷新表格
        [self.tableView reloadData];
        [refreshControl endRefreshing];
        
        [self showNewestStatusesCount:newStatusFramesArray.count];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"加载出错");
    }];
}
/**
 *  加载更多的微博数据
 */
-(void)loadMoreStatuses{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    OUAccount *account=[OUAccountTool account];
    params[@"access_token"]=account.access_token;
    
    //取出刚加载的微博里最前面的一条，获取比此更新的微博
    OUStatus *lastStatus=[self.statusFrames.lastObject status];
    if (lastStatus) {
        long long maxID=lastStatus.idstr.longLongValue-1;
        params[@"max_id"]=@(maxID);
    }
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //将获取到的微博字典数组转为模型数组
//        NSArray *dictArray=responseObject[@"statuses"];
//        
//        NSMutableArray *newStatusesArray=[NSMutableArray array];
//        for (NSDictionary *dict in dictArray) {
//            OUStatus *status=[OUStatus statusWithDict:dict];
//            OUStatusFrame *statusFrame=[[OUStatusFrame alloc] init];
//            statusFrame.status=status;
//            [newStatusesArray addObject:statusFrame];        }
        NSArray *newStatusesArray=[OUStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSArray *newStatusFramesArray=[self stausFramesWithStatuses:newStatusesArray];
        [self.statusFrames addObjectsFromArray:newStatusFramesArray];
        
        //刷新表格
        [self.tableView reloadData];
         
         self.tableView.tableFooterView.hidden=YES;
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"加载出错");
        self.tableView.tableFooterView.hidden=YES;
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statusFrames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //OUStatus *status=self.statuses[indexPath.row];
    
    //OUUser *user=status.user;
    
    OUStatusFrame *statuFrame=self.statusFrames[indexPath.row];
    OUStatusCell *cell=[OUStatusCell cellWithTableView:tableView];
    cell.statusFrame=statuFrame;
    return cell;
}

/**
 *  移到最后一列时，显示上拉刷新控件
 *
 *  @param scrollView <#scrollView description#>
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.statusFrames.count==0 ||self.tableView.tableFooterView.isHidden==NO) {
        return;
    }
    CGFloat offsetY=scrollView.contentOffset.y;
    CGFloat judgeOffsetY=scrollView.contentSize.height+scrollView.contentInset.bottom-scrollView.height-self.tableView.tableFooterView.height;
    if (offsetY>=judgeOffsetY) {
        [self loadMoreStatuses];
        self.tableView.tableFooterView.hidden=NO;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OUStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}
@end
