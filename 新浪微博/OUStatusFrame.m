//
//  OUStatusFrame.m
//  新浪微博
//
//  Created by o3 on 15/4/23.
//  Copyright (c) 2015年 OU. All rights reserved.
//

#import "OUStatusFrame.h"
#import "OUUser.h"
#import "OUStatus.h"
#define OUStatusCellBorderW 10
@implementation OUStatusFrame


-(void) setStatus:(OUStatus *)status{
    _status=status;
    
    OUUser *user=status.user;
    CGFloat cellWidth=[UIScreen mainScreen].bounds.size.width;
    //头像
    CGFloat iconX=OUStatusCellBorderW;
    CGFloat iconY=OUStatusCellBorderW;
    CGFloat iconW=35;
    self.iconViewF=CGRectMake(iconX, iconY, iconW, iconW);
    
    //正文
    CGFloat contentX=iconX;
    CGFloat contentY=CGRectGetMaxY(self.iconViewF);
    self.contentLableF=CGRectMake(contentX, contentY, cellWidth, 100);
    
    self.cellHeight=200;
}
@end
