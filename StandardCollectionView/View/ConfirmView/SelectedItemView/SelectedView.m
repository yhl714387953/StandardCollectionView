//
//  SelectedView.m
//  MeiZhiTableView
//
//  Created by Hailong Yu on 15/6/6.
//  Copyright (c) 2015年 zhongkeyun. All rights reserved.
//

#import "SelectedView.h"

@implementation SelectedView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.collectionView];
    }

    return self;
}

#pragma mark -
#pragma mark - Action
-(void)reloadData{
    [self.collectionView reloadData];
//    collectionView  reloadData后并不能取到内容contentSize大小
//    这里重新定义self的高度

    NSInteger lines = self.dataSource.count % 4 == 0 ? self.dataSource.count  / 4 : self.dataSource.count  / 4 + 1;
    NSInteger spaceLines = self.dataSource.count  % 4 == 0 ? self.dataSource.count  / 4 - 1 : self.dataSource.count  / 4;
    self.collectionView.height = 40 + 40 * lines + 10 * spaceLines;
    self.height = self.collectionView.height + 10;
}

#pragma mark -
#pragma mark - getter
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kScreenSize.width / 5.0, 40);
        layout.headerReferenceSize = CGSizeMake(kScreenSize.width, 40);
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;//不让滚动
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[SelectedCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[BaseHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    
    return _collectionView;
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
    SelectedCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    
    NSMutableDictionary* dic = self.dataSource[indexPath.item];
    cell.label.text = dic[@"itemName"];
    cell.label.backgroundColor = [UIColor lightGrayColor];
    cell.label.textAlignment = NSTextAlignmentCenter;
    
    [cell setNeedsLayout];
    
    return cell;
}

#pragma mark -
#pragma mark - UICollectionViewDelegate
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    BaseHeaderReusableView* resuableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        resuableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        resuableView.label.text = @"已选项目";
    }else{
        resuableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"footer" forIndexPath:indexPath];
    }
    
    return  resuableView;
}

#pragma mark -
#pragma mark - SelectedCellDelegate
-(void)selectedCellDidClicked:(SelectedCell *)cell{
    NSIndexPath* indexPath = [self.collectionView indexPathForCell:cell];
    
    NSMutableDictionary* dic = self.dataSource[indexPath.item];
    [dic setObject:@NO forKey:@"isSelected"];//更改一下数据源的状态
    
//    从数据源中删除
    [self.dataSource removeObject:dic];

//  删除该item
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
