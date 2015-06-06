//
//  ConfirmViewController.m
//  MeiZhiTableView
//
//  Created by Hailong Yu on 15/6/6.
//  Copyright (c) 2015年 zhongkeyun. All rights reserved.
//

#import "ConfirmViewController.h"

@interface ConfirmViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* dataSource;//数据源
@end

@implementation ConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNaviBar];
    [self.view addSubview:self.tableView];
    
//    测试取消选中状态
//    for (int i = 0; i < self.selectedItems.count; i++) {
//        NSMutableDictionary* itemDic = self.selectedItems[i];
//        if (i % 2 == 0)
//            [itemDic setObject:@NO forKey:@"isSelected"];
//    }
    
    // Do any additional setup after loading the view.
}

#pragma mark -
#pragma mark - init
-(void)initNaviBar{
    self.title = @"预约服务";
}

#pragma mark -
#pragma mark - Action


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - getter
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 10)];
        
//        第一部分header
        SelectedView* selectedView = [[SelectedView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 100)];
        selectedView.dataSource = self.selectedItems;
        [selectedView reloadData];
        [headerView addSubview:selectedView];
        
//        第二部分header
        ServiceTimeView* serviceView = [[ServiceTimeView alloc] initWithFrame:CGRectMake(0, selectedView.bottom, selectedView.width, 0)];
        serviceView.monthLabel.text = @"六月  |";
        serviceView.dataSource = [CarModel getAllServiceTimeList];
        [serviceView reloadData];
        [headerView addSubview:serviceView];
        
        headerView.height = selectedView.height + serviceView.height;
        _tableView.tableHeaderView = headerView;
        
        
        UIButton* button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        button.frame = CGRectMake(0, 0, kScreenSize.width, 40);
        button.backgroundColor = [UIColor redColor];
        [button setTitle:@"确认提交" forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _tableView.tableFooterView = button;
    }
    
    return _tableView;
}

#pragma mark -
#pragma mark - getter UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if(section == 1){
        return 2;
    }else{
        return 1;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:identifier];
    }
    
    NSString* textLabelText = @"";
    NSString* detailTextLabelText = @"";
    
    [cell setAccessoryType:(UITableViewCellAccessoryNone)];
    switch (indexPath.section) {
        case 0:
            textLabelText = indexPath.row == 0 ? @"工时费" : @"奖励积分";
            detailTextLabelText = indexPath.row == 0 ? @"无优惠" : @"200分";
            break;
            
        case 1:
            [cell setAccessoryType:(UITableViewCellAccessoryDisclosureIndicator)];
            textLabelText = indexPath.row == 0 ? @"车辆信息" : @"联系方式";
            detailTextLabelText = indexPath.row == 0 ? @"京Q12345" : @"13312345678";
            break;
            
        case 2:
            [cell setAccessoryType:(UITableViewCellAccessoryNone)];
            textLabelText = @"如有其他请求我们尽快安排";
            detailTextLabelText = @"";
            break;
    }
    
    
    

    cell.textLabel.text = textLabelText;
    cell.detailTextLabel.text = detailTextLabelText;
    return cell;
}


#pragma mark -
#pragma mark - getter UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 20;
    }
    
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }
    
    return 5;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 30)];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"￥赠送积分   &折扣优惠    |";
        return label;
    }

    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
