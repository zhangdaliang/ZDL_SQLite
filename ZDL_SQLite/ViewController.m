//
//  ViewController.m
//  ZDL_SQLite
//
//  Created by zhangdaliang on 2017/8/1.
//  Copyright © 2017年 yshow. All rights reserved.
//

//1.导入libsqlite3.0
//2.导入头文件<sqlite3.h>
#import "ViewController.h"
#import "SQLiteManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    打开数据库
    [[SQLiteManager shareManger] open];
//    关闭数据库
//    [[SQLiteManager shareManger] close];
//    创建表
//    [[SQLiteManager shareManger] creat];
//    插入数据
//    [[SQLiteManager shareManger] insert];
//    更新数据
//    [[SQLiteManager shareManger] update];
//    查询数据
    [[SQLiteManager shareManger] select];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
