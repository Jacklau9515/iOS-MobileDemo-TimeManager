//
//  AddEventViewController.m
//  TimeManager
//
//  Created by Xinping Liu on 20/5/17.
//  Copyright © 2017 Xinping Liu. All rights reserved.
//

#import "AddEventViewController.h"
#import "EditViewController.h"
#import "CategorTableViewCell.h"
#import "SQLiteDBManage.h"

#define cellIdentifier @"categorTableViewCell"
@interface AddEventViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray *categoryArray;
    NSString *categoryStr;
    UITapGestureRecognizer *tap;
}
@property (weak, nonatomic) IBOutlet UITextField *eventTitle_textField;
@property (weak, nonatomic) IBOutlet UITextField *eventDetail_textField;
@property (weak, nonatomic) IBOutlet UITextField *eventDate_textField;
@property (weak, nonatomic) IBOutlet UILabel *wenhaoLabel;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UIButton *upload_Button;

@end

@implementation AddEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    [self initDate];
    
    self.wenhaoLabel.layer.borderWidth = 1;
    self.wenhaoLabel.layer.borderColor = [UIColor blackColor].CGColor;
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismisKeyBoard)];
    _categoryTableView.userInteractionEnabled = YES;
    _categoryTableView.bounces = NO;
    _categoryTableView.delegate = self;
    _categoryTableView.dataSource = self;
    [_categoryTableView registerNib:[UINib nibWithNibName:@"CategorTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)dismisKeyBoard{
    [self.eventDate_textField resignFirstResponder];
    [self.eventTitle_textField resignFirstResponder];
    [self.eventDetail_textField resignFirstResponder];
    [_categoryTableView removeGestureRecognizer:tap];
}
-(void)initDate{
    
    if (self.model != nil) {
        self.eventTitle_textField.text = self.model.title;
        self.eventDetail_textField.text = self.model.detail;
        self.eventDate_textField.text = self.model.date;
    }
    categoryArray = [[NSArray alloc] initWithObjects:@"Urgent & Improtant",@"Urgent & Not Improtant",@"Not Urgent & Improtant",@"Not Urgent & Not Improtant", nil];
    //initial value
    categoryStr = categoryArray[0];
    self.eventTitle_textField.delegate = self;
    self.eventDetail_textField.delegate = self;
    self.eventDate_textField.delegate = self;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [_categoryTableView addGestureRecognizer:tap];
    return YES;
}
- (IBAction)upLoadAction:(id)sender {
    if (![self.eventTitle_textField.text isEqualToString:@""]) {
        if (self.responseid != nil && self.responseid != NULL && ![self.responseid isEqualToString:@""]) {
            [[SQLiteDBManage sharedInstance] updateEventTablewithresponseid:self.responseid title:self.eventTitle_textField.text detail:self.eventDetail_textField.text date:self.eventDate_textField.text];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            //create the table
            [[SQLiteDBManage sharedInstance] CreatEventTable];
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:[SQLiteDBQueue GetStoreDocumentFilePath]])
            {
                //insert the database
                [[SQLiteDBManage sharedInstance] inSertintoEventTableWithresponseid:@"" title:self.eventTitle_textField.text detail:self.eventDetail_textField.text date:self.eventDate_textField.text];
            }
            EditViewController *editVC = [[EditViewController alloc] init];
            [self.navigationController pushViewController:editVC animated:YES];
        }
    }else{
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Task title cannot be nil" message:@"" preferredStyle: UIAlertControllerStyleAlert];
        
        [alertView addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [self presentViewController:alertView animated:true completion:nil];
        
        
        
        //UIAlertController *alertView = [[UIAlertController alloc] initWithTitle:@"Task Titlt Can Not Be Nil !" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        //[self performSelector:@selector(dimissAlert:) withObject:alertView afterDelay:1];
        //[alertView show];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.eventDate_textField resignFirstResponder];
    [self.eventTitle_textField resignFirstResponder];
    [self.eventDetail_textField resignFirstResponder];
    [_categoryTableView removeGestureRecognizer:tap];
}
#pragma mark - uitableviewDeiegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategorTableViewCell *cell =[CategorTableViewCell categoryCell];
    if (indexPath.row == 0) {
        cell.isChoose = YES;
    }else{
        cell.isChoose = NO;
    }
    cell.categoryContent = categoryArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CategorTableViewCell *cell1  = (CategorTableViewCell*)[tableView  cellForRowAtIndexPath:indexPath];
        cell1.isChoose_ImageView.image = [UIImage imageNamed:@"choose"];
        categoryStr = categoryArray[0];
    }else{
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
        CategorTableViewCell *cell  = (CategorTableViewCell*)[tableView  cellForRowAtIndexPath:index];
        cell.isChoose_ImageView.image = [UIImage imageNamed:@"noChoose"];
        
        CategorTableViewCell *cell1  = (CategorTableViewCell*)[tableView  cellForRowAtIndexPath:indexPath];
        cell1.isChoose_ImageView.image = [UIImage imageNamed:@"choose"];
        
        categoryStr = categoryArray[indexPath.row];
    }
    
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    CategorTableViewCell *cell  = (CategorTableViewCell*)[tableView  cellForRowAtIndexPath:indexPath];
    cell.isChoose_ImageView.image = [UIImage imageNamed:@"noChoose"];
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
