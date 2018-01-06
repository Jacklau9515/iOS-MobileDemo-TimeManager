//
//  EventModel.h
//  TimeManager
//
//  Created by Xinping Liu on 20/5/17.
//  Copyright © 2017 Xinping Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventModel : NSObject

@property (nonatomic,copy) NSString *responseid;
@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *detail;
@property (nonatomic,copy) NSString *date;


@end
