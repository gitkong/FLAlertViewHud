//
//  FLAlertView.m
//  QQTrendsAlertView
//
//  Created by clarence on 16/9/2.
//  Copyright © 2016年 clarence. All rights reserved.
//  思路解释 ：http://www.jianshu.com/p/ca59771ee382

#import "FLAlertViewHud.h"
#define FLScreenHeight [UIScreen mainScreen].bounds.size.height
#define FLScreenWidth [UIScreen mainScreen].bounds.size.width
#define FLDefaultTableViewHeight 2 * FLTableViewCellHeight

@implementation FLAlertViewModel

- (instancetype)init{
    if (self = [super init]) {
        // 默认
        self.fl_titleName = @"小咧咧";
        self.fl_leftImageName = @"";
        self.fl_alertViewHudCellType = FLAlertViewHudCellTypeNormal;
    }
    return self;
}

+ (instancetype)fl_alertViewModelWithTitleName:(NSString *)titleName leftImageName:(NSString *)leftImageName{
    return [self fl_alertViewModelWithTitleName:titleName leftImageName:leftImageName alertViewCellType:FLAlertViewHudCellTypeNormal];
}

+ (instancetype)fl_alertViewModelWithTitleName:(NSString *)titleName leftImageName:(NSString *)leftImageName alertViewCellType:(FLAlertViewHudCellType)alertViewCellType{
    FLAlertViewModel *model = [[self alloc] init];
    model.fl_titleName = titleName;
    model.fl_leftImageName = leftImageName;
    if (alertViewCellType) {
        model.fl_alertViewHudCellType = alertViewCellType;
    }
    else{
        model.fl_alertViewHudCellType = FLAlertViewHudCellTypeNormal;
    }
    return model;
}

@end

@interface FLAlertViewNormalCell : UITableViewCell
// left image view
@property (nonatomic,strong)UIImageView *leftIamgeView;
// title view
@property (nonatomic,strong)UILabel *titleLab;

@end

@implementation FLAlertViewNormalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // init subViews
        self.leftIamgeView = [[UIImageView alloc] init];
        [self addSubview:self.leftIamgeView];
        self.titleLab = [[UILabel alloc] init];
        [self addSubview:self.titleLab];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat cellHeight = self.frame.size.height;
    CGFloat cellWidth = self.frame.size.width;
    CGFloat leftPadding = 10;
    CGFloat imageWidth = cellHeight * 0.5;
    CGFloat titleLabelHeight = cellHeight * 0.6;
    self.leftIamgeView.frame = CGRectMake(2 * leftPadding, (cellHeight - imageWidth) / 2, imageWidth, imageWidth);
    CGFloat labelWidth = CGRectGetMaxX(self.leftIamgeView.frame) + 2 * leftPadding;
    self.titleLab.frame = CGRectMake(labelWidth, (cellHeight- titleLabelHeight) / 2, cellWidth - labelWidth, titleLabelHeight);
}

@end

@class FLAlertViewShareCell;
@protocol FLAlertViewShareCellDelegate <NSObject>

- (void)clickIndex:(NSInteger)index shareCell:(FLAlertViewShareCell *)shareCell;

@end

@interface FLAlertViewShareCell : FLAlertViewNormalCell
// share button
@property (nonatomic,strong)NSMutableArray *shareButtonArrM;

@property (nonatomic,weak)id<FLAlertViewShareCellDelegate> delegate;

@property (nonatomic,strong)FLAlertViewModel *alertViewModel;

@end

@implementation FLAlertViewShareCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        for (NSInteger index = 0; index < 3; index ++) {
            UIButton *shareBtn = [[UIButton alloc] init];
            [shareBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"Snip20160903_%zd",index + 1]] forState:UIControlStateNormal];
            shareBtn.tag = index;
            shareBtn.backgroundColor = [UIColor orangeColor];
            [shareBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.shareButtonArrM addObject:shareBtn];
        }
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat cellHeight = self.frame.size.height;
    CGFloat cellWidth = self.frame.size.width;
    CGFloat leftPadding = 10;
    CGFloat shareBtnWidth = cellHeight * 0.65;
    UIButton *shareBtn = self.shareButtonArrM[self.shareButtonArrM.count - 1];
    shareBtn.frame = CGRectMake(cellWidth - shareBtnWidth - leftPadding, (cellHeight - shareBtnWidth) / 2, shareBtnWidth, shareBtnWidth);
    
    UIButton *shareBtn1 = self.shareButtonArrM[self.shareButtonArrM.count - 2];
    shareBtn1.frame = CGRectMake(cellWidth - (shareBtnWidth + leftPadding) * 2 - 20 , (cellHeight - shareBtnWidth) / 2, shareBtnWidth, shareBtnWidth);
    
    UIButton *shareBtn2 = self.shareButtonArrM[self.shareButtonArrM.count - 3];
    shareBtn2.frame = CGRectMake(cellWidth - (shareBtnWidth + leftPadding) * 3 - 20 - 20 , (cellHeight - shareBtnWidth) / 2, shareBtnWidth, shareBtnWidth);
    
}

