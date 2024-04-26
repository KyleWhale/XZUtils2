//
//  XZLocalstorage.h
//  XZYiBoEducation
//
//  Created by mac on 2019/11/7.
//  Copyright © 2019 ybed. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,MALocalStorageType){
    
    JSLocalStorageTypeUserDefault,
    JSLocalStorageTypeKeyChain,
};

NS_ASSUME_NONNULL_BEGIN

@interface XZLocalstorage : NSObject

/*!
 @brief 存
 @param data 要存储的数据
 @param key  存储的标识key
 @param type 存储的方式
 */
+ (void)save:(id)data forKey:(NSString *)key localStorageType:(MALocalStorageType)type;

/*!
 @brief 取
 @param  key  存储的标识key
 @param  type 存储的方式
 @return id   取存储的值
 */
+ (id)queryForKey:(NSString *)key localStorageType:(MALocalStorageType)type;

/*!
 @brief 删
 @param key  存储的标识key
 @param type 存储的方式
 */
+ (void)deleteForkey:(NSString *)key localStorageType:(MALocalStorageType)type;


@end

NS_ASSUME_NONNULL_END
