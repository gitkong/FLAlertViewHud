//
//  FLTableViewCell.h
//  QQTrendsAlertView
//
//  Created by clarence on 16/9/2.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FLPerson,FLTableViewCell;

@protocol FLTableViewCellDelegate <NSObject>

- (void)clickBtn:(UIButton *)btn toShowAlertView:(FLTableViewCell *)cell;

@end

@interface FLTableViewCell : UITableViewCell
@property (nonatomic,strong)FLPerson *person;
@property (nonatomic,weak)id <FLTableViewCellDelegate>delegate;
@end
