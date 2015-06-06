//
//  ServiceHourView.h
//  MeiZhiTableView
//
//  Created by Hailong Yu on 15/6/7.
//  Copyright (c) 2015年 zhongkeyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceHourVCell.h"
#import "CarHeader.h"

@interface ServiceHourView : UIView<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) NSMutableArray* amDataSource;//上午数据源
@property (nonatomic, strong) NSMutableArray* pmDataSource;//下午数据源

-(void)reloadData;

@end
