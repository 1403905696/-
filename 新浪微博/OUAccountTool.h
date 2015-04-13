//
//  OUAccountTool.h
//  新浪微博
//
//  Created by o3 on 15/4/13.
//  Copyright (c) 2015年 OU. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OUAccount;
@interface OUAccountTool : NSObject
/**
 *  保存账户信息到沙盒
 *
 *  @param account <#account description#>
 */
+(void)saveAccount:(OUAccount *) account;
/**
 *  从沙盒中获取账号信息
 *
 *  @return <#return value description#>
 */
+(OUAccount *)account;
@end
