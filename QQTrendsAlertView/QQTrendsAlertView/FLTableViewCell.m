//
//  FLTableViewCell.m
//  QQTrendsAlertView
//
//  Created by clarence on 16/9/2.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "FLTableViewCell.h"
#import "FLPerson.h"
@interface FLTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation FLTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setPerson:(FLPerson *)person{
    _person = person;
    self.name.text = person.name;
}


- (IBAction)click:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickBtn:toShowAlertView:)]) {
        [self.delegate clickBtn:(UIButton *)sender toShowAlertView:self];
    }
}

@end
