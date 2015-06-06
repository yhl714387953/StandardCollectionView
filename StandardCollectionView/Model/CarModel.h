//
//  CarModel.h
//  MeiZhiTableView
//
//  Created by Hailong Yu on 15/6/6.
//  Copyright (c) 2015年 zhongkeyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject

//获取第一页所有服务列表
+(NSMutableArray*)getAllServiceList;

//获取服务时间列表
+(NSMutableArray*)getAllServiceTimeList;

@end
