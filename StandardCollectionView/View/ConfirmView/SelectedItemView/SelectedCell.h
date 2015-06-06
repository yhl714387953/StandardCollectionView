//
//  SelectedCell.h
//  MeiZhiTableView
//
//  Created by Hailong Yu on 15/6/7.
//  Copyright (c) 2015年 zhongkeyun. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "CarHeader.h"

@class SelectedCell;
@protocol SelectedCellDelegate <NSObject>

-(void)selectedCellDidClicked:(SelectedCell*)cell;

@end

@interface SelectedCell : BaseCollectionViewCell
@property (nonatomic, assign) id<SelectedCellDelegate> delegate;

@end