- (void)btnClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(clickIndex:shareCell:)]) {
        [self.delegate clickIndex:btn.tag shareCell:self];
    }
}

#pragma mark - setter & getter

- (void)setAlertViewModel:(FLAlertViewModel *)alertViewModel{
    _alertViewModel = alertViewModel;
    if (alertViewModel.fl_alertViewHudCellType == FLAlertViewHudCellTypeShare) {
        for (UIButton *shareBtn in self.shareButtonArrM) {
            [self addSubview:shareBtn];
        }
    }
    else if (alertViewModel.fl_alertViewHudCellType == FLAlertViewHudCellTypeNormal){
        for (UIButton *shareBtn in self.shareButtonArrM) {
            [shareBtn removeFromSuperview];
        }
    }
    
    self.leftIamgeView.image = [UIImage imageNamed:alertViewModel.fl_leftImageName];
    self.titleLab.text = alertViewModel.fl_titleName;
}

- (NSMutableArray *)shareButtonArrM{
    if (_shareButtonArrM == nil) {
        _shareButtonArrM = [NSMutableArray array];
    }
    return _shareButtonArrM;
}

@end

@class FLAlertView;
@protocol FLAlertViewDelegate <NSObject>

- (void)shareButtonDidClick:(NSInteger)index alertView:(FLAlertView *)alertView;

- (void)normalCellDidClick:(NSInteger)row alertView:(FLAlertView *)alertView;

@end

@interface FLAlertView : UIView<UITableViewDelegate,UITableViewDataSource,FLAlertViewShareCellDelegate>
// init tableView
@property (nonatomic,strong)UITableView *tableView;
// dataArr
@property (nonatomic,strong)NSMutableArray *dataArrM;

@property (nonatomic,weak)id<FLAlertViewDelegate>delegate;

@end

@implementation FLAlertView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // init tableView
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.scrollEnabled = NO;
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
//cell的组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //    默认一组
    return 1;
}
//cell的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArrM.count;
}

