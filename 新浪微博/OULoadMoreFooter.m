//
//  OULoadMoreFooter.m
//  新浪微博
//
//  Created by o3 on 15/4/21.
//  Copyright (c) 2015年 OU. All rights reserved.
//

#import "OULoadMoreFooter.h"

@implementation OULoadMoreFooter

+(instancetype)footer{
    return [[[NSBundle mainBundle] loadNibNamed:@"OULoadMoreFooter" owner:nil options:nil] lastObject];
}
@end
