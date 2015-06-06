//
//  ServiceTimeCell.m
//  MeiZhiTableView
//
//  Created by Hailong Yu on 15/6/7.
//  Copyright (c) 2015年 zhongkeyun. All rights reserved.
//

#import "ServiceTimeCell.h"

@implementation ServiceTimeCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width)];
        self.backView.layer.cornerRadius = self.width / 2.0;
        self.backView.layer.masksToBounds = YES;

//        self.backView.layer.borderColor = [UIColor clearColor].CGColor;
        self.backView.layer.borderColor = [UIColor greenColor].CGColor;
        self.backView.layer.borderWidth = 1;
        [self.contentView addSubview:self.backView];
        
        [self configureSubViews];
    }

    return self;
}

-(void)configureSubViews{
    self.weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.width, 15)];
    self.weekLabel.font = [UIFont systemFontOfSize:14];
    self.weekLabel.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:self.weekLabel];
    
    self.dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.weekLabel.left, self.weekLabel.bottom, self.width, 24)];
    self.dayLabel.font = [UIFont systemFontOfSize:22];
    self.dayLabel.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:self.dayLabel];
    
    self.promptView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.promptView.center = CGPointMake(self.width / 2.0, self.width + 5);
    self.promptView.backgroundColor = [UIColor redColor];
    self.promptView.layer.cornerRadius = self.promptView.width / 2.0;
    self.promptView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.promptView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.infDic) {
        self.weekLabel.text = self.infDic[@"week"];
        self.dayLabel.text = self.infDic[@"day"];
        
        self.backView.backgroundColor = [self.infDic[@"isSelected"] boolValue] ? [UIColor redColor] : [UIColor whiteColor];
        
        
//        self.promptView.hidden = ![self.infDic[@"isPrompt"] boolValue];
        self.promptView.hidden = YES;//初始化的时候是隐藏的
//        这里我们需要遍历一下上午和下午是否有选中的
        NSArray* amArr = self.infDic[@"am"];
        NSArray* pmArr = self.infDic[@"pm"];
        for (NSDictionary* dic in amArr) {
            if ([dic[@"isSelected"] boolValue]) {
                self.promptView.hidden = NO;
                break;
            }
        }
        
        for (NSDictionary* dic in pmArr) {
            if ([dic[@"isSelected"] boolValue]) {
                self.promptView.hidden = NO;
                break;
            }
        }
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
