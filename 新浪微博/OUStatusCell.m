//
//  OUStatusCell.m
//  新浪微博
//
//  Created by o3 on 15/4/23.
//  Copyright (c) 2015年 OU. All rights reserved.
//

#import "OUStatusCell.h"
#import "OUStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "OUStatus.h"
#import "OUUser.h"
#import "OUPhoto.h"
@interface OUStatusCell()
@property (nonatomic,strong) UIView *originalView;
@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *nameLable;
@property (nonatomic,strong) UIImageView *vipView;
@property (nonatomic,strong) UILabel *timeLable;
@property (nonatomic,strong) UIImageView *photoView;
@property (nonatomic,strong) UILabel *contentLable;

@property (nonatomic,strong) UIView *retweetView;
@property (nonatomic,strong) UILabel *retweetContentLable;
@property (nonatomic,strong) UIImageView *retweetPhotoView;
@end
@implementation OUStatusCell


+(instancetype) cellWithTableView:(UITableView *)tableView{
    NSString *ID=@"status";
    OUStatusCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[OUStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;

}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setOriginalView];
        [self setRetWeetView];
    }
    return self;
}
/**
 *  初始化原创微博
 */
-(void)setOriginalView{
    //微博整体
    UIView *originalView=[[UIView alloc] init];
    //[originalView setBackgroundColor:[UIColor blueColor]];
    [self.contentView addSubview:originalView];
    self.originalView=originalView;
    
    
    //头像
    UIImageView *iconView=[[UIImageView alloc]init];
    [self.originalView addSubview:iconView];
    self.iconView=iconView;
    
    //昵称
    UILabel *nameLable=[[UILabel alloc]init];
    //这里的字体和sizeWithMax的字体要一致
    nameLable.font=OUStatusCellNameFont;
    [self.originalView addSubview:nameLable];
    self.nameLable=nameLable;
    
    //vip图标
    UIImageView *vipView=[[UIImageView alloc] init];
    [self.originalView addSubview:vipView];
    self.vipView=vipView;
    
    //时间
    UILabel *timeLable=[[UILabel alloc] init];
    timeLable.font=OUStatusCellTimeFont;
    [self.originalView addSubview:timeLable];
    self.timeLable=timeLable;
    
    //正文
    UILabel *contentLable=[[UILabel alloc]init];
    contentLable.font=OUStatusCellContentFont;
    [self.originalView addSubview:contentLable];
    
    //配图
    UIImageView *photoView=[[UIImageView alloc]init];
    self.photoView=photoView;
    [self.originalView addSubview:photoView];
    
    contentLable.numberOfLines = 0;
    self.contentLable=contentLable;
    
    
}
/**
 *  初始化转发微博整体
 */
-(void)setRetWeetView{
    //转发微博整体
    UIView *retweetView=[[UIView alloc] init];
    [retweetView setBackgroundColor:OUColor(240, 240, 240)];
    [self.contentView addSubview:retweetView];
    self.retweetView=retweetView;
    //正文
    UILabel *retweetContentLable=[[UILabel alloc]init];
    retweetContentLable.font=OUStatusCellContentFont;
    [self.retweetView addSubview:retweetContentLable];
    retweetContentLable.numberOfLines = 0;
    self.retweetContentLable=retweetContentLable;
    //配图
    UIImageView *retweetPhotoView=[[UIImageView alloc]init];
    self.retweetPhotoView=retweetPhotoView;
    [self.retweetView addSubview:retweetPhotoView];
}

-(void) setStatusFrame:(OUStatusFrame *)statusFrame{
    _statusFrame=statusFrame;
    
    self.originalView.frame=statusFrame.originalViewF;

    self.iconView.frame=statusFrame.iconViewF;
    OUStatus *status=statusFrame.status;
    OUUser *user=status.user;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"tabbar_profile"]];
    
    if (user.isVip) {
        self.vipView.hidden = NO;
        
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        
        self.nameLable.textColor = [UIColor orangeColor];
    } else {
        self.nameLable.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    self.nameLable.text=user.name;
    self.nameLable.frame=statusFrame.nameLabelF;
    
    self.timeLable.text=status.created_at;
    self.timeLable.frame=statusFrame.timeLabelF;
    
    self.contentLable.text=status.text;
    self.contentLable.frame=statusFrame.contentLableF;
    
    //原创微博配图
    if (status.pic_urls.count>0) {
        OUPhoto *photo=status.pic_urls[0];
        //配图
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"tabbar_profile"]];
        self.photoView.frame=statusFrame.photoViewF;
        self.photoView.hidden=NO;//避免cell被重用，导致无图片时也显示的问题
    }else{
        self.photoView.hidden=YES;
    }
    //转发微博
    if (status.retweeted_status) {
        self.retweetView.frame=statusFrame.retweetViewF;
        self.retweetContentLable.text=[NSString stringWithFormat:@"%@ : %@",status.retweeted_status.user.name,status.retweeted_status.text];
        self.retweetContentLable.frame=statusFrame.retweetContentLableF;
        self.retweetView.hidden=NO;
        
        if (status.retweeted_status.pic_urls.count) {
            OUPhoto *photo=status.retweeted_status.pic_urls[0];
            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"tabbar_profile"]];
            self.retweetPhotoView.frame=statusFrame.retweetPhotoF;
            self.retweetPhotoView.hidden=NO;//避免cell被重用，导致无图片时也显示的问题
        }else{
            self.photoView.hidden=YES;
        }
    }else{
        self.retweetView.hidden=YES;
    }
    
    }
@end
