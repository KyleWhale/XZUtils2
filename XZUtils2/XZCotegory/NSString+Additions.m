//
//  NSString+Additions.m
//  EducationOL
//
//  Created by apple on 2021/8/17.
//

#import "NSString+Additions.h"
#import "YYCategories.h"

@implementation NSString (Additions)

//判断是否是null 如果是空返回@""
+ (NSString *)stringNullDealWith:(NSString *)str
{
    if ([str isKindOfClass:[NSNull class]]) {
        return @"";
    }
    if (str == nil || str == NULL || [str  isEqual: @"(null)"] || [str isEqual:@"<null>"]) {
        return @"";
    }
    if ([str isKindOfClass:[NSString class]]) {
        if ([str isEqual:@"null"] || [str hasPrefix:@"null"]) {
            return @"";
        }
        
    }
    return [NSString stringWithFormat:@"%@",str];
}

//判断是否是null 如果是空返回@"0"
+ (NSString *)numberStrNullDealWith:(NSString *)str
{
    if ([str isKindOfClass:[NSNull class]]) {
        return @"0";
    }
    if (str == nil || str == NULL || [str  isEqual: @"(null)"] || [str isEqual:@"<null>"]) {
        return @"0";
    }
    if ([str isKindOfClass:[NSString class]]) {
        if ([str isEqual:@"null"] || [str hasPrefix:@"null"]) {
            return @"0";
        }
        
    }
    return [NSString stringWithFormat:@"%@",str];
}

- (NSInteger)getStringLengthOfBytes {
    NSInteger lengthOfString = 0;
    for (int i = 0; i < self.length; i++) {
        //获取每个位置上的字符串
        NSString *subString = [self substringWithRange:NSMakeRange(i, 1)];
        //检测是否为中文或者中文符号--中文为两个字符长度 英文为一个字符长度
        if ([self validateChineseChar:subString]) {
            lengthOfString += 2;
        } else {
            lengthOfString += 1;
        }
    }
    return lengthOfString;
}

- (NSString *)subBytesOfStringToIndex:(NSInteger)index {
    NSInteger length = 0;//总长度
    NSInteger chineseLength = 0;//中文长度
    NSInteger charLength = 0;//字符长度
    //截取每个位置上的字符串
    for (int i = 0; i < self.length; i++) {
        NSString *subString = [self substringWithRange:NSMakeRange(i, 1)];
        if ([self validateChinese:subString]) {
            if (length + 2 > index) {
                return [self substringToIndex:(chineseLength + charLength)];
            }
            length += 2;
            chineseLength += 1;
        } else {
            if (length + 1 > index) {
                return [self substringToIndex:(chineseLength + charLength)];
            }
            length += 1;
            charLength += 1;
        }
    }
    return [self substringToIndex:index];
}

/**
 *  检测中文或者中文符号
 */
- (BOOL)validateChineseChar:(NSString *)string
{
    NSString *nameRegEx = @"[\\u0391-\\uFFE5]";
    if (![string isMatchesRegularExp:nameRegEx]) {
        return NO;
    }
    return YES;
}

/**
 *  检测中文
 */
- (BOOL)validateChinese:(NSString*)string
{
    NSString *nameRegEx = @"[\u4e00-\u9fa5]";
    if (![string isMatchesRegularExp:nameRegEx]) {
        return NO;
    }
    return YES;
}

- (BOOL)isMatchesRegularExp:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

#pragma mark 检验是否是身份证号码
 - (BOOL)isIdentityCard
 {
     if (self.stringByTrim.length != 18) {
         return NO;
     }
     NSMutableArray *IDArray = [NSMutableArray array];
     // 遍历身份证字符串,存入数组中
     for (int i = 0; i < 18; i++) {
         NSRange range = NSMakeRange(i, 1);
         NSString *subString = [self substringWithRange:range];
         [IDArray addObject:subString];
     }
     // 系数数组
     NSArray *coefficientArray = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
     // 余数数组
     NSArray *remainderArray = [NSArray arrayWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", nil];
     // 每一位身份证号码和对应系数相乘之后相加所得的和
     int sum = 0;
     for (int i = 0; i < 17; i++) {
         int coefficient = [coefficientArray[i] intValue];
         int ID = [IDArray[i] intValue];
         sum += coefficient * ID;
     }
    // 这个和除以11的余数对应的数
    NSString *str = remainderArray[(sum % 11)];
   // 身份证号码最后一位
   NSString *string = [self substringFromIndex:17];
    // 如果这个数字和身份证最后一位相同,则符合国家标准,返回YES
     if ([str isEqualToString:string]) {
        return YES;
    } else {
         return NO;
     }
 }

+ (NSString *)stringWithPrice:(NSString *)price{
    if ([self judgeStr:@"10000" with:price]&&price.integerValue!=0) {
        NSString * priceStr = [NSString stringWithFormat:@"¥%ld万",price.integerValue/10000];
        return priceStr;
    } else {
        NSString * priceStr = [NSString stringWithFormat:@"¥%@",price];
        return priceStr;
    }
}

+(BOOL)judgeStr:(NSString *)str1 with:(NSString *)str2
{
    int a=[str1 intValue];
    double s1=[str2 doubleValue];
    int s2=[str2 intValue];

    if (s1/a-s2/a>0) {
        return NO;
    }
    return YES;
}

+(NSString*)deleteFloatAllZero:(NSString*)string
{
    NSArray * arrStr=[string componentsSeparatedByString:@"."];
    NSString *str=arrStr.firstObject;
    NSString *str1=arrStr.lastObject;
    while ([str1 hasSuffix:@"0"]) {
        str1=[str1 substringToIndex:(str1.length-1)];
    }
    return (str1.length>0)?[NSString stringWithFormat:@"%@.%@",str,str1]:str;
}

+ (BOOL)onlySpace:(NSString *)str{
    if (str.length>0) {
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (str.length==0) {
            return YES;
        }
    }
    return NO;
}

+(NSString *)getDeleteForeAfyString:(NSString *)str{
    //去除首尾空格：
//    NSString * content = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (![str isKindOfClass:[NSString class]]) {
        return str;
    }
    //去除首尾空格和换行：
    NSString *content = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return content;
}

