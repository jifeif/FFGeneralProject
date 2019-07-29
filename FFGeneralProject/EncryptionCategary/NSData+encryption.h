//
//  NSData+encryption.h
//  FFGeneralProject
//
//  Created by jisa on 2019/7/24.
//  Copyright © 2019 jff. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 使用的是EBC填充 PDCS7Padding填充规则
@interface NSData (AES)


/**
 对象转Data

 @param object 要转化的对象
 @return 转化后的Data
 */
+ (NSData *)FF_objectConvertDataWithObject:(id)object;

/**
 将data转化成Base64编码的字符串

 @return 返回字符串
 */
- (NSString *)FF_dataConvertBase64String;

/**
 base64 解码

 @param str 要解码的字符串
 @return 解码后的data
 */
+ (NSData *)FF_Base64DecodeWithStr:(NSString *)str;

/**
 AES128加密

 @param key 秘钥
 @return 返回加密后的字符串 String or nil
 */
- (NSData *)FF_encryptAES128:(NSString *)key;

/**
 AES256加密

 @param key 秘钥
 @return 返回加密后的字符串 String or nil
 */
- (NSData *)FF_encryptAES256:(NSString *)key;



/**
 AES128解密
 
 @param key 密钥
 @return 解析结果 Object or nil
 */
- (id)FF_decryptAES128With:(NSString *)key;

/**
 AES256解密

 @param key 密钥
 @return 解析结果 Object or nil
 */
- (id)FF_decryptAES256With:(NSString *)key;



@end

NS_ASSUME_NONNULL_END
