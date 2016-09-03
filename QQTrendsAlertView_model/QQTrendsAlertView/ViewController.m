//
//  ViewController.m
//  QQTrendsAlertView
//
//  Created by clarence on 16/9/2.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "ViewController.h"
#import "FLPerson.h"
#import "FLTableViewCell.h"
#import "FLAlertViewHud.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,FLTableViewCellDelegate>
@property (nonatomic,strong)NSMutableArray *arrM;
@property (nonatomic,weak)UITableView *tableView;

//test
@property (nonatomic,strong)UIView *alertView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (NSInteger index = 0; index < 10; index ++) {
        FLPerson *person = [[FLPerson alloc] init];
        person.name = [NSString stringWithFormat:@"%@--%zd",@"小咧咧",index];
        
        [self.arrM addObject:person];
    }
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [tableView registerNib:[UINib nibWithNibName:@"FLTableViewCell" bundle:nil] forCellReuseIdentifier:resueId];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
}


#pragma mark - Table view data source & delegate
static NSString * resueId = @"id";

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrM.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resueId forIndexPath:indexPath];
    
    cell.person = self.arrM[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

#pragma mark -- FLTableViewCellDelegate
- (void)clickBtn:(UIButton *)btn toShowAlertView:(FLTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    NSArray *arr = @[
                     [FLAlertViewModel fl_alertViewModelWithTitleName:@"分享" leftImageName:@"Snip20160903_4" alertViewCellType:FLAlertViewHudCellTypeShare],
                     [FLAlertViewModel fl_alertViewModelWithTitleName:@"收藏" leftImageName:@"Snip20160903_5"],
                     [FLAlertViewModel fl_alertViewModelWithTitleName:@"转载照片" leftImageName:@"Snip20160903_6"],
                     [FLAlertViewModel fl_alertViewModelWithTitleName:@"隐藏此条动态" leftImageName:@"Snip20160903_7"],
                     [FLAlertViewModel fl_alertViewModelWithTitleName:@"不看他的动态" leftImageName:@"Snip20160903_8"],
                     [FLAlertViewModel fl_alertViewModelWithTitleName:@"收藏" leftImageName:@"Snip20160903_9"],
                     @""
                     ];
    
    [[FLAlertViewHud shareAlertViewHud] fl_showAround:btn
                                                  arr:arr];
    
    
    [FLAlertViewHud shareAlertViewHud].fl_normalCellOperationBlock = ^(NSInteger row){
        FLAlertViewModel *model = arr[row];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:model.fl_titleName message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    };
    
    [FLAlertViewHud shareAlertViewHud].fl_shareCellOperationBlock = ^(NSInteger index){
        NSLog(@"在 %zd 行 点击%zd按钮",indexPath.row,index);
        NSString *str = nil;
        switch (index) {
            case 0:
                str = @"QQ分享";
                break;
            case 1:
                str = @"微信分享";
                break;
            default:
                str = @"朋友圈分享";
                break;
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    };
}


#pragma mark -- Setter & Getter
- (NSMutableArray *)arrM{
    if (_arrM == nil) {
        _arrM = [NSMutableArray array];
    }
    return _arrM;
}

- (UIView *)alertView{
    if (_alertView == nil) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor redColor];
//        [self.view addSubview:_alertView];
    }
    return _alertView;
}

@end
