
//
//  OUAccountTool.m
//  新浪微博
//
//  Created by o3 on 15/4/13.
//  Copyright (c) 2015年 OU. All rights reserved.
//
#define OUAccountSavePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]
#import "OUAccountTool.h"
#import "OUAccount.h"

@implementation OUAccountTool

/**
 *  保存账户信息到沙盒
 *
 *  @param account <#account description#>
 */
+(void)saveAccount:(OUAccount *)account{
    [NSKeyedArchiver archiveRootObject:account toFile:OUAccountSavePath];
}
/**
 *  从沙盒中获取账号信息
 *
 *  @return <#return value description#>
 */
+(OUAccount *)account{
    OUAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:OUAccountSavePath];
    long long expires_in=[account.expires_in longLongValue];
    NSDate *expiresTime=[account.createTime dateByAddingTimeInterval:expires_in];
    NSDate *now=[NSDate date];
    //比较两个时间
    NSComparisonResult result=[expiresTime compare:now];
    if (result!=NSOrderedDescending) {
        return nil;
    }
    return account;
}
@end
