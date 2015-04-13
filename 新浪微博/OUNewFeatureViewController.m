//
//  OUNewFeatureViewController.m
//  新浪微博
//
//  Created by o3 on 15/4/12.
//  Copyright (c) 2015年 OU. All rights reserved.
//

#import "OUNewFeatureViewController.h"
#import "OUTabBarController.h"

#define OUNewFeatureCount 4
@interface OUNewFeatureViewController ()
@property (nonatomic,assign) UIScrollView *scrollView;
@property (nonatomic,assign) UIPageControl *pageControl;
@end

@implementation OUNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.创建scrollView
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=self.view.bounds;
    [self.view addSubview:scrollView];
    scrollView.delegate=self;
    self.scrollView=scrollView;
    
    //2.往scrollView中添加图片
    CGFloat scrollViewW=scrollView.width;
    CGFloat scrollViewH=scrollView.height;
    for (int i=0; i<OUNewFeatureCount; i++) {
        UIImageView *imageView=[[UIImageView alloc] init];
        imageView.x=i*scrollViewW;
        imageView.height=scrollViewH;
        imageView.width=scrollViewW;
        NSString *imageName=[NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image=[UIImage imageNamed:imageName];
        
        [scrollView addSubview:imageView];
        
        //如果是最后一个imageView，则要作特殊处理
        if (i==OUNewFeatureCount-1) {
            [self setupLastImageView:imageView];
        }

    }
    
    //3.设置scrollView的其他属性
    scrollView.contentSize=CGSizeMake(OUNewFeatureCount*scrollViewW, 0);
    scrollView.bounces=NO;//取消弹簧效果
    scrollView.pagingEnabled=YES;
    scrollView.showsHorizontalScrollIndicator=NO;//取消水平方向的滚动条
    
    //4.添加pageControl实现分页
    UIPageControl *pageControl=[[UIPageControl alloc] init];
    pageControl.numberOfPages=OUNewFeatureCount;
    pageControl.centerX=scrollViewW*0.5;
    pageControl.centerY=scrollViewH-50;
    //必须设置当前页码指示器及其他页码指示器的颜色
    pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    pageControl.pageIndicatorTintColor=[UIColor blackColor];
    [self.view addSubview:pageControl];
    self.pageControl=pageControl;
    
}
/**
 *  设置最后一张图片
 */
-(void)setupLastImageView:(UIImageView *) imageView{
    //1.添加分享功能按钮
    imageView.userInteractionEnabled=YES;
    UIButton *shareBtn=[[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    //设置文字与最左边的间距
    shareBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
    shareBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    //设置按钮标题字体颜色
    [shareBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    shareBtn.width=200;
    shareBtn.height=50;
    shareBtn.centerX=imageView.width*0.5;
    shareBtn.centerY=imageView.height*0.7;
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];
    
    //2.添加开始按钮
    UIButton *enterHomeBtn=[[UIButton alloc] init];
    [enterHomeBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [enterHomeBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [enterHomeBtn setTitle:@"开始" forState:UIControlStateNormal];
    enterHomeBtn.width=100;
    enterHomeBtn.height=30;
    enterHomeBtn.centerX=imageView.width*0.5;
    enterHomeBtn.centerY=imageView.height*0.8;
    [enterHomeBtn addTarget:self action:@selector(enterHomeBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:enterHomeBtn];
    
    
}

-(void)shareBtnClick:(UIButton *)shareBtn{
    NSLog(@"点击了分享按钮");
    shareBtn.selected=!shareBtn.selected;
}
-(void)enterHomeBtnCilck{
    NSLog(@"进入主页");
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    window.rootViewController=[[OUTabBarController alloc] init];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UIScrollViewDelegate delegate
-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    //scrollView滚动结束后，设置pageControl当前页码
    double pageIndex=scrollView.contentOffset.x/scrollView.width;
    self.pageControl.currentPage=(int)(pageIndex+0.5);
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
