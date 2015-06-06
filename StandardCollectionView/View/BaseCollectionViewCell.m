//
//  BaseCollectionViewCell.m
//  MeiZhiTableView
//
//  Created by Hailong Yu on 15/6/6.
//  Copyright (c) 2015年 zhongkeyun. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:self.label];
    }
    
    return self;
}

@end
