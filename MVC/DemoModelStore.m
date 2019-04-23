//
//  DemoModelStore.m
//  MVC
//
//  Created by zhumengjiao on 2019/4/20.
//  Copyright © 2019 zmj. All rights reserved.
//

#import "DemoModelStore.h"
#import "DemoModel.h"

NSString * ChangeNotificationName = @"ChangeNotificationName";

@implementation DemoModelStore

+ (DemoModelStore *)shared {
    static DemoModelStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[DemoModelStore alloc] init];
    });
    return store;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _items = [@[] mutableCopy];
    }
    return self;
}

- (void)add:(DemoModel *)model {
    [_items addObject:model];
    [self postNotificationWithbehaviour:Add];
}

- (void)remove:(NSUInteger)index {
    [_items removeObjectAtIndex:index];
    [self postNotificationWithbehaviour:Remove];
}

- (void)reload {
    [self postNotificationWithbehaviour:Reload];
}

- (void)postNotificationWithbehaviour:(NSUInteger)behaviour {
    [[NSNotificationCenter defaultCenter] postNotificationName:ChangeNotificationName object:self userInfo:@{@"ChangeNotificationNameKey":@(behaviour)}];
}

@end
