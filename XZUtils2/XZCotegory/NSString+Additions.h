//
//  NSString+Additions.h
//  EducationOL
//
//  Created by apple on 2021/8/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Additions)

//判断是否是null 如果是空返回@""
+ (NSString *)stringNullDealWith:(NSString *)str;
//判断是否是null 如果是空返回@"0"
+ (NSString *)numberStrNullDealWith:(NSString *)str;

/**
 *  获取字符串中字符长度
 */
- (NSInteger)getStringLengthOfBytes;

/**
 *  截取指定长度的字符串
 */
- (NSString *)subBytesOfStringToIndex:(NSInteger)index;

///是否身份证号
- (BOOL)isIdentityCard;

+ (NSString *)stringWithPrice:(NSString *)price;

+(BOOL)judgeStr:(NSString *)str1 with:(NSString *)str2;

///是否只包含空格
+ (BOOL)onlySpace:(NSString *)str;

+(NSString *)getDeleteForeAfyString:(NSString *)str;

+(NSString *)getIdentityCardAge:(NSString *)idcardStr;

+(NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr;

+(NSString *)getIdentityCardSex:(NSString *)numberStr;
///身份证屏蔽
-(NSString*)getIdentityShieldStr;
/**
 将以秒为单位的整形数字转换为“时：分：秒”格式的字符串

 @param time 秒
 @return “xx:xx:xx”
 */
-(NSString *)getVideoTimeStr;

@end

NS_ASSUME_NONNULL_END
