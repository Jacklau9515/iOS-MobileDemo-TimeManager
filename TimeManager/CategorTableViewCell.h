//
//  CategorTableViewCell.h
//  TimeManager
//
//  Created by Xinping Liu on 20/5/17.
//  Copyright © 2017 Xinping Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategorTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *isChoose_ImageView;


@property (nonatomic,copy)NSString *categoryContent;
@property (nonatomic,assign)BOOL isChoose;
+(CategorTableViewCell*)categoryCell;
@end
