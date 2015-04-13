//
//  OUAccount.h
//  新浪微博
//
//  Created by o3 on 15/4/13.
//  Copyright (c) 2015年 OU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OUAccount : NSObject<NSCopying>
/**
 *  用于调用access_token，接口获取授权后的access token
 */
@property (nonatomic,copy) NSString *access_token;
/**
 *  access_token的生命周期，单位是秒数
 */
@property (nonatomic,assign) NSNumber *expires_in;
/**
 *  当前授权用户的UID
 */
@property (nonatomic,copy) NSString *uid;

@property (nonatomic,strong) NSDate *createTime;

+(instancetype) accountWithDict:(NSDictionary *) dict;
@end
