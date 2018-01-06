//
//  AddEventViewController.h
//  TimeManager
//
//  Created by Xinping Liu on 20/5/17.
//  Copyright © 2017 Xinping Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventModel.h"
@interface AddEventViewController : UIViewController

@property (nonatomic,strong)EventModel *model;
@property (nonatomic,copy) NSString *responseid;
//@property (nonatomic,copy) NSString *eventtitle;
//@property (nonatomic,copy) NSString *eventdetail;
//@property (nonatomic,copy) NSString *eventdate;

@end
