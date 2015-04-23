//
//  OUStatusCell.h
//  新浪微博
//
//  Created by o3 on 15/4/23.
//  Copyright (c) 2015年 OU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OUStatusFrame;
@interface OUStatusCell : UITableViewCell

@property (nonatomic,strong) OUStatusFrame *statusFrame;

+(instancetype) cellWithTableView:(UITableView *)tableView;
@end
