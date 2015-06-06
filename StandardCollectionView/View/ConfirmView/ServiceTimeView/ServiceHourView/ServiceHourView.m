//
//  ServiceHourView.m
//  MeiZhiTableView
//
//  Created by Hailong Yu on 15/6/7.
//  Copyright (c) 2015年 zhongkeyun. All rights reserved.
//

#import "ServiceHourView.h"

@implementation ServiceHourView

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
}

#pragma mark -
#pragma mark - getter
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((kScreenSize.width - 70) / 3.8, 40);
        layout.headerReferenceSize = CGSizeMake(kScreenSize.width, 20);
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(0, 70, 0, 15);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;//不让滚动
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[ServiceHourVCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[BaseCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        
//        加两条线，加个label
        
//        竖线
        UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(55, 20, 1, self.height - 30)];
        label1.backgroundColor = [UIColor lightGrayColor];
        [_collectionView addSubview:label1];
        
//       横线
        UILabel* label2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 120, self.width - 15, 1)];
        label2.backgroundColor = [UIColor lightGrayColor];
        [_collectionView addSubview:label2];
        
//        上午
        UILabel* label3 = [[UILabel alloc] initWithFrame:CGRectMake(5, 40, 40, 14)];
        label3.text = @"上午";
        [_collectionView addSubview:label3];
        
//        下午
        UILabel* label4 = [[UILabel alloc] initWithFrame:CGRectMake(5, 140, 40, 14)];
        label4.text = @"下午";
        [_collectionView addSubview:label4];
        
    }
    
    return _collectionView;
}

#pragma mark -
#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return self.amDataSource.count;
    }
    return self.pmDataSource.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ServiceHourVCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSMutableDictionary* dic = nil;
    if (indexPath.section == 0) {
        dic = self.amDataSource[indexPath.row];
    }else{
        dic = self.pmDataSource[indexPath.row];
    }
    cell.label.text = dic[@"hour"];
    cell.label.textAlignment = NSTextAlignmentCenter;
    
    cell.backgroundColor = [dic[@"isSelected"] boolValue] ? [UIColor redColor] : [UIColor grayColor];
    
    [cell setNeedsLayout];
    
    return cell;
}

#pragma mark -
#pragma mark - UICollectionViewDelegate
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    BaseHeaderReusableView* resuableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        resuableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        resuableView.label.height = 20;
        resuableView.label.backgroundColor = indexPath.section == 0 ? [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1] : [UIColor whiteColor];
    }else{
        resuableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"footer" forIndexPath:indexPath];
    }
    
    return  resuableView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    for (NSMutableDictionary* dic in self.dataSource) //所有的重置
//        [dic setObject:@NO forKey:@"isSelected"];
    
    //    自己的是选中状态
    NSMutableDictionary* dic = nil;
    if (indexPath.section == 0) {
        dic = self.amDataSource[indexPath.row];
    }else{
        dic = self.pmDataSource[indexPath.row];
    }
    
    BOOL isSelected = [dic[@"isSelected"] boolValue];
    [dic setObject:[NSNumber numberWithBool:!isSelected] forKey:@"isSelected"];
    [self.collectionView reloadData];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


@end
