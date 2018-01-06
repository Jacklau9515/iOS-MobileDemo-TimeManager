//
//  CategorTableViewCell.m
//  TimeManager
//
//  Created by Xinping Liu on 20/5/17.
//  Copyright © 2017 Xinping Liu. All rights reserved.
//

#import "CategorTableViewCell.h"

@interface CategorTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *category_Label;
@end

@implementation CategorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(CategorTableViewCell *)categoryCell{
    return [[[NSBundle mainBundle]loadNibNamed:@"CategorTableViewCell" owner:self options:nil]lastObject];
}
-(void)setIsChoose:(BOOL)isChoose{
    _isChoose = isChoose;
}
-(void)setCategoryContent:(NSString *)categoryContent{
    
    if (_isChoose == YES) {
        self.isChoose_ImageView.image = [UIImage imageNamed:@"choose"];
    }else{
        self.isChoose_ImageView.image = [UIImage imageNamed:@"noChoose"];
    }
    self.category_Label.text = categoryContent;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

