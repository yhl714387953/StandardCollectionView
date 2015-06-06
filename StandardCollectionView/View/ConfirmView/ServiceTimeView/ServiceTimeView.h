//
//  ServiceTimeView.h
//  MeiZhiTableView
//
//  Created by Hailong Yu on 15/6/7.
//  Copyright (c) 2015年 zhongkeyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarHeader.h"
#import "ServiceTimeCell.h"
#import "ServiceHourView.h"

@interface ServiceTimeView : UIView<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UILabel* monthLabel;
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) NSMutableArray* dataSource;//需要展示选中的item，数据源

@property (nonatomic, strong) ServiceHourView* serviceHourView;

-(void)reloadData;

@end
