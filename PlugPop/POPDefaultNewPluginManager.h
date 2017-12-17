//
//  POPDefaultNewPluginManager.h
//  PlugPop
//
//  Created by Roben Kleene on 5/14/17.
//  Copyright (c) 2017 Roben Kleene. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "POPPlugin.h"

#define kDefaultNewPluginIdentifierKey @"POPDefaultNewPluginIdentifier"

@class POPDefaultNewPluginManager;
@class Plugin;

NS_ASSUME_NONNULL_BEGIN
@protocol POPDefaultNewPluginManagerDataSource
- (nullable Plugin *)defaultNewPluginManager:(POPDefaultNewPluginManager *)defaultNewPluginManager pluginWithIdentifier:(NSString *)identifier;
- (nullable Plugin *)defaultNewPluginManager:(POPDefaultNewPluginManager *)defaultNewPluginManager pluginWithName:(NSString *)name;
@end
NS_ASSUME_NONNULL_END

@protocol DefaultsType;
@protocol DefaultPluginDataSource;

NS_ASSUME_NONNULL_BEGIN
@interface POPDefaultNewPluginManager : NSObject <DefaultPluginDataSource>
- (instancetype)initWithDefaults:(_Nonnull id <DefaultsType>)defaults;
@property (nonatomic, assign, nullable) id <POPDefaultNewPluginManagerDataSource> dataSource;
@property (nonatomic, strong, nullable) POPPlugin *defaultNewPlugin;
@end
NS_ASSUME_NONNULL_END
