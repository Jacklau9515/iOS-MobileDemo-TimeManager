//
//  FirstViewController.m
//  TimeManager
//
//  Created by Xinping Liu on 20/5/17.
//  Copyright © 2017 Xinping Liu. All rights reserved.
//

#import "FirstViewController.h"
#import "AddEventViewController.h"
#import "QuestionViewController.h"
#import "EditViewController.h"
#import "EventTableViewCell.h"
#import "UINavigationBar+Awesome.h"
#import "EventModel.h"
#import "SQLiteDBManage.h"

#define cellIdentifier @"eventTableViewCell"

@interface FirstViewController()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *deleteID;
    NSDate *nowDate;
}

@property (weak, nonatomic) IBOutlet UITableView *eventTableView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *score_Label;

@property(nonatomic,strong) NSMutableArray *eventArray;
@end

@implementation FirstViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //hide the navigation bar
    [self.navigationController.navigationBar lt_setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0]];
    self.navigationController.navigationBar.hidden = YES;
    UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    navBarHairlineImageView.hidden = YES;
    
    //check if any tasks in the database
    NSMutableArray *dateArray = [[SQLiteDBManage sharedInstance] SelectEventTableWithSizeCount:0];
    [self.eventArray removeAllObjects];
    if (dateArray.count>0) {
        for (NSDictionary *dict in dateArray) {
            EventModel *model = [[EventModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [_eventArray addObject:model];
        }
        [self.eventTableView reloadData];
    }
    
    self.score_Label.text = [NSString stringWithFormat:@"Your TMQ Score Is %ld",[[NSUserDefaults standardUserDefaults] integerForKey:@"scores"]];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0]];
    self.navigationController.navigationBar.hidden = NO;
    UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden = YES;
}
//create the line for the navigation bar
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

-(NSMutableArray *)eventArray{
    if (!_eventArray) {
        _eventArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _eventArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //date
    self.dateLabel.layer.borderColor = [UIColor colorWithRed:149.0/255 green:197.0/255 blue:255.0/255 alpha:1].CGColor;
    self.dateLabel.layer.borderWidth = 2;
    NSString *timeStr = [NSString stringWithFormat:@"%@",[NSDate dateWithTimeIntervalSinceNow:0]];
    self.dateLabel.text = [timeStr substringToIndex:timeStr.length-5];
    //the temple of tableview
    self.eventTableView.backgroundColor= [UIColor colorWithRed:234 green:234 blue:234 alpha:1];
    self.eventTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.eventTableView.layer.borderWidth = 1;
    
    //    UIImageView*imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backImage"]];
    //    self.eventTableView.backgroundView = imageView;
    //setting the agent
    self.eventTableView.delegate = self;
    self.eventTableView.dataSource = self;
    self.eventTableView.bounces = NO;
    //register cell
    [_eventTableView registerNib:[UINib nibWithNibName:@"EventTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
}
- (IBAction)addEentAction:(id)sender {
    
    AddEventViewController *addEventVC = [[AddEventViewController alloc] init];
    [self.navigationController pushViewController:addEventVC animated:YES];
}

- (IBAction)doHoomworkAction:(id)sender {
    
    QuestionViewController *questionVC = [[QuestionViewController alloc] init];
    [self.navigationController pushViewController:questionVC animated:YES];
}

- (IBAction)editAction:(id)sender {
    
    EditViewController *editVC = [[EditViewController alloc] init];
    [self.navigationController pushViewController:editVC animated:YES];
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _eventArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [EventTableViewCell eventCell];
    }
    cell.backgroundColor=[UIColor clearColor];
    EventModel *model = _eventArray[indexPath.row];
    model.responseid = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.isEdit = NO;
    cell.model = model;
    
    if (indexPath.row == _eventArray.count-1) {
        //Create a table
        [[SQLiteDBManage sharedInstance] CreatEventTable];
        //    check if the database file exists
        if ([[NSFileManager defaultManager] fileExistsAtPath:[SQLiteDBQueue GetStoreDocumentFilePath]])
        {
            //empty the table every time when insert new data
            [[SQLiteDBManage sharedInstance] deleteEventTable];
            //input data iteration
            for (int i = 0; i< _eventArray.count; i++) {
                
                EventModel *model = _eventArray[i];
                model.responseid = [NSString stringWithFormat:@"%d",i];
                //insert the database
                [[SQLiteDBManage sharedInstance] inSertintoEventTableWithresponseid:model.responseid title:model.title detail:model.detail date:model.date];
            }
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithRed:234 green:234 blue:234 alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    label.layer.borderWidth = 1;
    label.layer.borderColor = [UIColor lightGrayColor].CGColor;
    label.text = @"  Upcoming events";
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor blackColor];
    [headerView addSubview:label];
    
    return headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
