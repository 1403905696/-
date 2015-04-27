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

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW{
    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName]=font;
    CGSize maxSize=CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine |
            NSStringDrawingUsesLineFragmentOrigin |
            NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}

-(void) setStatus:(OUStatus *)status{
    _status=status;
    
    OUUser *user=status.user;
    CGFloat cellWidth=[UIScreen mainScreen].bounds.size.width;
    //头像
    CGFloat iconX=OUStatusCellBorderW;
    CGFloat iconY=OUStatusCellBorderW;
    CGFloat iconW=35;
    self.iconViewF=CGRectMake(iconX, iconY, iconW, iconW);
    
    //昵称
    CGFloat nameX=CGRectGetMaxX(self.iconViewF)+OUStatusCellBorderW;
    CGFloat nameY=iconY;
    CGSize nameSize=[self sizeWithText:user.name font:OUStatusCellNameFont];
    self.nameLabelF=(CGRect){{nameX,nameY},nameSize};
    
    //vip
    if (user.isVip) {
        CGFloat vipX=CGRectGetMaxX(self.nameLabelF)+OUStatusCellBorderW;
        CGFloat vipY=nameY;
        CGFloat vipH=nameSize.height;
        CGFloat vipW=14;
        self.vipViewF=CGRectMake(vipX, vipY, vipW, vipH);
        
    }
    
    //时间
    CGFloat timeX=nameX;
    CGFloat timeY=CGRectGetMaxY(self.nameLabelF)+OUStatusCellBorderW;
    CGSize timeSize=[self sizeWithText:status.created_at font:OUStatusCellNameFont];
    self.timeLabelF=(CGRect){{timeX,timeY},timeSize};
    
    //正文
    CGFloat contentX=iconX;
    CGFloat contentY=MAX(CGRectGetMaxY(self.iconViewF),CGRectGetMaxY(self.timeLabelF))+OUStatusCellBorderW;
    CGFloat maxW=cellWidth-2*contentX;
    CGSize contentSize=[self sizeWithText:status.text font:OUStatusCellContentFont maxW:maxW];
    self.contentLableF=(CGRect){{contentX,contentY},contentSize};
    
    //整体
    CGFloat originalX=0;
    CGFloat originalY=0;
    CGFloat originalW=cellWidth;
    CGFloat originalH=CGRectGetMaxY(self.contentLableF)+OUStatusCellBorderW;
    
    self.originalViewF=CGRectMake(originalX, originalY, originalW, originalH);
    self.cellHeight=CGRectGetMaxY(self.originalViewF);
}
@end