/**
 *  设置cell的数据
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FLAlertViewShareCell *cell = [[FLAlertViewShareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FLAlertViewShareCellReuseId"];
    cell.alertViewModel = self.dataArrM[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FLTableViewCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FLAlertViewModel *model = self.dataArrM[indexPath.row];
    if (model.fl_alertViewHudCellType == FLAlertViewHudCellTypeShare) {
        
    }
    else if (model.fl_alertViewHudCellType == FLAlertViewHudCellTypeNormal){
        if ([self.delegate respondsToSelector:@selector(normalCellDidClick:alertView:)]) {
            [self.delegate normalCellDidClick:indexPath.row alertView:self];
        }
    }
}

- (void)clickIndex:(NSInteger)index shareCell:(FLAlertViewShareCell *)shareCell{
    if ([self.delegate respondsToSelector:@selector(shareButtonDidClick:alertView:)]) {
        [self.delegate shareButtonDidClick:index alertView:self];
    }
}

#pragma mark - setter & getter
- (NSMutableArray *)dataArrM{
    if (_dataArrM == nil) {
        // 适应项目需求，只有两个
        _dataArrM = [NSMutableArray array];
    }
    return _dataArrM;
}

@end


// <UIGestureRecognizerDelegate> 给NSObject
@interface FLAlertViewHud ()<UIGestureRecognizerDelegate,FLAlertViewDelegate>
@property (nonatomic,weak)UIView *coverView ;
// FLAlertView
@property (nonatomic,strong)FLAlertView *alertView;
@end


@implementation FLAlertViewHud

static FLAlertViewHud *instance = nil;
+ (instancetype)shareAlertViewHud{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
    });
    return instance;
}

- (void)fl_show:(CGFloat)y{
    [self fl_show:y arr:nil];
}

- (void)fl_show:(CGFloat)y arr:(NSArray<NSDictionary *> *)arr{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGFloat leftWidth = 10;
    self.alertView = [[FLAlertView alloc] initWithFrame: CGRectMake(FLScreenWidth - 2 * leftWidth, y, FLScreenWidth - 2 * leftWidth, arr ? arr.count * FLTableViewCellHeight : FLDefaultTableViewHeight)];
    self.alertView.delegate = self;
    self.alertView.layer.cornerRadius = 10;
    self.alertView.layer.masksToBounds = YES;
    
    if (arr) {
        NSAssert([arr.lastObject isKindOfClass:[FLAlertViewModel class]], @"请保证数组的元素都是FLAlertViewModel 对象");
        for (FLAlertViewModel *model in arr) {
            [self.alertView.dataArrM addObject:model];
        }
    }
    else{
        // 默认两个
        [self.alertView.dataArrM addObjectsFromArray:@[
                                                       [FLAlertViewModel fl_alertViewModelWithTitleName:@"分享" leftImageName:@"Snip20160903_4" alertViewCellType:FLAlertViewHudCellTypeShare],[FLAlertViewModel fl_alertViewModelWithTitleName:@"删除" leftImageName:@"Snip20160903_5"]
                                                       ]];
    }
    [self.alertView.tableView reloadData];
    
    // 添加遮盖的view
    UIView *coverView = [[UIView alloc] initWithFrame:window.bounds];
    coverView.backgroundColor = [UIColor grayColor];
    
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToDismiss:)];
    tapG.delegate = self;
    [coverView addGestureRecognizer:tapG];
    [window addSubview:coverView];
    [window addSubview:self.alertView];
    
    // 执行动画
    coverView.alpha = 0.0;
    self.alertView.alpha = 0.0;
    [UIView animateWithDuration:0.2 animations:^{
        self.alertView.alpha = 0.3;
        coverView.alpha = 0.1;
        [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:0 animations:^{
            self.alertView.alpha = 0.6;
            self.alertView.frame = CGRectMake(leftWidth, y, FLScreenWidth - 2 * leftWidth, arr ? arr.count * FLTableViewCellHeight : FLDefaultTableViewHeight);
            coverView.alpha = 0.2;
        } completion:^(BOOL finished) {
            self.alertView.alpha = 1.0;
            coverView.alpha = 0.3;
        }];
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)fl_showAround:(UIView *)view{
    [self fl_showAround:view arr:nil];
}

- (void)fl_showAround:(UIView *)view arr:(NSArray<NSDictionary *> *)arr{
    CGRect rect = [view convertRect:view.frame toView:[UIApplication sharedApplication].keyWindow];
    CGFloat padding = FLScreenHeight - rect.origin.y;
    CGFloat y = 0.0;
    // 额外加多40判断，避免底部出现刚刚好挡住
    if (padding > (arr ? arr.count * FLTableViewCellHeight : FLDefaultTableViewHeight) + 40){
        // 显示在下面
        y = rect.origin.y + view.bounds.size.height;
    }
    else{
        // 显示在上面
        // 额外加20 间隔
        y = rect.origin.y - (arr ? arr.count * FLTableViewCellHeight : FLDefaultTableViewHeight) - 20;
    }
    [self fl_show:y arr:arr];
    
}

#pragma mark - UIGestureRecognizerDelegate 可以不实现
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}

- (void)fl_dismiss{
    // 销毁
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    for (NSInteger index = 0; index < 2; index ++) {
        UIView *view = window.subviews.lastObject;
        [view removeFromSuperview];
    }
}

- (void)clickToDismiss:(UIGestureRecognizer *)ges{
    [self fl_dismiss];
}


- (void)shareButtonDidClick:(NSInteger)index alertView:(FLAlertView *)alertView{
    self.fl_shareCellOperationBlock(index);
    [self fl_dismiss];
}

- (void)normalCellDidClick:(NSInteger)row alertView:(FLAlertView *)alertView{
    self.fl_normalCellOperationBlock(row);
    [self fl_dismiss];
}


@end
