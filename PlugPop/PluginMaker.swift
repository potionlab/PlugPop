//
//  PluginMaker.swift
//  PlugPop
//
//  Created by Roben Kleene on 5/7/17.
//  Copyright © 2017 Roben Kleene. All rights reserved.
//

import Foundation

class PluginMaker {

    let builtInPluginsPath: String?
    let applicationSupportPluginsPath: String?
    let defaultNewPluginManager: WCLDefaultNewPluginManager
    
    init(defaultNewPluginManager: WCLDefaultNewPluginManager,
         builtInPluginsPath: String?,
         applicationSupportPluginsPath: String?)
    {
        self.defaultNewPluginManager = defaultNewPluginManager
        self.builtInPluginsPath = builtInPluginsPath
        self.applicationSupportPluginsPath = applicationSupportPluginsPath
    }

    func makePlugin(path: String) -> Plugin? {
        let pluginType = self.pluginType(for: path)
        let plugin = Plugin.makePlugin(path: path, pluginType: pluginType)
        plugin.dataSource = defaultNewPluginManager
        return plugin
    }
    
    func makePlugin(url: URL) -> Plugin? {
        return makePlugin(path: url.path)
    }

    // MARK: Private

    private func pluginType(for path: String) -> PluginType {
        let pluginContainerDirectory = path.deletingLastPathComponent
        switch pluginContainerDirectory {
        case let path where path == applicationSupportPluginsPath:
            return PluginType.user
        case let path where path == builtInPluginsPath:
            return PluginType.builtIn
        default:
            return PluginType.other
        }
    }

}
