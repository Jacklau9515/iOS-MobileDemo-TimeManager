//
//  EventTableViewCell.h
//  TimeManager
//
//  Created by Xinping Liu on 20/5/17.
//  Copyright © 2017 Xinping Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventModel.h"

@protocol EventTableViewCellDelegate <NSObject>

-(void)deleteEventWithID:(NSString*)responseid;
-(void)updateEventWithID:(NSString*)responseid;

@end


@interface EventTableViewCell : UITableViewCell
@property(nonatomic,strong)EventModel *model;

@property (nonatomic,assign)id<EventTableViewCellDelegate>delegate;
@property (nonatomic,assign) BOOL isEdit;
+(EventTableViewCell*)eventCell;
@end
