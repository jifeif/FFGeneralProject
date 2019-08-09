//
//  JFFImageBrowserView.h
//  FFGeneralProject
//
//  Created by jisa on 2019/8/6.
//  Copyright © 2019 jff. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFFImageBrowserView : UIView

/// 占位图名字
@property (nullable, nonatomic, strong) NSString *placeholdImageName;

/**
 图片浏览器

 @param localImageArr 本地图片
 @param urlImageArr 网络图片
 */
+ (void)FF_showWithLocalImageArr:(nullable NSArray *)localImageArr urlImageArr:(nullable NSArray *)urlImageArr;

/**
 图片浏览器

 @param localImageArr 本地图片
 @param urlImageArr 网络图片
 @param showIndex 展示第几张图片
 */
+ (void)FF_showWithLocalImageArr:(nullable NSArray *)localImageArr urlImageArr:(nullable NSArray *)urlImageArr showIndex:(NSInteger)showIndex;

/**
 测试本地图片浏览的方法
 */
+ (void)FF_TestUse;
@end

NS_ASSUME_NONNULL_END
