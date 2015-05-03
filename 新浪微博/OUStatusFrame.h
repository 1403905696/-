//
//  OUStatusFrame.h
//  新浪微博
//
//  Created by o3 on 15/4/23.
//  Copyright (c) 2015年 OU. All rights reserved.
//

#import <Foundation/Foundation.h>
// 昵称字体
#define OUStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define OUStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define OUStatusCellSourceFont OUStatusCellTimeFont
// 正文字体
#define OUStatusCellContentFont [UIFont systemFontOfSize:14]
@class OUStatus;
@interface OUStatusFrame : NSObject

/**
 *  数据模型
 */
@property (nonatomic,strong) OUStatus *status;

/**
 *控件Frame
 */
/**
 *  原创微博整体
 */
@property (nonatomic,assign) CGRect originalViewF;

/**
 *  头像
 */
@property (nonatomic,assign) CGRect iconViewF;

/**
 *  vip图标
 */
@property (nonatomic,assign) CGRect vipViewF;
/**
 *  配图
 */
@property (nonatomic,assign) CGRect photoViewF;

/**
 *  昵称
 */
@property (nonatomic,assign) CGRect nameLabelF;

/**
 *  时间
 */
@property (nonatomic,assign) CGRect timeLabelF;
/**
 *  来源
 */
@property (nonatomic,assign) CGRect sourceLabelF;
/**
 *正文
 */
@property (nonatomic,assign) CGRect contentLableF;

/**
 *  cell高度
 */
@property (nonatomic,assign) CGFloat cellHeight;

/**
 * 转发微博整体
 */
@property (nonatomic,assign) CGRect retweetViewF;
/**
 *  转发微博正文
 */
@property (nonatomic,assign) CGRect retweetContentLableF;
/**
 *  转发微博配图
 */
@property (nonatomic,assign) CGRect retweetPhotoF;
@end
