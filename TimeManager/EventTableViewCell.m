//
//  EventTableViewCell.m
//  TimeManager
//
//  Created by Xinping Liu on 20/5/17.
//  Copyright © 2017 Xinping Liu. All rights reserved.
//

#import "EventTableViewCell.h"

@interface EventTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *eventTitle_Label;

@property (weak, nonatomic) IBOutlet UILabel *eventDatial_Label;

@property (weak, nonatomic) IBOutlet UILabel *eventDate_Label;

@property (weak, nonatomic) IBOutlet UIButton *delete_Button;
@property (weak, nonatomic) IBOutlet UIButton *update_Button;
@end

@implementation EventTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(EventTableViewCell *)eventCell{
    return [[[NSBundle mainBundle]loadNibNamed:@"EventTableViewCell" owner:self options:nil]lastObject];
}
-(void)setIsEdit:(BOOL)isEdit{
    _isEdit = isEdit;
}
-(void)setModel:(EventModel *)model{
    self.eventTitle_Label.text = model.title;
    self.eventDatial_Label.text = model.detail;
    self.eventDate_Label.text = model.date;
    if (_isEdit == YES) {
        self.delete_Button.hidden = NO;
        self.update_Button.hidden = NO;
        self.delete_Button.tag = [model.responseid integerValue];
        self.update_Button.tag = [model.responseid integerValue];
        self.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:175.0/255.0 blue:97.0/255.0 alpha:1];
    }else{
        self.delete_Button.hidden = YES;
        self.update_Button.hidden = YES;
    }
    
}

- (IBAction)deleteAction:(id)sender {
    UIButton *button = (UIButton*)sender;
    if ([self.delegate respondsToSelector:@selector(deleteEventWithID:)]) {
        [self.delegate deleteEventWithID:[NSString stringWithFormat:@"%ld",button.tag]];
    }
}

- (IBAction)updateAction:(id)sender {
    UIButton *button = (UIButton*)sender;
    if ([self.delegate respondsToSelector:@selector(updateEventWithID:)]) {
        [self.delegate updateEventWithID:[NSString stringWithFormat:@"%ld",button.tag]];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
