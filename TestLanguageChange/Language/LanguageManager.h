//
//  LanguageManager.h
//  eIDLedger
//
//  Created by Hepburn on 2018/8/17.
//  Copyright © 2018年 Hepburn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageManager : NSObject

@property(nonatomic, readonly) BOOL isCNS;

+ (LanguageManager *)sharedInstance;

//返回table中指定的key的值
- (NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table;

//改变当前语言
- (void)changeNowLanguage;

//设置新的语言
- (void)setNewLanguage:(NSString*)language;

#define LL(x)     [[LanguageManager sharedInstance] getStringForKey:x withTable:@"Localizable"]

@end
