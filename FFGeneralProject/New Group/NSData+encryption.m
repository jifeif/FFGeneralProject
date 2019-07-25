
//
//  NSData+encryption.m
//  FFGeneralProject
//
//  Created by jisa on 2019/7/24.
//  Copyright © 2019 jff. All rights reserved.
//

#import "NSData+encryption.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (AES)

/**
 加密
 
 param op 加密还是解密
 param alg 加密或者解密的算法
 param options 加密模式和填充规则  默认为CBC模式，只能设置为PKCS7Padding
 param key 加密串的c表示形式
 param keyLength 加密串的长度
 param iv 可选值 偏移量， 在iOS中使用EBC模式，PSD7的填充行为，偏移量为NULL 不能设置。 如果为CBC模式的话，需要设置偏移量
 param dataIn 加密信息的比特
 param dataInLength 加密信息的长度
 param dataOut 输出的加密信息
 param dataOutAvailable 加密信息的大小
 param dataOutMoved 加密信息的长度
 
 return 返回base64 和 AES128 加密过后的字符串
 */
- (NSString *)FF_encryptAES128:(NSString *)key {
    NSData *data = [self FF_encryptWithKey:key andAESType:kCCKeySizeAES128];
    return [self FF_dataToBase64Str:data];
}

- (NSString *)FF_encryptAES256:(NSString *)key {
    NSData *data = [self FF_encryptWithKey:key andAESType:kCCKeySizeAES128];
    return [self FF_dataToBase64Str:data];
}

/// 转化成base64字符串
- (NSString *)FF_dataToBase64Str:(NSData *)data {
    if (data) {
        NSData *otherData = [data base64EncodedDataWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        return [[NSString alloc] initWithData:otherData encoding:NSUTF8StringEncoding];
    }else {
        NSAssert(data != nil, @"---NSData is null Data, convert String failure ---");
        return nil;
    }
}

/**
 AES加密

 @param key 密钥
 @param type 加密算法keySize
 @return 加密后的字符串
 */
- (NSData *)FF_encryptWithKey:(NSString *)key andAESType:(NSInteger)type {
    NSInteger length = type;
    char keyptr[length + 1];
    bzero(keyptr, sizeof(keyptr));
    BOOL bl = [key getCString:keyptr maxLength:sizeof(keyptr) encoding:NSUTF8StringEncoding];
    if (!bl) {
        NSAssert(bl == YES, @" Accquire Secret Key Failure ");
        return nil;
    }
    void *buffer = malloc(self.length + length);
    size_t bufferSize = self.length + length;
    size_t numberLength = 0;
    CCCryptorStatus status = CCCrypt(kCCEncrypt, kCCAlgorithmAES, kCCOptionECBMode | kCCOptionPKCS7Padding, keyptr, length, NULL, self.bytes, self.length, buffer, bufferSize, &numberLength);
    if (status == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:numberLength];
        return data;
    }else {
        NSAssert(status == 0, @" Encryption Failure ");
        return nil;
    }

}



/// AES128解密
- (id)FF_decryptAES128With:(NSString *)key {
    NSData *data = [self FF_decryptWith:key andAESType:kCCKeySizeAES128];
    return [self FF_jsonToObjectWithData:data];
}

/// AES256解密
- (id)FF_decryptAES256With:(NSString *)key {
    NSData *data = [self FF_decryptWith:key andAESType:kCCKeySizeAES256];
    return [self FF_jsonToObjectWithData:data];
}

/**
 JSON 转 Object

 @param data 要转化的数据
 @return 转化后的对象
 */
- (id)FF_jsonToObjectWithData:(NSData *)data {
    if (data) {
        id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        return object;
    }else {
        NSAssert(data != nil, @"Data is NULL");
        return nil;
    }
}

/**
 AES解密

 @param key 密钥
 @param type AES算法类型
 @return 解密结果NSData
 */
- (NSData *)FF_decryptWith:(NSString *)key andAESType:(NSInteger)type {
    char keyptr[kCCKeySizeAES128 + 1];
    bzero(keyptr, sizeof(keyptr));
    BOOL bl = [key getCString:keyptr maxLength:sizeof(keyptr) encoding:NSUTF8StringEncoding];
    if (!bl) {
        NSAssert(bl == YES, @"Access Secret Key Failure");
        return nil;
    }
    void *buffer = malloc(self.length + kCCKeySizeAES128);
    size_t bufferLength = self.length + kCCKeySizeAES128;
    size_t numberLength = 0;
    CCCryptorStatus status = CCCrypt(kCCDecrypt, kCCAlgorithmAES, kCCOptionECBMode | kCCOptionPKCS7Padding, keyptr, kCCKeySizeAES128, NULL, self.bytes, self.length, buffer, bufferLength, &numberLength);
    if (status == kCCSuccess) {
        NSData *data = [NSData dataWithBytesNoCopy:buffer length:numberLength];
        return data;
    }else {
        NSAssert(status == 0, @"Decryption Failure");
        return nil;
    }

}


/******************************************************************/
/// 将对象转化成NSData
+ (NSData *)FF_objectConvertDataWithObject:(id)object {
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSAssert(NO, error.localizedDescription);
        return nil;
    }
    return data;
}


@end
