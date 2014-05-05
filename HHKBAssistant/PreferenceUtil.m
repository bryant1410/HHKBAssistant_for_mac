//
//  PreferenceUtil.m
//  HHKBAssistant
//
//  Created by 周 涵 on 2014/05/05.
//  Copyright (c) 2014年 hanks. All rights reserved.
//

#import "PreferenceUtil.h"

@implementation PreferenceUtil

@synthesize plistDic;
@synthesize plistPath;

- (NSMutableDictionary *)load {
    return [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
}

- (void)update {
    plistDic = [self load];
}

- (id)read:(NSString *)key {
    return [plistDic objectForKey:key];
}

- (void)write {
    [plistDic writeToFile:plistPath atomically:YES];
}

#pragma mark delegate Methods
- (void) addDevice:(NSString *)deviceName {
    NSMutableArray *arr = [self getDeviceArr];
    [arr addObject:deviceName];
    [plistDic setObject:arr forKey:DEVICES_KEY];
    [self write];
}

- (void) removeDevice:(NSString *)deviceName {
    NSMutableArray *arr = [self getDeviceArr];
    [arr removeObject:deviceName];
    [plistDic setObject:arr forKey:DEVICES_KEY];
    [self write];
}

- (NSMutableArray*) getDeviceArr {
    [self update];
    return [NSMutableArray arrayWithArray:[self read:DEVICES_KEY]];
}

- (BOOL) isAutoDisable {
    [self update];
    return [[self read:IS_AUTO_DISABLE_KEY] boolValue];
}
- (void) setAutoDisable:(BOOL)flag {
    [self update];
    [plistDic setObject:[NSNumber numberWithBool:flag] forKey:IS_AUTO_DISABLE_KEY];
    [self write];
}

- (BOOL) isEnableVoice {
    [self update];
    return [[self read:IS_VOICE_MESSAGE_ALL_KEY] boolValue];
}
- (void) setEnableVoice:(BOOL)flag {
    [self update];
    [plistDic setObject:[NSNumber numberWithBool:flag] forKey:IS_VOICE_MESSAGE_ALL_KEY];
    [self write];
}

- (BOOL) isInMsgEnable {
    [self update];
    return [[self read:IS_VOICE_MESSAGE_IN_KEY] boolValue];
}
- (void) setInMsgEnable:(BOOL)flag {
    [self update];
    [plistDic setObject:[NSNumber numberWithBool:flag] forKey:IS_VOICE_MESSAGE_IN_KEY];
    [self write];
}

- (BOOL) isOutMsgEnable {
    [self update];
    return [[self read:IS_VOICE_MESSAGE_OUT_KEY] boolValue];
}
- (void) setOutMsgEnable:(BOOL)flag {
    [self update];
    [plistDic setObject:[NSNumber numberWithBool:flag] forKey:IS_VOICE_MESSAGE_OUT_KEY];
    [self write];
}

- (NSString *) getInMsg {
    [self update];
    return [[self read:IN_MESSAGE_KEY] stringValue];
}
- (void) setInMsg:(NSString *)msg {
    [self update];
    [plistDic setObject:msg forKey:IN_MESSAGE_KEY];
    [self write];
}

- (NSString *) getOutMsg {
    [self update];
    return [[self read:OUT_MESSAGE_KEY] stringValue];
}
- (void) setOutMsg:(NSString *)msg {
    [self update];
    [plistDic setObject:msg forKey:OUT_MESSAGE_KEY];
    [self write];
}


#pragma mark Singleton Methods
+ (id)getSharedInstance {
    static PreferenceUtil *sharedUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUtil = [[self alloc] init];
    });
    return sharedUtil;
}

- (id)init {
    if (self = [super init]) {
        // init path
        plistPath = [[NSBundle mainBundle] pathForResource:PREFERENCE_NAME ofType:@"plist"];
        
        // init
        [self update];
    }
    return self;
}

@end
