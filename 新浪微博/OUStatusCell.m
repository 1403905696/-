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
@property (nonatomic,strong) UIView *vipView;
@property (nonatomic,strong) UIView *photoView;
@property (nonatomic,strong) UILabel *contentLable;
@end
@implementation OUStatusCell



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

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
        
        //正文
        UILabel *contentLable=[[UILabel alloc]init];
        [self.originalView addSubview:contentLable];
        self.contentLable=contentLable;
        
    }
    return self;
}

-(void) setStatusFrame:(OUStatusFrame *)statusFrame{
    _statusFrame=statusFrame;
    self.iconView.frame=statusFrame.iconViewF;
    OUStatus *status=statusFrame.status;
    OUUser *user=status.user;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"tabbar_profile"]];
    
    self.contentLable.text=status.text;
    self.contentLable.frame=statusFrame.contentLableF;
}
@end
