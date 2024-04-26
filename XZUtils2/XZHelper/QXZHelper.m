//
//  QXZHelper.m
//  youyisi
//
//  Created by apple on 2021/11/3.
//  Copyright © 2021 李维佳. All rights reserved.
//

#import "QXZHelper.h"
#import <sys/utsname.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@implementation QXZHelper

+ (UIViewController *)getCurrentVC {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    //获取根控制器
    UIViewController* currentViewController = window.rootViewController;
    
    //获取当前页面控制器
    
    BOOL runLoopFind = YES;
    
    while (runLoopFind){
        if (currentViewController.presentedViewController) {
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]){
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                currentViewController = currentViewController.childViewControllers.lastObject;
                return currentViewController;
            } else {
                return currentViewController;
            }
        }
        
    }
    return currentViewController;
}

+ (NSString *)translation:(NSString *)arebic

{   NSString *str = arebic;
    NSArray *arabic_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chinese_numerals forKeys:arabic_numerals];
    
    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < str.length; i ++) {
        NSString *substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *a = [dictionary objectForKey:substr];
        NSString *b = digits[str.length -i-1];
        NSString *sum = [a stringByAppendingString:b];
        if ([a isEqualToString:chinese_numerals[9]])
        {
            if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
            {
                sum = b;
                if ([[sums lastObject] isEqualToString:chinese_numerals[9]])
                {
                    [sums removeLastObject];
                }
            }else
            {
                sum = chinese_numerals[9];
            }
            
            if ([[sums lastObject] isEqualToString:sum])
            {
                continue;
            }
        }
        
        [sums addObject:sum];
    }
    
    NSString *sumStr = [sums  componentsJoinedByString:@""];
    NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
//    NSLog(@"str %@",str);
    NSLog(@"%s  %@", __func__, chinese);
    return chinese;
}


+(NSString*)formatDate:(NSDate*)d format:(NSString*)str{
    NSDateFormatter* f=[[NSDateFormatter alloc]init];
    f.dateFormat = str;
    NSString* s = [f stringFromDate:d];
//    [f release];
    return  s;
}

+ (void)setupView:(UIView *)view colors:(NSArray *)colors type:(VIEWCOLORSTYLETYPE)type frame:(CGRect)frame{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = frame;  // 设置显示的frame
    gradientLayer.colors = colors;  // 设置渐变颜色
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.5);
    if (type == VIEWCOLORVERTICALTYPE) {
        gradientLayer.startPoint = CGPointMake(0.5, 0);
        gradientLayer.endPoint = CGPointMake(0.5, 1);
    } else if (type == VIEWCOLORTRANSVERSETYPE){
        gradientLayer.startPoint = CGPointMake(0, 0.5);
        gradientLayer.endPoint = CGPointMake(1, 0.5);
    }
    [view.layer insertSublayer:gradientLayer atIndex:0];
}

/**
 判断是否是有效的身份证号码

 @param idCardNo 身份证号字符串
 @return 如果是有效的身份证号，返回`YES`, 否则返回`NO`

 仅允许  数字 && 最后一位是{数字 || Xx}）
 */
+ (BOOL)isVaildIDCardNo:(NSString *)idCardNo
{
    if ([QXZHelper checkEmptyString:idCardNo]) return NO;
    NSString *regxStr = @"^[1-9][0-9]{5}[1-9][0-9]{3}((0[0-9])|(1[0-2]))(([0|1|2][0-9])|3[0-1])[0-9]{3}([0-9]|X|x)$";
    NSPredicate *idcardTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regxStr];
    return [idcardTest evaluateWithObject:idCardNo];
}

