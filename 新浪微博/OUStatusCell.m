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
@interface OUStatusCell()
@property (nonatomic,strong) UIView *originalView;
@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *nameLable;
@property (nonatomic,strong) UIImageView *vipView;
@property (nonatomic,strong) UILabel *timeLable;
@property (nonatomic,strong) UIView *photoView;
@property (nonatomic,strong) UILabel *contentLable;
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
        //微博整体
        UIView *originalView=[[UIView alloc] init];
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
        
        contentLable.numberOfLines = 0;
        self.contentLable=contentLable;
        
    }
    return self;
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
    
    }
@end
