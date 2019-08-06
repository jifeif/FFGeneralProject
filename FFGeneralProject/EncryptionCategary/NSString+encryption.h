//
//  NSString+MD5.h
//  FFGeneralProject
//
//  Created by jisa on 2019/7/24.
//  Copyright © 2019 jff. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MD5)
/// MD5 16位的比特 单次加密
- (NSString *)FF_encryptionMD5;
@end

@interface NSString (SHA)
/// SHA256 加密形式
- (NSString *)FF_encryptionSHA256;

/// SHA512 加密形式
- (NSString *)FF_encryptionSHA512;
@end

@interface NSString (whitespace)
/// 去除收尾空格
- (NSString *)FF_trimmingWhtespace;
@end

@interface NSString (URLEncode)
/// 对URL字符串进行编码（百分号形式）
- (NSString *)FF_stringPercentEncoding;
@end

NS_ASSUME_NONNULL_END
