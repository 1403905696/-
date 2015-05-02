//
//  OUStatus.h
//  新浪微博
//
//  Created by o3 on 15/4/18.
//  Copyright (c) 2015年 OU. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OUUser;

@interface OUStatus : NSObject
/**
 *  字符串型的微博ID
 */
@property (nonatomic,copy) NSString *idstr;
/**
 *  微博信息内容
 */
@property (nonatomic,copy) NSString *text;
/**
 *  微博作者的用户信息字段
 */
@property (nonatomic,strong) OUUser *user;

@property (nonatomic,strong) NSString *created_at;

/**
 *  微博来源
 */
@property (nonatomic,strong) NSString *source;

@property (nonatomic,strong) NSArray *pic_urls;

-(instancetype) initWithDict:(NSDictionary *)dict;
+(instancetype) statusWithDict:(NSDictionary *)dict;
@end
