//
//  ViewController.m
//  FFGeneralProject
//
//  Created by jisa on 2019/7/24.
//  Copyright © 2019 jff. All rights reserved.
//

#import "ViewController.h"
#import "NSData+encryption.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dic = @{@"name":@"ff"};
    NSData *data = [NSData FF_objectConvertDataWithObject:dic];
    NSString *str = [data FF_encryptAES128:@"1234567890123456"];
    NSData *other = [str dataUsingEncoding:NSUTF8StringEncoding];
    other = [[NSData alloc] initWithBase64EncodedData:other options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSDictionary *dicc = [other FF_decryptAES128With:@"1234567890123456"];
    NSLog(@"%@, %@", str, dicc);
    
    // Do any additional setup after loading the view.
}


@end
