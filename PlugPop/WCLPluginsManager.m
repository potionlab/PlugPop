//
//  PluginManager.m
//  PluginTest
//
//  Created by Roben Kleene on 7/3/13.
//  Copyright (c) 2013 Roben Kleene. All rights reserved.
//

#import "WCLPluginsManager.h"
#import "Web_Console-Swift.h"

@implementation WCLPluginsManager

@synthesize defaultNewPlugin = _defaultNewPlugin;

- (instancetype)initWithPlugins:(NSArray *)plugins
{
    self = [super init];
    if (self) {
        _multiCollectionController = [[MultiCollectionController alloc] initWithObjects:plugins key:kPluginNameKey];
    }
    return self;
}

- (Plugin *)defaultNewPlugin
{
    if (_defaultNewPlugin) {
        return _defaultNewPlugin;
    }
    
    NSString *identifier = [[UserDefaultsManager standardUserDefaults] stringForKey:kDefaultNewPluginIdentifierKey];
    
    Plugin *plugin;
    
    if (identifier) {
        plugin = [self pluginWithIdentifier:identifier];
        if (!plugin) {
            [[UserDefaultsManager standardUserDefaults] removeObjectForKey:kDefaultNewPluginIdentifierKey];
        }
    }

    if (!plugin) {
        plugin = [self pluginForName:kInitialDefaultNewPluginName];
    }
    
    _defaultNewPlugin = plugin;
    
    return _defaultNewPlugin;
}

- (void)setDefaultNewPlugin:(Plugin *)defaultNewPlugin
{
    if (self.defaultNewPlugin == defaultNewPlugin) {
        return;
    }
    
    if (!defaultNewPlugin) {
        // Do this early so that the subsequent calls to the getter don't reset the default new plugin
        [[UserDefaultsManager standardUserDefaults] removeObjectForKey:kDefaultNewPluginIdentifierKey];
    }
    
    Plugin *oldDefaultNewPlugin = _defaultNewPlugin;
    _defaultNewPlugin = defaultNewPlugin;
    
    oldDefaultNewPlugin.defaultNewPlugin = NO;
    
    _defaultNewPlugin.defaultNewPlugin = YES;
    
    if (_defaultNewPlugin) {
        [[UserDefaultsManager standardUserDefaults] setObject:_defaultNewPlugin.identifier
                                                  forKey:kDefaultNewPluginIdentifierKey];
    }
}

- (Plugin *)pluginWithIdentifier:(NSString *)identifier
{
    NSAssert(NO, @"Implemented in superclass");
    return nil;
}

- (Plugin *)pluginForName:(NSString *)name
{
    NSAssert(NO, @"Implemented in superclass");
    return nil;
}


#pragma mark Required Key-Value Coding To-Many Relationship Compliance

- (NSArray *)plugins
{
    return [self.multiCollectionController objects];
}

- (void)insertObject:(Plugin *)plugin inPluginsAtIndex:(NSUInteger)index
{
    [self.multiCollectionController insertObject:plugin inObjectsAtIndex:index];
}

- (void)insertPlugins:(NSArray *)pluginsArray atIndexes:(NSIndexSet *)indexes
{
    [self.multiCollectionController insertObjects:pluginsArray atIndexes:indexes];
}

- (void)removeObjectFromPluginsAtIndex:(NSUInteger)index
{
    [self.multiCollectionController removeObjectFromObjectsAtIndex:index];
}

- (void)removePluginsAtIndexes:(NSIndexSet *)indexes
{
    [self.multiCollectionController removeObjectsAtIndexes:indexes];
}

@end
