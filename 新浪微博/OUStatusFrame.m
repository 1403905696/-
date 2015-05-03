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
    
    //配图
    CGFloat originalH=0;
    if (status.pic_urls.count>0) {
        CGFloat photoX=OUStatusCellBorderW;
        CGFloat photoY=CGRectGetMaxY(self.contentLableF)+OUStatusCellBorderW;
        CGFloat photoW=100;
        CGFloat photoH=100;
        self.photoViewF=CGRectMake(photoX, photoY, photoW, photoW);
        originalH=CGRectGetMaxY(self.photoViewF)+OUStatusCellBorderW;
    }else{
        originalH=CGRectGetMaxY(self.contentLableF)+OUStatusCellBorderW;
    }
    
    //原创微博整体
    CGFloat originalX=0;
    CGFloat originalY=0;
    CGFloat originalW=cellWidth;
    self.originalViewF=CGRectMake(originalX, originalY, originalW, originalH);
    
    //转发微博整体
    if (status.retweeted_status) {
        //转发微博正文
        CGFloat retweetContentX=OUStatusCellBorderW;
        CGFloat retweetContentY=OUStatusCellBorderW;
        CGSize  retweetSize=[self sizeWithText:status.retweeted_status.text font:OUStatusCellContentFont maxW:maxW];
        self.retweetContentLableF=(CGRect){{retweetContentX,retweetContentY},retweetSize};
        
        CGFloat retweetH=0;
        if (status.retweeted_status.pic_urls.count>0) {
            CGFloat retweetPhotoX=OUStatusCellBorderW;
            CGFloat retweetPhotoY=CGRectGetMaxY(self.retweetContentLableF)+OUStatusCellBorderW;
            CGFloat retweetPhotoW=100;
            CGFloat retweetPhotoH=100;
            self.retweetPhotoF=CGRectMake(retweetPhotoX, retweetPhotoY, retweetPhotoW, retweetPhotoH);
            retweetH=CGRectGetMaxY(self.retweetPhotoF)+OUStatusCellBorderW;
        }else{
            retweetH=CGRectGetMaxY(self.retweetContentLableF)+OUStatusCellBorderW;
        }
        
        //整体
        CGFloat retweetX=iconX;
        CGFloat retweetY=CGRectGetMaxY(self.originalViewF);
        CGFloat retweetW=cellWidth;
        self.retweetViewF=CGRectMake(retweetX,retweetY,retweetW,retweetH);
        self.cellHeight=CGRectGetMaxY(self.retweetViewF);
    }else{
        self.cellHeight=CGRectGetMaxY(self.originalViewF);
    }
    
    
    
    
}
@end
