//
//  ViewController.m
//  StandardCollectionView
//
//  Created by Hailong Yu on 15/6/6.
//  Copyright (c) 2015年 zhongkeyun. All rights reserved.
//

#import "ViewController.h"

#define kScreenSize [UIScreen mainScreen].bounds.size

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) NSMutableArray* dataSource;//section数据源，里面是字典{name: @"", items : NSMutableArray(里面是字典，有名字，是否选中的属性)}
@end

@implementation ViewController

#pragma mark -
#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    [self initAttributes];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - initAttributes
-(void)initAttributes{
    self.dataSource = [NSMutableArray array];
    NSArray* names = @[@"洗车", @"保养", @"汽车美容", @"维修", @"试乘试驾", @"4S服务", @"代驾服务"];
    for (int i = 0; i < names.count; i++) {//section数据源，一个字典
        NSMutableDictionary* sectionDic = [NSMutableDictionary dictionary];
        [sectionDic setObject:names[i] forKey:@"name"];
        
        [self.dataSource addObject:sectionDic];
        
        NSInteger rand = 3 + arc4random() % 15;
        NSMutableArray* items = [NSMutableArray array];
        for (int j = 0; j < rand; j++) {
            NSMutableDictionary* itemDic = [NSMutableDictionary dictionary];
            [itemDic setObject:[NSString stringWithFormat:@"%d-车-%d", i, j] forKey:@"itemName"];
            [itemDic setObject:@NO forKey:@"isSelected"];
            [items addObject:itemDic];
        }
        
        [sectionDic setObject:items forKey:@"items"];
    }
}

#pragma mark -
#pragma mark - getter
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kScreenSize.width / 5.0, 40);
        layout.headerReferenceSize = CGSizeMake(kScreenSize.width, 20);
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MZCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[MZHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    
    return _collectionView;
}

#pragma mark -
#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataSource.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSMutableArray* items = self.dataSource[section][@"items"];
    return items.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MZCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSMutableArray* items = self.dataSource[indexPath.section][@"items"];
    NSMutableDictionary* dic = items[indexPath.row];
    cell.nameLabel.text = dic[@"itemName"];
    cell.isSelected = [dic[@"isSelected"] boolValue];
    
    [cell setNeedsLayout];
    
    return cell;
}

#pragma mark -
#pragma mark - UICollectionViewDelegate
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView* resuableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        resuableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        ((MZHeaderReusableView*)resuableView).nameLabel.text = self.dataSource[indexPath.section][@"name"];
    }else{
        resuableView = (MZHeaderReusableView*)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"footer" forIndexPath:indexPath];
    }
    
    return  resuableView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray* items = self.dataSource[indexPath.section][@"items"];
    NSMutableDictionary* dic = items[indexPath.row];
    BOOL isSelected = [dic[@"isSelected"] boolValue];
    [dic setObject:[NSNumber numberWithBool:!isSelected] forKey:@"isSelected"];
    
    [self.collectionView reloadData];//这种reload挺耗性能的，不关有多少个，都刷新这个列表，用点击事件去控制性能会好些(点击事件只针对一个item<控制好数据源就可以了>，reload 刷新整个)
}


@end