+ (BOOL)checkEmptyString:(NSString *)string {

    if (string == nil) return string == nil;

    NSString *newStr = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [newStr isEqualToString:@""];
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
//        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//将数组转换成json格式字符串,不含\n这些符号
+ (NSString *)gs_jsonStringCompactFormatForNSArray:(NSArray *)arrJson {
    if (![arrJson isKindOfClass:[NSArray class]] || ![NSJSONSerialization isValidJSONObject:arrJson]) {
        return nil;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arrJson options:0 error:nil];
    NSString *strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return strJson;
}

//将字典转换成json格式字符串,含\n这些符号,便于阅读
+ (NSString *)gs_jsonStringPrettyPrintedFormatForDictionary:(NSDictionary *)dicJson {
    if (![dicJson isKindOfClass:[NSDictionary class]] || ![NSJSONSerialization isValidJSONObject:dicJson]) {
        return nil;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicJson options:NSJSONWritingPrettyPrinted error:nil];
    NSString *strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return strJson;
}

+(id)jsonToObject:(NSString *)json{
    //string转data
    NSData * jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    //json解析
    id obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return obj;
}

+ (NSString*)compareTwoTime:(NSDate *)date time2:(NSDate *)date2
{
//    NSTimeInterval balance = time2 /1000- time1 /1000;
    NSTimeInterval time1 = [date timeIntervalSince1970] * 1;
    NSTimeInterval time2 = [date2 timeIntervalSince1970] * 1;
    NSTimeInterval balance = time2 - time1;
    NSString*timeString = [[NSString alloc]init];
    timeString = [NSString stringWithFormat:@"%f",balance /60];
    timeString = [timeString substringToIndex:timeString.length-7];
    NSInteger timeInt = [timeString intValue];
    NSInteger hour = timeInt /60;
    NSInteger mint = timeInt %60;
    if(hour == 0) {
        timeString = [NSString stringWithFormat:@"%ld分钟",(long)mint];
    }
    else
    {
        if(mint == 0) {
            timeString = [NSString stringWithFormat:@"%ld小时",(long)hour];
        }
        else
        {
            timeString = [NSString stringWithFormat:@"%ld小时%ld分钟",(long)hour,(long)mint];
        }
    }
    NSLog(@"登录时间间隔 = %@",timeString);
    timeString = [NSString stringWithFormat:@"%ld",(long)hour];
//    timeString = [NSString stringWithFormat:@"%ld",(long)mint];
    return timeString;
}

+ (NSString *)compareTwoTimeForSecond:(NSDate *)date time2:(NSDate *)date2 {
    NSTimeInterval time1 = [date timeIntervalSince1970] * 1;
    NSTimeInterval time2 = [date2 timeIntervalSince1970] * 1;
    NSTimeInterval balance = time2 - time1;
    NSString*timeString = [[NSString alloc]init];
//    timeString = [NSString stringWithFormat:@"%f",balance /60];
    timeString = [NSString stringWithFormat:@"%f",balance];
    timeString = [timeString substringToIndex:timeString.length-7];
    NSInteger timeInt = [timeString intValue];
    timeString = [NSString stringWithFormat:@"%ld",(long)timeInt];
    
    NSLog(@"时间间隔 = %@",timeString);
    return timeString;
}

+ (BOOL)isPhoneSE {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString*phoneType = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    if([phoneType  isEqualToString:@"iPhone3,1"])  return YES;//iPhone 4
    
    if([phoneType  isEqualToString:@"iPhone3,2"])  return YES;//iPhone 4
    
    if([phoneType  isEqualToString:@"iPhone3,3"])  return YES;//iPhone 4
    
    if([phoneType  isEqualToString:@"iPhone4,1"])  return YES;//iPhone 4s
    
    if([phoneType  isEqualToString:@"iPhone5,1"])  return YES;//iPhone 5

    if([phoneType  isEqualToString:@"iPhone5,2"])  return YES;//iPhone 5

    if([phoneType  isEqualToString:@"iPhone5,3"])  return YES;//iPhone 5c

    if([phoneType  isEqualToString:@"iPhone5,4"])  return YES;//iPhone 5c

    if([phoneType  isEqualToString:@"iPhone6,1"])  return YES;//iPhone 5s

    if([phoneType  isEqualToString:@"iPhone6,2"])  return YES;//iPhone 5s
    
    if([phoneType  isEqualToString:@"iPhone8,4"])  return YES;//iPhone SE
    
    return NO;
}

//判断是否是Ipad
+ (BOOL)isIpadDevice{
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType isEqualToString:@"iPhone"]) {
        //iPhon
        return NO;
    } else if([deviceType isEqualToString:@"iPod touch"]) {
        //iPod Touch
        return NO;
    }else if([deviceType isEqualToString:@"iPad"]) {
        
        //iPad
        return YES;
    }
    return NO;
}

