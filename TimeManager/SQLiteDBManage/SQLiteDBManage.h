//
//  SQLiteDBManage.h
//  TimeManager
//
//  Created by Xinping Liu on 21/5/17.
//  Copyright © 2017 Xinping Liu. All rights reserved.
//

#import "FMDatabase.h"
#import "SQLiteDBQueue.h"



@interface SQLiteDBManage : NSObject


//Method for Single
+(SQLiteDBManage*)sharedInstance;

#pragma mark - ****************************** Operate the Database ******************************
#pragma mark  Create table
-(void)CreatEventTable;

#pragma mark  Input data --- (Wire Parameters)

-(void)inSertintoEventTableWithresponseid:(NSString*)responseid
                                    title:(NSString*)title
                                   detail:(NSString*)detail
                                     date:(NSString*)date;




#pragma mark  Query for searching all data
-(NSMutableArray*)SelectEventTableWithSizeCount:(NSInteger)SizeCount;

//Query for searching single row
-(NSMutableArray*)SelectEventTable;

//Query for updating single row

-(void)updateEventTablewithresponseid:(NSString *)responseid title:(NSString *)title detail:(NSString *)detail date:(NSString *)date;
#pragma mark Delete the table
-(void)deleteEventTable;
-(void)deleteEventWithresponseid:(NSString*)responseid;


@end

