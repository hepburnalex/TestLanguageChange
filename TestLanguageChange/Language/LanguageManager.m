//
//  LanguageManager.m
//  eIDLedger
//
//  Created by Hepburn on 2018/8/17.
//  Copyright © 2018年 Hepburn. All rights reserved.
//

#import "LanguageManager.h"

#define CNS @"zh-Hans"
#define EN @"en"
#define LANGUAGE_SET @"langeuageset"

static LanguageManager *sharedModel;

@interface LanguageManager()

@property(nonatomic, strong) NSBundle *bundle;
@property(nonatomic, copy) NSString *language;

@end

@implementation LanguageManager

+ (LanguageManager *)sharedInstance {
    if (!sharedModel) {
        sharedModel = [[LanguageManager alloc] init];
    }
    return sharedModel;
}

- (BOOL)isCNS {
    return [self.language isEqualToString:CNS];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initLanguage];
    }
    return self;
}

- (NSString *)systemLanguage {
    NSArray* languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    NSLog(@"%@", preferredLang);
    return preferredLang;
}

- (BOOL)isSimpleChinese {
    NSString *language = [self systemLanguage];
    NSRange range = [language rangeOfString:@"zh-"];
    return (range.length > 0);
}

- (void)initLanguage {
    NSString *tmp = [[NSUserDefaults standardUserDefaults] objectForKey:LANGUAGE_SET];
    NSString *path;
    //默认是中文
    if (!tmp) {
        tmp = [self isSimpleChinese]?CNS:EN;
    }
    
    self.language = tmp;
    path = [[NSBundle mainBundle] pathForResource:self.language ofType:@"lproj"];
    self.bundle = [NSBundle bundleWithPath:path];
}

- (NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table {
    if (self.bundle) {
        return NSLocalizedStringFromTableInBundle(key, table, self.bundle, @"");
    }
    return NSLocalizedStringFromTable(key, table, @"");
}

- (void)changeNowLanguage {
    if ([self.language isEqualToString:EN]) {
        [self setNewLanguage:CNS];
    }
    else {
        [self setNewLanguage:EN];
    }
}

- (void)setNewLanguage:(NSString *)language {
    if ([language isEqualToString:self.language]) {
        return;
    }
    if ([language isEqualToString:EN] || [language isEqualToString:CNS]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
        self.bundle = [NSBundle bundleWithPath:path];
    }
    self.language = language;
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:LANGUAGE_SET];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
