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
        [self initSubViews];
    }
    
    return self;
}

-(void)initSubViews{

    self.nameLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLabel];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.nameLabel.bounds = self.bounds;


}

-(void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    self.backgroundColor = isSelected ? [UIColor redColor] : [UIColor grayColor];
}

@end
