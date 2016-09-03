//
//  FLAlertView.h
//  QQTrendsAlertView
//
//  Created by clarence on 16/9/2.
//  Copyright © 2016年 clarence. All rights reserved.
//  思路解释：http://www.jianshu.com/p/ca59771ee382 欢迎关注我啦

#import <UIKit/UIKit.h>
// 修改弹窗的高度，内部自适应
#define FLTableViewCellHeight 44
typedef enum{
    FLAlertViewHudCellTypeShare,
    FLAlertViewHudCellTypeNormal
}FLAlertViewHudCellType;


@interface FLAlertViewModel : NSObject
/**
 *  @author 孔凡列, 16-09-03 08:09:12
 *
 *  title
 */
@property (nonatomic,copy)NSString *fl_titleName;
/**
 *  @author 孔凡列, 16-09-03 08:09:18
 *
 *  left image name
 */
@property (nonatomic,copy)NSString *fl_leftImageName;
/**
 *  @author 孔凡列, 16-09-03 08:09:29
 *
 *  cell type Default is FLAlertViewHudCellTypeNormal
 */
@property (nonatomic,assign)FLAlertViewHudCellType fl_alertViewHudCellType;
/**
 *  @author 孔凡列, 16-09-03 08:09:37
 *
 *  返回一个FLAlertViewModel对象
 *
 *  @param titleName     titleName description
 *  @param leftImageName leftImageName description
 *
 *  @return return value description
 */
+ (instancetype)fl_alertViewModelWithTitleName:(NSString *)titleName leftImageName:(NSString *)leftImageName;
/**
 *  @author 孔凡列, 16-09-03 08:09:13
 *
 *  返回一个FLAlertViewModel对象
 *
 *  @param titleName         titleName description
 *  @param leftImageName     leftImageName description
 *  @param alertViewCellType cell type Default or nil is FLAlertViewHudCellTypeNormal
 *
 *  @return return value description
 */
+ (instancetype)fl_alertViewModelWithTitleName:(NSString *)titleName leftImageName:(NSString *)leftImageName alertViewCellType:(FLAlertViewHudCellType)alertViewCellType;

@end


@interface FLAlertViewHud : NSObject
/**
 *  @author 孔凡列, 16-09-03 05:09:32
 *
 *  单例
 *
 *  @return return value description
 */
+ (instancetype)shareAlertViewHud;
/**
 *  @author 孔凡列, 16-09-03 01:09:47
 *
 *  显示在指定位置
 *
 *  @param y 指定的y值
 */
- (void)fl_show:(CGFloat)y;
/**
 *  @author 孔凡列, 16-09-03 06:09:38
 *
 *  显示在指定位置
 *
 *  @param y   指定的y值
 *  @param arr 模型数组
 */
- (void)fl_show:(CGFloat)y arr:(NSArray<FLAlertViewModel *> *)arr;

/**
 *  @author 孔凡列, 16-09-03 01:09:16
 *
 *  根据弹窗的高度自适应弹窗的显示位置，在view的上面还是下面，目前只有两种情况
 *
 *  @param view view description
 */
- (void)fl_showAround:(UIView *)view;
/**
 *  @author 孔凡列, 16-09-03 06:09:55
 *
 *  根据弹窗的高度自适应弹窗的显示位置，在view的上面还是下面，目前只有两种情况
 *
 *  @param view 指定的view
 *  @param arr  模型数组
 */
- (void)fl_showAround:(UIView *)view arr:(NSArray<FLAlertViewModel *> *)arr;
/**
 *  @author 孔凡列, 16-09-03 06:09:16
 *
 *  消失弹窗
 */
- (void)fl_dismiss;

/**
 *  @author 孔凡列, 16-09-03 01:09:05
 *
 *  分享按钮的点击事件---适应项目需求（可再次封装）
 */
@property (nonatomic,copy)void(^fl_shareCellOperationBlock)(NSInteger index);
/**
 *  @author 孔凡列, 16-09-03 01:09:52
 *
 *  普通cell的点击事件
 */
@property (nonatomic,copy)void(^fl_normalCellOperationBlock)(NSInteger row);



@end
