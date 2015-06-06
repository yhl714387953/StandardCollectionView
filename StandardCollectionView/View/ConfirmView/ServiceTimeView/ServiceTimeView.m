//
//  ServiceTimeView.m
//  MeiZhiTableView
//
//  Created by Hailong Yu on 15/6/7.
//  Copyright (c) 2015年 zhongkeyun. All rights reserved.
//

#import "ServiceTimeView.h"

@implementation ServiceTimeView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.monthLabel];
        [self addSubview:self.collectionView];
        [self addSubview:self.serviceHourView];
    }
    
    return self;
}

#pragma mark -
#pragma mark - Action
-(void)reloadData{
    [self.collectionView reloadData];
    
    if (self.dataSource.count > 0) {//默认第一个选中
        self.serviceHourView.amDataSource = self.dataSource[0][@"am"];
        self.serviceHourView.pmDataSource = self.dataSource[0][@"pm"];
        [self.serviceHourView reloadData];
    }

    self.height = self.monthLabel.height + self.collectionView.height + self.serviceHourView.height;
}

#pragma mark -
#pragma mark - getter
-(UILabel *)monthLabel{
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 40)];
        _monthLabel.textAlignment = NSTextAlignmentRight;
        _monthLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        
        UILabel* leftLabel = [[UILabel alloc] initWithFrame:_monthLabel.bounds];
        leftLabel.textAlignment = NSTextAlignmentLeft;
        leftLabel.text = @"   服务时间";
        [_monthLabel addSubview:leftLabel];
    }
    
    return _monthLabel;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(55, 65);
//        layout.headerReferenceSize = CGSizeMake(kScreenSize.width, 40);
//        layout.minimumInteritemSpacing = 10;
//        layout.minimumLineSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.monthLabel.bottom, self.width, 85) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[ServiceTimeCell class] forCellWithReuseIdentifier:@"cell"];

    }
    
    return _collectionView;
}

-(ServiceHourView *)serviceHourView{
    if (!_serviceHourView) {
        _serviceHourView = [[ServiceHourView alloc] initWithFrame:CGRectMake(0, self.collectionView.bottom, kScreenSize.width, 280)];
        
    }
    
    return _serviceHourView;
}

#pragma mark -
#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ServiceTimeCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSMutableDictionary* dic = self.dataSource[indexPath.item];
    cell.infDic = dic;
    
    [cell setNeedsLayout];
    
    return cell;
}

#pragma mark -
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    for (NSMutableDictionary* dic in self.dataSource) //所有的重置
        [dic setObject:@NO forKey:@"isSelected"];
    
//    自己的是选中状态
    NSMutableDictionary* currentDic = self.dataSource[indexPath.item];
    [currentDic setObject:@YES forKey:@"isSelected"];
    [self.collectionView reloadData];
    
    
//    更新一下子视图
    self.serviceHourView.amDataSource = currentDic[@"am"];
    self.serviceHourView.pmDataSource = currentDic[@"pm"];
    [self.serviceHourView reloadData];
}

#pragma mark -
#pragma mark - setter

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


@end
