//
//  SelectedCell.m
//  MeiZhiTableView
//
//  Created by Hailong Yu on 15/6/7.
//  Copyright (c) 2015年 zhongkeyun. All rights reserved.
//

#import "SelectedCell.h"

@implementation SelectedCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        
        UIButton* button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        button.frame = CGRectMake(self.width - 20, 0, 20, 20);
        button.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
        
        button.alpha = 0.4;
        button.layer.cornerRadius = button.height / 2.0;
        button.layer.masksToBounds = YES;
        button.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:button];
        
        [button addTarget:self action:@selector(clicked:) forControlEvents:(UIControlEventTouchUpInside)];
        
//    按钮上画一条线
        UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, button.width * 0.7, 5)];
        lineView.backgroundColor = [UIColor whiteColor];
        lineView.userInteractionEnabled = NO;
        lineView.center = CGPointMake(button.width / 2.0, button.height / 2.0);
        
        [button addSubview:lineView];
    }
    
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.label.bounds = self.bounds;
    
    
}

-(void)clicked:(UIButton*)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedCellDidClicked:)]) {
        [self.delegate selectedCellDidClicked:self];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
