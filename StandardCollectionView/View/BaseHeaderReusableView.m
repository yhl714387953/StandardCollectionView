//
//  BaseHeaderReusableView.m
//  MeiZhiTableView
//
//  Created by Hailong Yu on 15/6/7.
//  Copyright (c) 2015年 zhongkeyun. All rights reserved.
//

#import "BaseHeaderReusableView.h"

@implementation BaseHeaderReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, self.frame.size.height)];
        [self addSubview:self.label];
    }
    
    return self;
}

@end
