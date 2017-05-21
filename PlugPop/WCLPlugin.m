//
//  Plugin.m
//  PluginTest
//
//  Created by Roben Kleene on 7/3/13.
//  Copyright (c) 2013 Roben Kleene. All rights reserved.
//

#import "WCLPlugin.h"
#import <PlugPop/PlugPop-Swift.h>

@implementation WCLPlugin

@synthesize defaultNewPlugin = _defaultNewPlugin;

- (void)setDefaultNewPlugin:(BOOL)defaultNewPlugin
{
    // TODO: It's problematic that using this setter without going through the
    // plugin manager, will set the flag to true without it actually being the
    // default new plugin
    
    if (_defaultNewPlugin != defaultNewPlugin) {
        _defaultNewPlugin = defaultNewPlugin;
    }
}

- (BOOL)isDefaultNewPlugin
{
    if (!self.dataSource) {
        return NO;
    }

    BOOL isDefaultNewPlugin = (self.dataSource.defaultNewPlugin == self);
    
    if (_defaultNewPlugin != isDefaultNewPlugin) {
        _defaultNewPlugin = isDefaultNewPlugin;
    }
    
    return _defaultNewPlugin;
}

@end
