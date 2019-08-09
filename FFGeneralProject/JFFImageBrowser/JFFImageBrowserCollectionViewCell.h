//
//  JFFImageBrowserCollectionViewCell.h
//  FFGeneralProject
//
//  Created by jisa on 2019/8/6.
//  Copyright © 2019 jff. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JFFImageBrowserCollectionViewCell_identity;
@interface JFFImageBrowserCollectionViewCell : UICollectionViewCell
/// 图片名字
@property (nonatomic, strong) NSString *imageName;
/// 占位图
@property (nullable, nonatomic, strong) NSString *placeholdName;
/// 图片路径
@property (nonatomic, strong) NSString *imageURL;

@end

NS_ASSUME_NONNULL_END
