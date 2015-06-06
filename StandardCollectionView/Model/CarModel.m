//
//  CarModel.m
//  MeiZhiTableView
//
//  Created by Hailong Yu on 15/6/6.
//  Copyright (c) 2015年 zhongkeyun. All rights reserved.
//

#import "CarModel.h"

@implementation CarModel
+(NSMutableArray *)getAllServiceList{
    NSMutableArray* dataSource = [NSMutableArray array];
    NSArray* names = @[@"洗车", @"保养", @"汽车美容", @"维修", @"试乘试驾", @"4S服务", @"代驾服务", @"其他"];
    for (int i = 0; i < names.count; i++) {//section数据源，一个字典
        NSMutableDictionary* sectionDic = [NSMutableDictionary dictionary];
        [sectionDic setObject:names[i] forKey:@"name"];
        
        [dataSource addObject:sectionDic];
        
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
    
    return dataSource;
}

+(NSMutableArray *)getAllServiceTimeList{
    NSMutableArray* dataSource = [NSMutableArray array];
    for (int i = 0; i < 7; i++) {
        NSMutableDictionary* dic = [NSMutableDictionary dictionary];
        [dic setObject:@NO forKey:@"isPrompt"];
        [dic setObject:[NSString stringWithFormat:@"%02d", i] forKey:@"day"];
        [dic setObject:[NSString stringWithFormat:@"星期%d", i] forKey:@"week"];
        [dic setObject:@NO forKey:@"isSelected"];
        if (i == 0) {
            [dic setObject:@YES forKey:@"isSelected"];
        }
        [dataSource addObject:dic];
        
//        dic里还有每天上午和下午的时间数组
        NSMutableArray* amArr = [NSMutableArray array];
        NSMutableArray* pmArr = [NSMutableArray array];
        [dic setObject:amArr forKey:@"am"];
        [dic setObject:pmArr forKey:@"pm"];
        
//        包装一下字典，每一个时间 08:00 09:00……是key 里面还有一层字典，存储别的别的信息，先存一个是否选中状态的key---value
        NSArray* amHours = @[@"08:00", @"09:00", @"10:00", @"11:00", @"12:00"];
        NSArray* pmHours = @[@"13:00", @"14:00", @"15:00", @"16:00", @"17:00", @"18:00", @"19:00", @"20:00"];
        for (NSString* amHour in amHours) {
            NSMutableDictionary* amSubDic = [NSMutableDictionary dictionary];
            [amSubDic setObject:@NO forKey:@"isSelected"];
            [amSubDic setObject:amHour forKey:@"hour"];
            [amArr addObject:amSubDic];
        }
        
        for (NSString* pmHour in pmHours) {
            NSMutableDictionary* pmSubDic = [NSMutableDictionary dictionary];
            [pmSubDic setObject:@NO forKey:@"isSelected"];
            [pmSubDic setObject:pmHour forKey:@"hour"];
            [pmArr addObject:pmSubDic];
        }
        
    }
    
    return dataSource;
}

@end
