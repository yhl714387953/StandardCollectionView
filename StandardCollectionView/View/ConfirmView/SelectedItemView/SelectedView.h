//
//  SelectedView.h
//  MeiZhiTableView
//
//  Created by Hailong Yu on 15/6/6.
//  Copyright (c) 2015年 zhongkeyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarHeader.h"
#import "SelectedCell.h"

@interface SelectedView : UIView <UICollectionViewDataSource, UICollectionViewDelegate, SelectedCellDelegate>
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) NSMutableArray* dataSource;//需要展示选中的item，数据源

-(void)reloadData;
@end
