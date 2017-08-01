//
//  SQLiteManager.h
//  ZDL_SQLite
//
//  Created by zhangdaliang on 2017/8/1.
//  Copyright © 2017年 yshow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLiteManager : NSObject


//本类作为数据库管理类
//因为数据库保持唯一性 使用单例获取管理类实例对象
+(SQLiteManager *)shareManger;

//1.打开数据库
-(void)open;

//关闭数据库
-(void)close;

//创建表单
-(void)creat;

//插入数据
-(void)insert;

//更新数据
-(void)update;

//删除数据
-(void)delet;

//查询数据
-(void)select;

@end










