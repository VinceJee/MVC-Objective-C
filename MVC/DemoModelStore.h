//
//  DemoModelStore.h
//  MVC
//
//  Created by zhumengjiao on 2019/4/20.
//  Copyright © 2019 zmj. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const NSString * _Nonnull ChangeNotificationName;

typedef NS_ENUM(NSUInteger, ChangeBehavior) {
    Add = 0,
    Remove,
    Reload
};

@class DemoModel;
NS_ASSUME_NONNULL_BEGIN

@interface DemoModelStore : NSObject

@property (nonatomic, strong) NSMutableArray <DemoModel *>*items;

+ (DemoModelStore *)shared;

- (void)add:(DemoModel *)model; // 增加
- (void)remove:(NSUInteger)index; // 删除
- (void)reload; // 刷新

@end

NS_ASSUME_NONNULL_END