+(NSString*)getImsi{
    NSString *ret = [[NSString alloc]init];
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    if (carrier == nil) {
        return @"0";
    }
    NSString *code = [carrier mobileNetworkCode];
    if ([code isEqual:@""]) {
        return @"0";
    }
    if ([code isEqualToString:@"00"] || [code isEqualToString:@"02"] || [code isEqualToString:@"07"]) {
        ret = @"中国移动";
    }
    if ([code isEqualToString:@"01"]|| [code isEqualToString:@"06"] ) {
        ret = @"中国联通";
    }
    if ([code isEqualToString:@"03"]|| [code isEqualToString:@"05"] ) {
        ret = @"中国电信";;
    }
    return ret;
}

/// 公参 必传 手机设置获取 只有两个值 android / iOS
+ (NSString *)device {
    return [[UIDevice currentDevice] systemName];
}

+(NSString*)getImsiCard{
    NSString *ret = [[NSString alloc]init];
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    if (carrier == nil) {
        return @"0";
    }
    NSString *code = [carrier mobileNetworkCode];
    if ([code isEqual:@""]) {
        return @"0";
    }
    return code;
}

+ (CGFloat)labelHeight:(NSString *)str font:(UIFont *)font labelWidth:(CGFloat)width {
    
    CGSize size = [str sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return size.height;
    
}

+ (CGFloat)labelWidth:(NSString *)str font:(UIFont *)font labelHeight:(CGFloat)height {
    CGSize size = [str sizeWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX, height) lineBreakMode:NSLineBreakByWordWrapping];
    return size.width;
}
/**
*画虚线
@param lineView 视图
@param lineLength 单个虚线大小
@param lineSpacing 间隔
@param lineColor 虚线颜色
*/

+(void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth(lineView.frame), CGRectGetHeight(lineView.frame));
    CGSize radii = CGSizeMake(5, 5);//圆角
    UIRectCorner corners = UIRectCornerAllCorners;
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = lineColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 0.5;//line的高度
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    shapeLayer.lineDashPattern = @[[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing]];//画虚线(虚线宽、虚线间隔)
    //add it to our view
    [lineView.layer addSublayer:shapeLayer];
}

#pragma mark字符串自动补充方法
+ (NSString*)CharacterStringMainString:(NSString*)MainString AddDigit:(int)AddDigit AddString:(NSString*)AddString 
{
    NSString*ret = [[NSString alloc]init];
    ret = MainString;
    for(int y =0;y < (AddDigit - MainString.length) ;y++ ){
        ret = [NSString stringWithFormat:@"%@%@",AddString,ret];
    }
    return ret;
}


+ (void)PopToVCNum:(NSInteger)num {
    UIViewController * vc = [self getCurrentVC];
    NSArray *pushVCAry=[vc.navigationController viewControllers];
    if (num > pushVCAry.count-1) {
        num = pushVCAry.count-1;
    }
    UIViewController *popVC=[pushVCAry objectAtIndex:pushVCAry.count-(num + 1)];
    [vc.navigationController popToViewController:popVC animated:YES];
}

+ (void)labelDyeingString:(NSString *)noticeStr rangeString:(NSString *)rangeString color:(UIColor *)color toLabel:(UILabel *)toLabel {
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:noticeStr];

    [attributeString addAttribute:NSForegroundColorAttributeName value:color range:[noticeStr rangeOfString:rangeString]];

    toLabel.attributedText=attributeString;
}

+ (void)labelDyeingString:(NSString *)noticeStr rangeStrings:(NSArray *)rangeStrings color:(NSArray *)color toLabel:(UILabel *)toLabel {
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:noticeStr];
    for (NSInteger i = 0; i < rangeStrings.count; i++) {
        NSString * rangeString = rangeStrings[i];
        [attributeString addAttribute:NSForegroundColorAttributeName value:color[i] range:[noticeStr rangeOfString:rangeString]];
    }
    toLabel.attributedText=attributeString;
}



#pragma mark - 将某个时间Str转化成 时间戳
+ (NSInteger )timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];  //（@"YYYY-MM-dd hh:mm:ss"）----------注意>hh为12小时制,HH为24小时制
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:formatTime];
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return timeSp;
}

