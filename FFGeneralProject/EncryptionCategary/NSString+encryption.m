//
//  NSString+MD5.m
//  FFGeneralProject
//
//  Created by jisa on 2019/7/24.
//  Copyright © 2019 jff. All rights reserved.
//

#import "NSString+encryption.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)
/// MD5 32字节 单次加密
- (NSString *)FF_encryptionMD5 {
    if (self && self.length > 0) {
        const char *data = [self UTF8String];
        unsigned char need[CC_MD5_DIGEST_LENGTH];
        
        CC_MD5(data, (int)strlen(data), need);
        NSMutableString *str = [NSMutableString string];
        for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
            [str appendFormat:@"%02x", need[i]];
        }
        return [NSString stringWithString:str];
    }else {
        return @"";
    }
}
@end

@implementation NSString (SHA)

/// SHA256 加密形式
- (NSString *)FF_encryptionSHA256 {
    const char * data = [self UTF8String];
    unsigned char need[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data, (int)strlen(data), need);
    NSMutableString *str = [NSMutableString string];
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [str appendFormat:@"%02x", need[i]];
    }
    return [NSString stringWithString:str];
}

/// SHA512 加密形式
- (NSString *)FF_encryptionSHA512 {
    const char * data = [self UTF8String];
    unsigned char need[CC_SHA512_DIGEST_LENGTH];
    CC_SHA256(data, (int)strlen(data), need);
    NSMutableString *str = [NSMutableString string];
    for (int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
        [str appendFormat:@"%02x", need[i]];
    }
    return [NSString stringWithString:str];
}


@end
