//
//  ViewController.m
//  FFGeneralProject
//
//  Created by jisa on 2019/7/24.
//  Copyright © 2019 jff. All rights reserved.
//

#import "ViewController.h"
#import "NSData+encryption.h"
#import "JFFImageBrowser/JFFImageBrowserView.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame = CGRectMake(100, 100, 100, 40);
    self.btn.backgroundColor = [UIColor redColor];
    [self.btn addTarget:self action:@selector(FF_btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
}

#pragma mark -- method

- (void)FF_btnClick {
//    JFFImageBrowserView *vi = [[JFFImageBrowserView alloc] initWithFrame:CGRectMake(0, 0, 375, 667)];
//    vi.localImageArr = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg"];
//    [self.view addSubview:vi];
    [JFFImageBrowserView FF_showWithLocalImageArr:@[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg"] urlImageArr:nil showIndex:3];
}

- (void)FF_encrypt {
    NSDictionary *dic = @{@"name":@"ff"};
    NSData *data = [NSData FF_objectConvertDataWithObject:dic];
    NSString *str = [[data FF_encryptAES128:@"1234567890123456"] FF_dataConvertBase64String];
    NSDictionary *dicc = [[NSData FF_Base64DecodeWithStr:str] FF_decryptAES128With:@"1234567890123456"];
    NSLog(@"%@, %@", str, dicc);
}



@end