#pragma mark - 将某个时间戳转化成 时间Str
+ (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    if ([format isEqual:@"HH:mm:ss"] && confromTimespStr.length<8) {
        confromTimespStr = @"00:00:00";
    }
    if ([format isEqual:@"YYYY-MM-dd HH:mm:ss"] && confromTimespStr.length<18) {
        confromTimespStr = @"2000-01-01 00:00:00"; //默认返回
    }
    return confromTimespStr;
}


#pragma mark - 将某个时间Str转化成 时间秒
+ (NSInteger )timeSwitchTimestamp1:(NSString *)formatTime andFormatter:(NSString *)format{
    NSInteger time = 0;
    if ([format isEqualToString:@"HH:mm:ss"]) {
        NSArray * timeArr = [formatTime componentsSeparatedByString:@":"];
        if (timeArr.count > 2) {
            NSString *hour = timeArr[0];
            NSString *min = timeArr[1];
            NSString *seconds = timeArr[2];
            time = [hour integerValue] * 3600 +  [min integerValue] * 60 + [seconds integerValue];
        } else {
//            NSString *hour = timeArr[0];
//            NSString *min = timeArr[1];
//            time = [hour integerValue] * 3600 +  [min integerValue] * 60;
        }
    } else if ([format isEqualToString:@"HH:mm"]){
        NSArray * timeArr = [formatTime componentsSeparatedByString:@":"];
        if (timeArr.count > 1) {
            NSString *hour = timeArr[0];
            NSString *min = timeArr[1];
            time = [hour integerValue] * 3600 +  [min integerValue] * 60;
        }
    } else if ([format isEqualToString:@"mm:ss"]){
        NSArray * timeArr = [formatTime componentsSeparatedByString:@":"];
        if (timeArr.count > 1) {
            NSString *min = timeArr[0];
            NSString *seconds = timeArr[1];
            time = [min integerValue] * 60 +  [seconds integerValue];
        }
    }
    return time;
}

#pragma mark - 将某个时间秒转化成 时间Str
+ (NSString *)timestampSwitchTime1:(NSInteger)timestamp andFormatter:(NSString *)format{
    NSString *timeStr = @"";
    if ([format isEqualToString:@"HH:mm:ss"]) {
        NSInteger hour = timestamp / 3600;
        NSInteger min = (timestamp % 3600) / 60;
        NSInteger seconds = (timestamp % 3600) % 60;
        if (hour > 99) {
            timeStr = [NSString stringWithFormat:@"%@:%@:%@",
                       [NSString stringWithFormat:@"%ld",hour],
                       [QXZHelper CharacterStringMainString:[NSString stringWithFormat:@"%ld",min] AddDigit:2 AddString:@"0"],
                       [QXZHelper CharacterStringMainString:[NSString stringWithFormat:@"%ld",seconds] AddDigit:2 AddString:@"0"]];
        } else {
            timeStr = [NSString stringWithFormat:@"%@:%@:%@",
                       [QXZHelper CharacterStringMainString:[NSString stringWithFormat:@"%ld",hour] AddDigit:2 AddString:@"0"],
                       [QXZHelper CharacterStringMainString:[NSString stringWithFormat:@"%ld",min] AddDigit:2 AddString:@"0"],
                       [QXZHelper CharacterStringMainString:[NSString stringWithFormat:@"%ld",seconds] AddDigit:2 AddString:@"0"]];
        }
        
    } else if ([format isEqualToString:@"HH:mm"]) {
        NSInteger hour = timestamp / 3600;
        NSInteger min = (timestamp % 3600) / 60;
        if (hour > 99) {
            timeStr = [NSString stringWithFormat:@"%@:%@",
                       [NSString stringWithFormat:@"%ld",hour],
                       [QXZHelper CharacterStringMainString:[NSString stringWithFormat:@"%ld",min] AddDigit:2 AddString:@"0"]];
        } else {
            timeStr = [NSString stringWithFormat:@"%@:%@",
                       [QXZHelper CharacterStringMainString:[NSString stringWithFormat:@"%ld",hour] AddDigit:2 AddString:@"0"],
                       [QXZHelper CharacterStringMainString:[NSString stringWithFormat:@"%ld",min] AddDigit:2 AddString:@"0"]];
        }
       
    } else if ([format isEqualToString:@"mm:ss"]){
        NSInteger min = (timestamp % 3600) / 60;
        NSInteger seconds = (timestamp % 3600) % 60;
        if (min > 99) {
            timeStr = [NSString stringWithFormat:@"%@:%@",
                       [NSString stringWithFormat:@"%ld",min],
                       [QXZHelper CharacterStringMainString:[NSString stringWithFormat:@"%ld",seconds] AddDigit:2 AddString:@"0"]];
        } else {
            timeStr = [NSString stringWithFormat:@"%@:%@",
                       [QXZHelper CharacterStringMainString:[NSString stringWithFormat:@"%ld",min] AddDigit:2 AddString:@"0"],
                       [QXZHelper CharacterStringMainString:[NSString stringWithFormat:@"%ld",seconds] AddDigit:2 AddString:@"0"]];
        }
    }
    return timeStr;
}

