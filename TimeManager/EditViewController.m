//
//  EditViewController.m
//  TimeManager
//
//  Created by Xinping Liu on 20/5/17.
//  Copyright © 2017 Xinping Liu. All rights reserved.
//

#import "EditViewController.h"
#import "AddEventViewController.h"
#import "EventTableViewCell.h"
#import "EventModel.h"
#import "SQLiteDBManage.h"

#define cellIdentifier @"eventTableViewCell"

@interface EditViewController ()<UITableViewDelegate,UITableViewDataSource,EventTableViewCellDelegate,UIAlertViewDelegate>
{
    NSString *deleteID;
}

@property (weak, nonatomic) IBOutlet UITableView *eventTableView;

@property(nonatomic,strong) NSMutableArray *eventArray;
@end

@implementation EditViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
    
}
-(NSMutableArray *)eventArray{
    if (!_eventArray) {
        _eventArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _eventArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
    self.eventTableView.backgroundColor= [UIColor colorWithRed:255.0/255.0 green:175.0/255.0 blue:97.0/255.0 alpha:1];
    self.eventTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.eventTableView.layer.borderWidth = 1;
    self.eventTableView.bounces = NO;
    self.eventTableView.delegate = self;
    self.eventTableView.dataSource = self;
    [self.eventTableView registerNib:[UINib nibWithNibName:@"EventTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
}
-(void)backAction{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
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
    cell.delegate = self;
    cell.backgroundColor=[UIColor clearColor];
    EventModel *model = _eventArray[indexPath.row];
    model.responseid = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.isEdit = YES;
    cell.model = model;
    
    if (indexPath.row == _eventArray.count-1) {
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:[SQLiteDBQueue GetStoreDocumentFilePath]])
        {
            
            [[SQLiteDBManage sharedInstance] deleteEventTable];
            
            for (int i = 0; i< _eventArray.count; i++) {
                EventModel *model = _eventArray[i];
                model.responseid = [NSString stringWithFormat:@"%d",i];
                
                [[SQLiteDBManage sharedInstance] inSertintoEventTableWithresponseid:model.responseid title:model.title detail:model.detail date:model.date];
            }
            NSMutableArray *dateArray = [[SQLiteDBManage sharedInstance] SelectEventTableWithSizeCount:0];
            NSLog(@"===%ld",dateArray.count);
            
        }
    }
    return cell;
}

-(void)deleteEventWithID:(NSString *)responseid{
    deleteID = responseid;
    NSLog(@"deleteID===%@",deleteID);
    NSString *message = @"Are you sure you want to delete this task?";
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle: UIAlertControllerStyleAlert];
    
    [alertView addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alertView addAction:[UIAlertAction actionWithTitle:@"sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[SQLiteDBManage sharedInstance] deleteEventWithresponseid:deleteID];
        [_eventArray removeObjectAtIndex:[deleteID integerValue]];
        [self.eventTableView reloadData];
    }]];
    
    [self presentViewController:alertView animated:true completion:nil];
    
    
    //UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"sure", nil];
    //[alertView show];
}
//-(void)alertView:(UIAlertController *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//if (buttonIndex == 1) {
//[[SQLiteDBManage sharedInstance] deleteEventWithresponseid:deleteID];
//[_eventArray removeObjectAtIndex:[deleteID integerValue]];
// [self.eventTableView reloadData];
//}
//}
-(void)updateEventWithID:(NSString *)responseid{
    AddEventViewController *addEventVC = [[AddEventViewController alloc] init];
    addEventVC.model = _eventArray[[responseid integerValue]];
    addEventVC.responseid = responseid;
    [self.navigationController pushViewController:addEventVC animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
