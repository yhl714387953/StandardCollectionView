//
//  MZHeaderReusableView.m
//  MeiZhiTableView
//
//  Created by Hailong Yu on 15/6/6.
//  Copyright (c) 2015年 zhongkeyun. All rights reserved.
//

#import "MZHeaderReusableView.h"

@implementation MZHeaderReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self initSubViews];
    }
    
    return self;
}

-(void)initSubViews{
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, self.frame.size.height)];
    [self addSubview:self.nameLabel];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    
}
@end
