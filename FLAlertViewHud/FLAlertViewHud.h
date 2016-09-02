//
//  FLAlertView.h
//  QQTrendsAlertView
//
//  Created by clarence on 16/9/2.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import <UIKit/UIKit.h>
// 修改弹窗的高度，内部自适应
#define FLTableViewCellHeight 44
typedef enum{
    FLAlertViewHudCellTypeShare,
    FLAlertViewHudCellTypeNormal
}FLAlertViewHudCellType;

// image name key
extern NSString * const FLAlertViewHudLeftImageKey;
// title text key
extern NSString * const FLAlertViewHudTitleLabelKey;
// cell type default is FLAlertViewHudCellTypeNormal
extern NSString * const FLAlertViewHudCellTypeKey;

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
 *  @param arr 字典数组（指定key的字典）
 */
- (void)fl_show:(CGFloat)y arr:(NSArray<NSDictionary *> *)arr;

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
 *  @param arr  字典数组（指定key的字典）
 */
- (void)fl_showAround:(UIView *)view arr:(NSArray<NSDictionary *> *)arr;
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
