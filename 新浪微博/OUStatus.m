
//
//  OUStatus.m
//  新浪微博
//
//  Created by o3 on 15/4/18.
//  Copyright (c) 2015年 OU. All rights reserved.
//

#import "OUStatus.h"
#import "OUUser.h"
@implementation OUStatus

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        self.idstr=dict[@"idstr"];
        self.text=dict[@"text"];
        self.user=[OUUser userWithDict:dict[@"user"]];
    }
    return self;
}

+(instancetype)statusWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
