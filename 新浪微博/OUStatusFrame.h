//
//  OUStatusFrame.h
//  新浪微博
//
//  Created by o3 on 15/4/23.
//  Copyright (c) 2015年 OU. All rights reserved.
//

#import <Foundation/Foundation.h>
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
@end
