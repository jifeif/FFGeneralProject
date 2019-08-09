//
//  JFFImageBrowserView.m
//  FFGeneralProject
//
//  Created by jisa on 2019/8/6.
//  Copyright © 2019 jff. All rights reserved.
//

#import "JFFImageBrowserView.h"
#import "JFFImageBrowserCollectionViewCell.h"

@interface JFFImageBrowserView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *aCollectionView;

/// 本地图片数组
@property (nonatomic, strong) NSArray *localImageArr;
/// URL数组
@property (nonatomic, strong) NSArray *urlImageArr;
/// 展示第几张图片
@property (nonatomic, assign) NSInteger showIndex;
/// 初始化设置
@property (nonatomic, assign) BOOL     isFirst;

@end




@implementation JFFImageBrowserView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self FF_initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self FF_initialize];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self FF_layout];
}

#pragma mark -- class method

+ (void)FF_TestUse {
    [self FF_showWithLocalImageArr:@[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg"] urlImageArr:nil];
}

+ (void)FF_showWithLocalImageArr:(nullable NSArray *)localImageArr urlImageArr:(nullable NSArray *)urlImageArr {
    [self FF_showWithLocalImageArr:localImageArr urlImageArr:urlImageArr showIndex:0];
}


+ (void)FF_showWithLocalImageArr:(nullable NSArray *)localImageArr urlImageArr:(nullable NSArray *)urlImageArr showIndex:(NSInteger)showIndex {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    JFFImageBrowserView *browserView = [[JFFImageBrowserView alloc] initWithFrame:window.bounds];
    browserView.showIndex = showIndex;
    if (localImageArr && localImageArr.count > 0) {
        browserView.localImageArr = localImageArr;
    }
    if (urlImageArr && urlImageArr.count > 0) {
        browserView.urlImageArr = urlImageArr;
    }
    browserView.showIndex = showIndex;
    browserView.layer.opacity = 0.0;
    browserView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [window addSubview:browserView];
    [UIView animateWithDuration:0.25 animations:^{
        browserView.layer.opacity = 1.0;
        browserView.transform = CGAffineTransformIdentity;
    }];
    
}

#pragma mark -- method
- (void)FF_initialize {
    self.urlImageArr = @[];
    self.showIndex = 0;
    self.isFirst = YES;
}

- (void)FF_layout {
    if (_aCollectionView) {
        self.aCollectionView.frame = self.bounds;
    }
}

- (void)FF_dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformMakeScale(0.1, 0.1);
        self.layer.opacity = 0.1;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark -- KVO
- (void)FF_setUpKVO {
    [self.aCollectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (self.isFirst && self.showIndex > 0 && [keyPath isEqualToString:@"contentSize"]) {
        CGFloat wid = [UIScreen mainScreen].bounds.size.width;
        if (self.aCollectionView.contentSize.width > wid) {
            [self.aCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:self.showIndex inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
            self.isFirst = NO;
        }
    }
}


#pragma mark -- set
- (void)setUrlImageArr:(NSArray *)urlImageArr {
    _urlImageArr = urlImageArr;
    if (_aCollectionView) {
        [self addSubview:self.aCollectionView];
        [self FF_setUpKVO];
    }else {
        [self.aCollectionView reloadData];
    }
}

- (void)setLocalImageArr:(NSArray *)localImageArr {
    _localImageArr = localImageArr;
    if (_aCollectionView) {
        [self addSubview:self.aCollectionView];
        [self FF_setUpKVO];
    }else {
        [self.aCollectionView reloadData];
    }
}


#pragma mark -- datasource Protocol
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.localImageArr ? self.localImageArr.count : self.urlImageArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JFFImageBrowserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JFFImageBrowserCollectionViewCell_identity forIndexPath:indexPath];
    cell.placeholdName = self.placeholdImageName;
    if (self.urlImageArr.count > 0 && self.urlImageArr.count > indexPath.row) {
        cell.imageURL = self.urlImageArr[indexPath.row];
    }
    if (self.localImageArr.count > 0 && self.localImageArr.count > indexPath.row) {
        cell.imageName = self.localImageArr[indexPath.row];
    }
    return cell;
}

#pragma mark -- collectionView delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self FF_dismiss];
}


#pragma mark -- lazy
- (UICollectionView *)aCollectionView {
    if (!_aCollectionView) {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowlayout.itemSize = [UIScreen mainScreen].bounds.size;
        flowlayout.minimumLineSpacing = 0;
        flowlayout.minimumInteritemSpacing = 0;
        
        _aCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
        [_aCollectionView registerClass:[JFFImageBrowserCollectionViewCell class] forCellWithReuseIdentifier:JFFImageBrowserCollectionViewCell_identity];
        _aCollectionView.dataSource = self;
        _aCollectionView.pagingEnabled = YES;
        _aCollectionView.delegate = self;
    }
    return _aCollectionView;
}



@end
