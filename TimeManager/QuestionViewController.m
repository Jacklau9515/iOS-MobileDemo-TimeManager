//
//  QuestionViewController.m
//  TimeManager
//
//  Created by Xinping Liu on 20/5/17.
//  Copyright © 2017 Xinping Liu. All rights reserved.
//

#import "QuestionViewController.h"
#import "CategorTableViewCell.h"

#define cellIdentifier @"categorTableViewCell"

@interface QuestionViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    NSArray *questionArray;
    NSArray *oneanswerArray;
    NSArray *twoanswerArray;
    NSArray *threeanswerArray;
    NSArray *fouranswerArray;
    NSArray *fiveanswerArray;
    NSArray *sixanswerArray;
    NSArray *sevenanswerArray;
    NSArray *eightanswerArray;
    NSArray *nineArray;
    NSArray *tenArray;
    NSArray *elevenArray;
    NSArray *twelveArray;
    NSArray *tirtheenArray;
    NSArray *fourteenArray;
    NSArray *fifteenArray;
    NSArray *sixteenArray;
    NSArray *seventeenArray;
    NSArray *eighteenArray;
    NSArray *answerAllArray;
    
    NSMutableArray *answerArray;
    
    //NSObject *obj =[[NSObject alloc]init];
    
    NSInteger index;
    NSString *answer;
}
@property (weak, nonatomic) IBOutlet UILabel *question_Label;
@property (weak, nonatomic) IBOutlet UITableView *answe_TableView;
@property (weak, nonatomic) IBOutlet UIButton *prev_Button;
@property (weak, nonatomic) IBOutlet UIButton *next_Button;
@property (weak, nonatomic) IBOutlet UIButton *complete_Button;

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    [self initData];
    _answe_TableView.bounces = YES;
    _answe_TableView.delegate = self;
    _answe_TableView.dataSource = self;
    [_answe_TableView registerNib:[UINib nibWithNibName:@"CategorTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initData{
    answer = @"1";
    index = 0;
    answerArray = [NSMutableArray arrayWithCapacity:1];
    [answerArray addObject:answer];
    questionArray = [[NSArray alloc] initWithObjects:@"1. Do you make a list of the things you have to do each day?",@"2. Do you plan your day before you start it?",@"3. Do you make a schedule of the activities you have to do on work days?",@"4. Do you write a set of goals for yourself for each day?",@"5. Do you spend time each day planning?",@"6. Do you have a clear idea of what you want to accomplish during the next week?",@"7. Do you set and honor priorities?",@"8. Do you often find yourself doing things which interfere with your schoolwork simply because you hate to say 'No' to people? *",@"9. Do you feel you are in charge of your own time, by and large?",@"10. On an average class day do you spend more time with personal grooming than doing schoolwork?*",@"11. Do you believe that there is room for improvement in the way you manage your time? *",@"12. Do you make constructive use of your time?",@"13. Do you continue unprofitable routines or activities?*",@"14. Do you usually keep your desk clear of everything other than what you are currently working on?",@"15. Do you have a set of goals for the entire quarter?",@"16. The night before a major assignment is due, are you usually still working on it? *",@"17. When you have several things to do, do you think it is best to do a little bit of work on each one?",@"18. Do you regularly review your class notes, even when a test is not imminent?", nil];
    oneanswerArray = [[NSArray alloc] initWithObjects:@"1:Never",@"2:Rarely",@"3:Occasionally",@"4:Regularly",@"5:Always", nil];
    twoanswerArray = [[NSArray alloc] initWithObjects:@"1:Never",@"2:Rarely",@"3:Occasionally",@"4:Regularly",@"5:Always", nil];
    threeanswerArray = [[NSArray alloc] initWithObjects:@"1:Never",@"2:Rarely",@"3:Occasionally",@"4:Regularly",@"5:Always", nil];
    fouranswerArray = [[NSArray alloc] initWithObjects:@"1:Never",@"2:Rarely",@"3:Occasionally",@"4:Regularly",@"5:Always", nil];
    fiveanswerArray = [[NSArray alloc] initWithObjects:@"1:Never",@"2:Rarely",@"3:Occasionally",@"4:Regularly",@"5:Always", nil];
    sixanswerArray = [[NSArray alloc] initWithObjects:@"1:Never",@"2:Rarely",@"3:Occasionally",@"4:Regularly",@"5:Always", nil];
    sevenanswerArray = [[NSArray alloc] initWithObjects:@"1:Never",@"2:Rarely",@"3:Occasionally",@"4:Regularly",@"5:Always", nil];
    eightanswerArray = [[NSArray alloc] initWithObjects:@"1:Never",@"2:Rarely",@"3:Occasionally",@"4:Regularly",@"5:Always", nil];
    nineArray = [[NSArray alloc] initWithObjects:@"1:Never",@"2:Rarely",@"3:Occasionally",@"4:Regularly",@"5:Always", nil];
    tenArray = [[NSArray alloc] initWithObjects:@"1:Never",@"2:Rarely",@"3:Occasionally",@"4:Regularly",@"5:Always", nil];
    elevenArray = [[NSArray alloc] initWithObjects:@"1:Never",@"2:Rarely",@"3:Occasionally",@"4:Regularly",@"5:Always", nil];
    twelveArray = [[NSArray alloc] initWithObjects:@"1:Never",@"2:Rarely",@"3:Occasionally",@"4:Regularly",@"5:Always", nil];
    tirtheenArray = [[NSArray alloc] initWithObjects:@"1:Never",@"2:Rarely",@"3:Occasionally",@"4:Regularly",@"5:Always", nil];
    fourteenArray = [[NSArray alloc] initWithObjects:@"1:Never",@"2:Rarely",@"3:Occasionally",@"4:Regularly",@"5:Always", nil];
    fifteenArray = [[NSArray alloc] initWithObjects:@"1:Never",@"2:Rarely",@"3:Occasionally",@"4:Regularly",@"5:Always", nil];
    sixteenArray = [[NSArray alloc] initWithObjects:@"1:Never",@"2:Rarely",@"3:Occasionally",@"4:Regularly",@"5:Always", nil];
    seventeenArray = [[NSArray alloc] initWithObjects:@"1:Never",@"2:Rarely",@"3:Occasionally",@"4:Regularly",@"5:Always", nil];
    eighteenArray = [[NSArray alloc] initWithObjects:@"1:Never",@"2:Rarely",@"3:Occasionally",@"4:Regularly",@"5:Always", nil];
    answerAllArray = [NSArray arrayWithObjects:oneanswerArray,twoanswerArray,threeanswerArray,fouranswerArray,fiveanswerArray,sixanswerArray,sevenanswerArray,eightanswerArray,nineArray,tenArray,elevenArray,twelveArray,tirtheenArray,fourteenArray,fifteenArray,sixteenArray,seventeenArray,eighteenArray, nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [answerAllArray[index] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategorTableViewCell *cell =[CategorTableViewCell categoryCell];
    if (indexPath.row == 0) {
        cell.isChoose = YES;
    }else{
        cell.isChoose = NO;
    }
    cell.categoryContent = answerAllArray[index][indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CategorTableViewCell *cell1  = (CategorTableViewCell*)[tableView  cellForRowAtIndexPath:indexPath];
        cell1.isChoose_ImageView.image = [UIImage imageNamed:@"choose"];
        answer = @"1";
    }else{
        NSIndexPath *indexp = [NSIndexPath indexPathForRow:0 inSection:0];
        CategorTableViewCell *cell  = (CategorTableViewCell*)[tableView  cellForRowAtIndexPath:indexp];
        cell.isChoose_ImageView.image = [UIImage imageNamed:@"noChoose"];
        
        CategorTableViewCell *cell1  = (CategorTableViewCell*)[tableView  cellForRowAtIndexPath:indexPath];
        cell1.isChoose_ImageView.image = [UIImage imageNamed:@"choose"];
        
        answer =[NSString stringWithFormat:@"%ld",(indexPath.row+1)*1];
    }
    if (answerArray.count-1>=index) {
        [answerArray replaceObjectAtIndex:index withObject:answer];
    }else{
        [answerArray addObject:answer];
    }
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    CategorTableViewCell *cell  = (CategorTableViewCell*)[tableView  cellForRowAtIndexPath:indexPath];
    cell.isChoose_ImageView.image = [UIImage imageNamed:@"noChoose"];
}


- (IBAction)prevAction:(id)sender {
    if (index == 0) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"This is the first question." message:@"" preferredStyle: UIAlertControllerStyleAlert];
        
        [alertView addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alertView animated:true completion:nil];
        
        //UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"There's no front ~ " message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        //[self performSelector:@selector(dimissAlert:) withObject:alertView afterDelay:1];
        //[alertView show];
    }else{
        index--;
        [_answe_TableView reloadData];
        self.complete_Button.hidden = YES;
    }
    self.question_Label.text = questionArray[index];
}
- (IBAction)nextAction:(id)sender {
    if(index == questionArray.count-1){
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"This is the last question." message:@"" preferredStyle: UIAlertControllerStyleAlert];
        
        [alertView addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alertView animated:true completion:nil];
        //UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"There's no back ~ " message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        //[self performSelector:@selector(dimissAlert:) withObject:alertView afterDelay:1];
        //[alertView show];
    }else{
        index++;
        [_answe_TableView reloadData];
    }
    //give any following question a original value
    answer = @"1";
    if (answerArray.count-1>=index) {
        //do not give value if already selected
    }else{
        //if does not selected, give a original value to ensure any question is vaild
        [answerArray addObject:answer];
    }
    
    if (answerArray.count-1 == index) {
        self.complete_Button.hidden = NO;
    }
    self.question_Label.text = questionArray[index];
}
- (IBAction)completeAction:(id)sender {
    NSInteger scores = 0;
    for (NSString *score in answerArray) {
        scores+=[score integerValue];
    }
    [[NSUserDefaults standardUserDefaults] setInteger:scores forKey:@"scores"];
    [self.navigationController popViewControllerAnimated:YES];
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
