//
//  ServiceViewController.m
//  MeiZhiTableView
//
//  Created by Hailong Yu on 15/6/6.
//  Copyright (c) 2015年 zhongkeyun. All rights reserved.
//

#import "ServiceViewController.h"
#import "CarHeader.h"

@interface ServiceViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) NSMutableArray* dataSource;//section数据源，里面是字典{name: @"", items : NSMutableArray}
@end

@implementation ServiceViewController

#pragma mark -
#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviBar];
    
    self.dataSource = [CarModel getAllServiceList];
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - init
-(void)initNaviBar{
    self.title = @"服务列表";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemDone) target:self action:@selector(confirm:)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清空" style:(UIBarButtonItemStylePlain) target:self action:@selector(clearAll:)];
}


#pragma mark -
#pragma mark - Action

-(void)clearAll:(UIBarButtonItem*)item{
    for (NSMutableDictionary* sectionDic in self.dataSource) {
        NSMutableArray* items = sectionDic[@"items"];
        for (NSMutableDictionary* itemDic in items) {
            [itemDic setObject:@NO forKey:@"isSelected"];
        }
    }
    
    [self.collectionView reloadData];
}

-(void)confirm:(UIBarButtonItem*)item{
//    读取数据源里选中的项目
    NSMutableArray* selectedItems = [self getSelectedItems];
    if (selectedItems.count == 0) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请选择一个服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
        return;
    }
    
    
    ConfirmViewController* vc = [[ConfirmViewController alloc] init];
//    带参数，带本身吧，这样直接引用到本页面的数据源
    vc.selectedItems = selectedItems;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(NSMutableArray*)getSelectedItems{
    NSMutableArray* array = [NSMutableArray array];
    for (NSMutableDictionary* dic in self.dataSource) {
        NSMutableArray* items = dic[@"items"];
        for (NSMutableDictionary* itemDic in items)
            if ([itemDic[@"isSelected"] boolValue])
                [array addObject:itemDic];
        
    }

    return array;
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
    cell.label.text = dic[@"itemName"];
    cell.isSelected = [dic[@"isSelected"] boolValue];
    
    [cell setNeedsLayout];
    
    return cell;
}

#pragma mark -
#pragma mark - UICollectionViewDelegate
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    BaseHeaderReusableView* resuableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        resuableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        resuableView.label.text = self.dataSource[indexPath.section][@"name"];
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
