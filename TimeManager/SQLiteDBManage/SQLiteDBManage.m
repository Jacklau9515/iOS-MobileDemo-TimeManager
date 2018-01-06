//
//  SQLiteDBManage.m
//  TimeManager
//
//  Created by Xinping Liu on 21/5/17.
//  Copyright © 2017 Xinping Liu. All rights reserved.
//

#import "SQLiteDBManage.h"


@implementation SQLiteDBManage



static SQLiteDBManage *SharedSQLiteDBManage = nil; //第一步：静态实例，并初始化。

//单例类方法
+(SQLiteDBManage*)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        SharedSQLiteDBManage = [[self alloc]init];
    });
    
    return SharedSQLiteDBManage;
}


#pragma mark - ****************************** Opearting ******************************
#pragma mark  Create the data table
-(void)CreatEventTable{
    
    NSString *CREATESQL = @"create table if not exists EventTable (id integer primary key autoincrement default 0,responseid text default '',title text default '',detail text default '',date text default '')";
    
    
    [[SQLiteDBQueue sharedInstanceQueue] inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
         [db executeUpdate:CREATESQL];
     }];
}


#pragma mark  Insert the data --- (Wire Parameters)
-(void)inSertintoEventTableWithresponseid:(NSString *)responseid title:(NSString *)title detail:(NSString *)detail date:(NSString *)date
{
    //插入数据内容
    NSString *INSERTINTOSQL = [NSString stringWithFormat:@"insert into EventTable(responseid,title,detail,date) VALUES (?,?,?,?)"];
    
    [[SQLiteDBQueue sharedInstanceQueue] inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
         [db executeUpdate:INSERTINTOSQL,responseid,title,detail,date];
     }];
    
}


#pragma mark  Query all data
-(NSMutableArray *)SelectEventTableWithSizeCount:(NSInteger)SizeCount{
    NSMutableArray *eventArray = [[NSMutableArray alloc]init];
    NSString *QUERYSQL = [NSString stringWithFormat:@"select * from EventTable order by id asc limit %ld,10",(long)SizeCount];
    
    [[SQLiteDBQueue sharedInstanceQueue] inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
         FMResultSet *Results = [db executeQuery:QUERYSQL];
         while ([Results next]) {
             NSString *responseid = [[NSString alloc] initWithData:[Results dataForColumn:@"responseid"] encoding:NSUTF8StringEncoding];
             
             NSString *title = [[NSString alloc] initWithData:[Results dataForColumn:@"title"] encoding:NSUTF8StringEncoding];
             
             NSString *detail = [[NSString alloc] initWithData:[Results dataForColumn:@"detail"] encoding:NSUTF8StringEncoding];
             
             NSString *date = [[NSString alloc] initWithData:[Results dataForColumn:@"date"] encoding:NSUTF8StringEncoding];
             
             NSDictionary *tempdict = [[NSDictionary alloc] initWithObjectsAndKeys:responseid, @"responseid",title,@"title",detail,@"detail",date,@"date",nil];
             [eventArray addObject:tempdict];//responseid
         }
     }];
    
    //Return eventdata
    return eventArray;
}
-(NSMutableArray *)SelectEventTable{
    NSMutableArray *eventArray = [[NSMutableArray alloc]init];
    NSString *QUERYSQL = [NSString stringWithFormat:@"select title from EventTable where responseid = '0'"];
    
    [[SQLiteDBQueue sharedInstanceQueue] inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
         FMResultSet *Results = [db executeQuery:QUERYSQL];
         while ([Results next])
         {
             NSString *title = [[NSString alloc] initWithData:[Results dataForColumn:@"title"] encoding:NSUTF8StringEncoding];
             NSLog(@"share_url-----%@",title);
             [eventArray addObject:title];
             
         }
     }];
    return eventArray;
}

-(void)deleteEventTable{
    NSString *deleteSQL = @"delete from EventTable";
    [[SQLiteDBQueue sharedInstanceQueue]  inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
         [db executeUpdate:deleteSQL];
     }];
}
-(void)deleteEventWithresponseid:(NSString *)responseid{
    NSString *deleteSQL = [NSString stringWithFormat:@"delete from EventTable where responseid = '%@'",responseid];
    [[SQLiteDBQueue sharedInstanceQueue]  inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
         [db executeUpdate:deleteSQL];
     }];
}

-(void)updateEventTablewithresponseid:(NSString *)responseid title:(NSString *)title detail:(NSString *)detail date:(NSString *)date{
    NSLog(@"===%@",responseid);
    
    /*Events need to be input*/
    NSString *updateOldTitleSQL = [NSString stringWithFormat:@"update EventTable  set title = '%@' where responseid = '%@'",title,responseid];
    NSString *updateOldDetailSQL = [NSString stringWithFormat:@"update EventTable  set detail = '%@' where responseid = '%@'",detail,responseid];
    
    NSString *updateOldDateSQL = [NSString stringWithFormat:@"update EventTable  set date = '%@' where responseid = '%@'",date,responseid];
    
    
    [[SQLiteDBQueue sharedInstanceQueue]  inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
         [db executeUpdate:updateOldTitleSQL];
         [db executeUpdate:updateOldDetailSQL];
         [db executeUpdate:updateOldDateSQL];
     }];
    
}

@end
