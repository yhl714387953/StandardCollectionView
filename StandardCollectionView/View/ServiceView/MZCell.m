//
//  MZCell.m
//  MeiZhiTableView
//
//  Created by Hailong Yu on 15/6/6.
//  Copyright (c) 2015年 zhongkeyun. All rights reserved.
//

#import "MZCell.h"



@implementation MZCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.label.textAlignment = NSTextAlignmentCenter;
    }
    
    return self;
}

#warning 若子类重写了父类的方法，记得调用[super methodName] 要么就别起一样的名字
-(void)layoutSubviews{
    [super layoutSubviews];
    self.label.bounds = self.bounds;


}

-(void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    self.backgroundColor = isSelected ? [UIColor redColor] : [UIColor grayColor];
}

@end
