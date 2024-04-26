//
//  NSURLSession+HPHttpProxy.h
//  EducationOL
//
//  Created by apple on 2021/9/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURLSession (HPHttpProxy)

+(void)disableHttpProxy;
+(void)enableHttpProxy;

@end

NS_ASSUME_NONNULL_END
