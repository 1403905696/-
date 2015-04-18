
//
//  OUUser.m
//  新浪微博
//
//  Created by o3 on 15/4/18.
//  Copyright (c) 2015年 OU. All rights reserved.
//

#import "OUUser.h"

@implementation OUUser

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        self.idstr=dict[@"idstr"];
        self.name=dict[@"name"];
        self.profile_image_url=dict[@"profile_image_url"];
    }
    return self;
}

+(instancetype)userWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
