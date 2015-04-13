//
//  OUOAuthViewController.m
//  新浪微博
//
//  Created by o3 on 15/4/12.
//  Copyright (c) 2015年 OU. All rights reserved.
//

#import "OUOAuthViewController.h"
#import "AFNetworking.h"
#import "OUAccount.h"
#import "OUAccountTool.h"
#import "OUNewFeatureViewController.h"
@interface OUOAuthViewController ()<UIWebViewDelegate>

@end

@implementation OUOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.添加UIWebView
    UIWebView *webView=[[UIWebView alloc] init];
    webView.frame=self.view.bounds;
    webView.delegate=self;
    [self.view addSubview:webView];
    
    NSString *client_id=@"2205441077";
    NSString *redirect_uri=@"http://www.cnblogs.com/CoderO3/";
    NSString *url=[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",client_id,redirect_uri];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark UIWebViewDelegate
-(void) webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"当前请求的界面:%@",webView.request.URL.absoluteString);
}
-(void) webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"当前请求的界面:%@",webView.request.URL.absoluteString);
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *url=request.URL.absoluteString;
    NSRange range=[url rangeOfString:@"code="];
    if (range.length!=0) {
        long fromIndex=range.location+range.length;
        NSString *code=[url substringFromIndex:(NSInteger)fromIndex];
        [self accessTokenWithCode:code];
    }
    return YES;
}
/**
 *  根据授权的Request Token获取Access Token
 *
 *  @param code <#code description#>
 */
-(void) accessTokenWithCode:(NSString *)code{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"2205441077";
    params[@"client_secret"] = @"7e913ee00b211e434aac4717338b4dab";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://www.cnblogs.com/CoderO3/";
    params[@"code"] = code;

    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:params  success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        //保存账户信息
        OUAccount *account=[OUAccount accountWithDict:responseObject];
        [OUAccountTool saveAccount:account];
        
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        //切换主控制器
        [window switchRootViewController];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
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
