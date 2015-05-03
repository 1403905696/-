
//
//  OUTitleButton.m
//  新浪微博
//
//  Created by o3 on 15/4/14.
//  Copyright (c) 2015年 OU. All rights reserved.
//

#import "OUTitleButton.h"

@implementation OUTitleButton

-(id) initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.height=30;
        self.width=100;
    }
    return self;
    //test1
    //test2
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //设置文字、图片的位置
    self.titleLabel.x=self.imageView.x;
    self.imageView.x=CGRectGetMaxX(self.titleLabel.frame);
}
-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
}
-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    [self sizeToFit];
}
@end
