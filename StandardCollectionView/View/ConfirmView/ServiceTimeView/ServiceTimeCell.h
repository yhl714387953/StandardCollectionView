//
//  ServiceTimeCell.h
//  MeiZhiTableView
//
//  Created by Hailong Yu on 15/6/7.
//  Copyright (c) 2015年 zhongkeyun. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "CarHeader.h"

@interface ServiceTimeCell : BaseCollectionViewCell

@property (nonatomic, strong) NSMutableDictionary* infDic;//这个cell的数据源
@property (nonatomic, strong) UILabel* weekLabel;//星期label
@property (nonatomic, strong) UILabel* dayLabel;//日期label

@property (nonatomic, strong) UIView* promptView;//如果对应日期下有选中的服务会在下面显示小红点的提示

@property (nonatomic, strong) UIView* backView;//北京带圈的view
@end
