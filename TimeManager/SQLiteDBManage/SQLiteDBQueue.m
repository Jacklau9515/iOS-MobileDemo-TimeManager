//
//  SQLiteDBQueue.m
//  TimeManager
//
//  Created by Xinping Liu on 21/5/17.
//  Copyright © 2017 Xinping Liu. All rights reserved.
//

#import "SQLiteDBQueue.h"
#pragma mark ************ Sandbox directories ****************
#define HomeDirectoryDocumentFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)/*这是get Sandbox directories*/ objectAtIndex:0]

@implementation SQLiteDBQueue


#pragma mark ------------------ Example ---------------------
static SQLiteDBQueue *SharedSQLiteDBQueue = nil; //init

+(SQLiteDBQueue*)sharedInstanceQueue
{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        
        SharedSQLiteDBQueue = [SQLiteDBQueue databaseQueueWithPath:[self GetStoreDocumentFilePath]];
        
        NSLog(@"======%@",HomeDirectoryDocumentFilePath);
        
    });
    
    return SharedSQLiteDBQueue;
}

+(NSString*)GetStoreDocumentFilePath
{
    return [HomeDirectoryDocumentFilePath stringByAppendingPathComponent:@"event.sqlite3"];
}





@end
