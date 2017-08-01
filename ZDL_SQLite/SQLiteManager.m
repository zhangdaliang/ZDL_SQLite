//
//  SQLiteManager.m
//  ZDL_SQLite
//
//  Created by zhangdaliang on 2017/8/1.
//  Copyright © 2017年 yshow. All rights reserved.
//

#import "SQLiteManager.h"
#import <sqlite3.h>
@interface SQLiteManager ()
{
    sqlite3 *db;//数据库指针
}

@end
@implementation SQLiteManager

+(SQLiteManager *)shareManger
{
    static SQLiteManager *sq = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sq = [[SQLiteManager alloc]init];
    });
    return  sq;
}

//打开数据库
-(void)open{
//    打开数据库先确定数据库存放路径 存放在沙盒里面
    
//    1.找到当前docment路径
    NSString *docmentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//    创建数据库路径
    NSString *sqlitePath = [docmentPath stringByAppendingString:@"database.sqlite"];
    
//    打开数据库 第一个参数是数据库路径 第二个参数为数据库指针
     int result =  sqlite3_open(sqlitePath.UTF8String,&db);
    if(result == SQLITE_OK){
        NSLog(@"数据库打开成功");
    }else if(result == SQLITE_FAIL){
        NSLog(@"数据库打开失败");
    }
}
//关闭数据库
-(void)close{
    //只需要提供打开时候的数据库指针
    int  result = sqlite3_close(db);
    if(result == SQLITE_OK){
        NSLog(@"数据库关闭成功");
    }else if(result == SQLITE_FAIL){
        NSLog(@"数据库关闭失败");
    }
}

-(void)creat{
    //sql语句
    NSString *sqlStr = @"create table person(id integer primary key,name text,age integer)";
    
    //执行sql语句
    char *error = nil;
    sqlite3_exec(db, sqlStr.UTF8String, nil, nil, &error);
    
    if(error == nil){
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
    }
    
    
}

-(void)insert{
    NSString *sqlStr = @"insert into person('name','age') values('sqlite3',23)";
    //执行sql语句
    char *error = nil;
    sqlite3_exec(db, sqlStr.UTF8String, nil, nil, &error);
    
    if(error == nil){
        NSLog(@"插入数据成功");
    }else{
        NSLog(@"插入数据失败%s",error);
    }
}

-(void)update{
    NSString *sqlStr = @"update person set 'name'='liang' where id=1";
    //执行sql语句
    char *error = nil;
    sqlite3_exec(db, sqlStr.UTF8String, nil, nil, &error);
    
    if(error == nil){
        NSLog(@"更新数据成功");
    }else{
        NSLog(@"插入数据失败%s",error);
    }
}
-(void)delet{
    NSString *sqlStr = @"delete from person where id = 1";
    //执行sql语句
    char *error = nil;
    sqlite3_exec(db, sqlStr.UTF8String, nil, nil, &error);
    
    if(error == nil){
        NSLog(@"删除数据成功");
    }else{
        NSLog(@"删除数据失败%s",error);
    }
}

-(void)select{
    NSString *sqlStr = @"select * from person";
    //执行sql语句
    
    sqlite3_stmt *stmt = nil;//数据库管理指针
    
    //第三个参数-1会自动计算sq语句长度
    sqlite3_prepare(db, sqlStr.UTF8String, -1, &stmt, nil);
    
//    判断是否有下一行数据 遵循一列一列获取
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        int id = sqlite3_column_int(stmt, 0);
        const unsigned char *name = sqlite3_column_text(stmt, 1);
        NSString * nameStr = [NSString stringWithUTF8String:(const char *)name];
        int age = sqlite3_column_int(stmt, 2);
        NSLog(@"id=%d,name=%@,age=%d",id,nameStr,age);
    }
    
   //释放数据库管理
    sqlite3_finalize(stmt);
}

@end
