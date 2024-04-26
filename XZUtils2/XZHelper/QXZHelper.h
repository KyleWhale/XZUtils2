//
//  QXZHelper.h
//  youyisi
//
//  Created by apple on 2021/11/3.
//  Copyright © 2021 李维佳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    VIEWCOLORVERTICALTYPE,//纵向
    VIEWCOLORTRANSVERSETYPE,//横向
} VIEWCOLORSTYLETYPE;

NS_ASSUME_NONNULL_BEGIN

@interface QXZHelper : NSObject
//数字专汉字
+ (NSString *)translation:(NSString *)arebic;
//获取当前控制器
+ (UIViewController *)getCurrentVC;

+(NSString*)formatDate:(NSDate*)d format:(NSString*)str;

+ (void)setupView:(UIView *)view colors:(NSArray *)colors type:(VIEWCOLORSTYLETYPE)type frame:(CGRect)frame;
//判断是否是18位身份证
+ (BOOL)isVaildIDCardNo:(NSString *)idCardNo;
//判断空
+ (BOOL)checkEmptyString:(NSString *)string;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//将数组转换成json格式字符串,不含\n这些符号
+ (NSString *)gs_jsonStringCompactFormatForNSArray:(NSArray *)arrJson;
//将字典转换成json格式字符串,含\n这些符号,便于阅读
+ (NSString *)gs_jsonStringPrettyPrintedFormatForDictionary:(NSDictionary *)dicJson;

+(id)jsonToObject:(NSString *)json;

+ (NSString*)compareTwoTime:(NSDate *)date time2:(NSDate *)date2;

+ (NSString*)compareTwoTimeForSecond:(NSDate *)date time2:(NSDate *)date2;

//判断是否是 小手机
+ (BOOL)isPhoneSE;

//判断是否是Ipad
+ (BOOL)isIpadDevice;
//获取IMSI
+(NSString*)getImsi;
//获取IMSI card
+(NSString*)getImsiCard;

///获取文字的高度
+ (CGFloat)labelHeight:(NSString *)str font:(UIFont *)font labelWidth:(CGFloat)width;

///获取文字的宽度
+ (CGFloat)labelWidth:(NSString *)str font:(UIFont *)font labelHeight:(CGFloat)height;

+(void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

///字符串自动补充方法
+ (NSString*)CharacterStringMainString:(NSString*)MainString AddDigit:(int)AddDigit AddString:(NSString*)AddString;
//push的页面进行pop num是返回多少层
+ (void)PopToVCNum:(NSInteger)num;

+ (void)labelDyeingString:(NSString *)noticeStr rangeString:(NSString *)rangeString color:(UIColor *)color toLabel:(UILabel *)toLabel;
+ (void)labelDyeingString:(NSString *)noticeStr rangeStrings:(NSArray *)rangeStrings color:(NSArray *)color toLabel:(UILabel *)toLabel;

#pragma mark - 将某个时间Str转化成 时间戳
+ (NSInteger )timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

#pragma mark - 将某个时间戳转化成 时间Str
+ (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;


#pragma mark - 将某个时间Str转化成 时间秒
+ (NSInteger )timeSwitchTimestamp1:(NSString *)formatTime andFormatter:(NSString *)format;

#pragma mark - 将某个时间秒转化成 时间Str
+ (NSString *)timestampSwitchTime1:(NSInteger)timestamp andFormatter:(NSString *)format;


+ (BOOL) isFileExist:(NSString *)fileName;

//这个方法转换出来的图片  文字图片会变模糊
+ (UIImage *)convertViewToImage:(UIView *)view;


//获取时间戳
+(NSString *)getNowTimeTimestamp;

+ (UIImage *)scaleToSize:(UIImage *)aImage size:(CGSize)size;

+ (NSAttributedString *)attrHtmlStringFrom:(NSString *)str;


//添加点击手势
+ (void)addTapGestureWithSuperView:(UIView *)view target:(nullable id)target action:(nullable SEL)action;

+(NSString *)filterHTML:(NSString *)html;

+ (NSString *)flattenHTML:(NSString *)html;

/// 公参 必传 手机设置获取 只有两个值 android / iOS
+ (NSString *)device;
//获取时区
+ (NSString *)destinationTimeZone;

@end

NS_ASSUME_NONNULL_END