+ (BOOL) isFileExist:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    NSLog(@"这个文件已经存在：%@",result?@"是的":@"不存在");
    return result;
}

//这个方法转换出来的图片  文字图片会变模糊
//- (UIImage *)convertViewToImage:(UIView *)view {
//
//   UIGraphicsBeginImageContext(view.bounds.size);
//   [view.layer renderInContext:UIGraphicsGetCurrentContext()];
//   UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//   UIGraphicsEndImageContext();
//   return image;
//
//}

//使用该方法不会模糊，根据屏幕密度计算
+ (UIImage *)convertViewToImage:(UIView *)view {
    
    UIImage *imageRet = [[UIImage alloc]init];
    //UIGraphicsBeginImageContextWithOptions(区域大小, 是否是非透明的, 屏幕密度);
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageRet;
    
}


+(NSString *)getNowTimeTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型;
    return timeString;
}


+ (UIImage *)scaleToSize:(UIImage *)aImage size:(CGSize)size{
    
    //创建context,并将其设置为正在使用的context
    UIGraphicsBeginImageContext(size);
    //绘制出图片(大小已经改变)
    [aImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    //获取改变大小之后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //context出栈
    UIGraphicsEndImageContext();
    return newImage; //返回获得的图片
}

/** 解析成html的富文本 */
+ (NSAttributedString *)attrHtmlStringFrom:(NSString *)str {
    str = [NSString stringWithFormat:@"<html><meta content=\"width=device-width, initial-scale=1.0, maximum-scale=3.0, user-scalable=0; \" name=\"viewport\" /><body style=\"overflow-wrap:break-word;word-break:break-all;white-space: normal; font-size:12px; color:#A4A4A4; \">%@</body></html>",str];
    NSAttributedString *attrStr=  [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:@(NSUTF8StringEncoding)} documentAttributes:nil error:nil];
    return attrStr;
}

+ (void)addTapGestureWithSuperView:(UIView *)view target:(nullable id)target action:(nullable SEL)action{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [view addGestureRecognizer:singleTap];
}

+(NSString *)filterHTML:(NSString *)html

{

    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:&text];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }

    // NSString * regEx = @"]*)>";

    // html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];

    return html;

}


+ (NSString *)flattenHTML:(NSString *)html {
    // 过滤html标签
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:&text];
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    // 过滤html中的\n\r\t换行空格等特殊符号
    NSMutableString *str1 = [NSMutableString stringWithString:html];
    for (int i = 0; i < str1.length; i++) {
        unichar c = [str1 characterAtIndex:i];
        NSRange range = NSMakeRange(i, 1);
        // 在这里添加要过滤的特殊符号
        if ( c == '\r' || c == '\n' || c == '\t' ) {
            [str1 deleteCharactersInRange:range];
            --i;
        }
    }
    html = [NSString stringWithString:str1];
    NSString *temptext =[html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *text2 = [temptext stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *text3 = [text2 stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    NSString *text4 = [text3 stringByReplacingOccurrencesOfString:@" " withString:@""];
    return text4;
//    return html;
}

//获取时区
+ (NSString *)destinationTimeZone {
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];//获取当前时区信息
    NSInteger sourceGMTOffset = [destinationTimeZone secondsFromGMTForDate:[NSDate date]];//获取偏移秒数
    NSString * sourceGMT = [NSString stringWithFormat:@"%ld",sourceGMTOffset/3600];
    return  sourceGMT;
}

@end
