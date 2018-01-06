//
//  SQLiteDBQueue.h
//  TimeManager
//
//  Created by Xinping Liu on 21/5/17.
//  Copyright © 2017 Xinping Liu. All rights reserved.
//

#import "FMDatabaseQueue.h"

@interface SQLiteDBQueue : FMDatabaseQueue


+(SQLiteDBQueue*)sharedInstanceQueue;


+(NSString*)GetStoreDocumentFilePath;


@end