+(NSString *)getIdentityCardAge:(NSString *)idcardStr{
    NSDateFormatter *formatterTow = [[NSDateFormatter alloc]init];
    [formatterTow setDateFormat:@"yyyy-MM-dd"];
    NSDate *bsyDate = [formatterTow dateFromString:[NSString birthdayStrFromIdentityCard:idcardStr]];
    NSTimeInterval dateDiff = [bsyDate timeIntervalSinceNow];
    int age = trunc(dateDiff/(60*60*24))/365;
    return [NSString stringWithFormat:@"%d",-age];
}

+(NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr
{
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    BOOL isAllNumber = YES;
    NSString *day = nil;
    if([numberStr length]<18)
        return result;
    //**从第6位开始 截取8个数
    NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(6, 8)];
    //**检测前12位否全都是数字;
    const char *str = [fontNumer UTF8String];
    const char *p = str;
    while (*p!='\0') {
        if(!(*p>='0'&&*p<='9'))
            isAllNumber = NO;
        p++;
    }
    if(!isAllNumber)
        return result;
    year = [NSString stringWithFormat:@"%@",[numberStr substringWithRange:NSMakeRange(6, 4)]];
    month = [numberStr substringWithRange:NSMakeRange(10, 2)];
    day = [numberStr substringWithRange:NSMakeRange(12,2)];
    [result appendString:year];
    [result appendString:@"-"];
    [result appendString:month];
    [result appendString:@"-"];
    [result appendString:day];
    NSLog(@"result===%@",result);
    return result;
}
/**
 
 *  从身份证上获取性别
 
 */

+(NSString *)getIdentityCardSex:(NSString *)numberStr
{
    NSString *sex = @"";
    //获取18位 二代身份证  性别
    if (numberStr.length==18)
    {
        int sexInt=[[numberStr substringWithRange:NSMakeRange(16,1)] intValue];
        if(sexInt%2!=0)
        {
            NSLog(@"1");
            sex = @"男";
        }
        else
        {
            NSLog(@"2");
            sex = @"女";
        }
    }
    //  获取15位 一代身份证  性别
    if (numberStr.length==15)
    {
        int sexInt=[[numberStr substringWithRange:NSMakeRange(14,1)] intValue];
        if(sexInt%2!=0)
        {
            NSLog(@"1");
            sex = @"男";
        }
        else
        {
            NSLog(@"2");
            sex = @"女";
        }
    }
    return sex;
}

-(NSString *)getIdentityShieldStr{
    NSString *shieldStr = @"";
    if (![self isNotBlank]) {
        shieldStr = @"";
    }
    if (self.length == 18) {
        shieldStr = [NSString stringWithFormat:@"%@***********%@",[self substringToIndex:3],[self substringFromIndex:14]];
    }else if (self.length > 2){
        shieldStr = [NSString stringWithFormat:@"%@**",[self substringWithRange:NSMakeRange(0, self.length - 2)]];
    }
    return shieldStr;
}
- (NSString *)getVideoTimeStr{
    NSInteger time = self.integerValue;
    if (time < 60) {
        return [NSString stringWithFormat:@"00:%02ld", (time % 60)];
    }else if (time >= 60 && time < 3600) {
        return [NSString stringWithFormat:@"%02ld:%02ld", (time / 60 % 60),(time % 60)];
    }else{
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (time / 3600),(time / 60 % 60),(time % 60)];
    }
}

@end
