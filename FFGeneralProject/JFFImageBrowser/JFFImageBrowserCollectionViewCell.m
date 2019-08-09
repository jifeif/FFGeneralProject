//
//  JFFImageBrowserCollectionViewCell.m
//  FFGeneralProject
//
//  Created by jisa on 2019/8/6.
//  Copyright © 2019 jff. All rights reserved.
//

#import "JFFImageBrowserCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
NSString *const JFFImageBrowserCollectionViewCell_identity = @"JFFImageBrowserCollectionViewCellIdentity";
@interface JFFImageBrowserCollectionViewCell ()
@property (nonatomic, strong) UIImageView *aImageView;
@end

@implementation JFFImageBrowserCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self FF_addSubviews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self FF_layout];
}

#pragma mark -- method
- (void)FF_addSubviews {
    [self.contentView addSubview:self.aImageView];
}

- (void)FF_layout {
    self.aImageView.frame = self.bounds;
}

/// 获取图片
- (UIImage *)FF_acquireImageFromName:(NSString *)name {
    if (name && name.length > 0) {
        UIImage *tempImage = [UIImage imageNamed:name];
        return tempImage;
    }else {
        return nil;
    }
}

#pragma mark -- setter
- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.aImageView.image = [self FF_acquireImageFromName:imageName];
}

- (void)setImageURL:(NSString *)imageURL {
    _imageURL = imageURL;
    if (imageURL && [imageURL hasPrefix:@"http"]) {
        [self.aImageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[self FF_acquireImageFromName:self.placeholdName]];
    }
}


#pragma mark -- lazy
- (UIImageView *)aImageView {
    if (!_aImageView) {
        _aImageView = [[UIImageView alloc] initWithImage:NULL];
        _aImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _aImageView;
}


@end
