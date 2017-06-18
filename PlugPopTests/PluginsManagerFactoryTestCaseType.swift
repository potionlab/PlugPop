//
//  PluginsManagerFactory.swift
//  PlugPop
//
//  Created by Roben Kleene on 6/18/17.
//  Copyright (c) 2017 Roben Kleene. All rights reserved.
//

@testable import PlugPop
import PotionTaster
import XCTestTemp

extension TemporaryDirectoryTestCase: TemporaryDirectoryType { }
extension UserDefaults: DefaultsType { }

protocol TemporaryDirectoryType {
    var temporaryDirectoryURL: URL { get }
    var temporaryDirectoryPath: String { get }
}

protocol TempUserPluginsDirectoryType: TempoararyDirectoryType {
    var temporaryApplicationSupportDirectoryURL: URL { get }
    var temporaryApplicationSupportDirectoryPath: String { get }
    var temporaryUserPluginsDirectoryURL: URL { get }
    var temporaryUserPluginsDirectoryPath: String { get }
}

extension TempUserPluginsDirectoryType {
    var temporaryApplicationSupportDirectoryURL: URL {
        return temporaryDirectoryURL
            .appendingPathComponent(testApplicationSupportDirectoryName)
    }

    var temporaryApplicationSupportDirectoryPath: String {
        return temporaryApplicationSupportDirectoryURL.path
    }

    var temporaryUserPluginsDirectoryURL: URL {
        return applicationSupportDirectoryURL
            .appendingPathComponent(testAppName)
            .appendingPathComponent(testPluginsDirectoryPathComponent)
    }
    
    var temporaryUserPluginsDirectoryPath: String {
        return temporaryUserPluginsDirectoryURL.path
    }
}

protocol TempCopyTempURLType: TempoararyDirectoryType {
    var tempCopyTempDirectoryURL: URL { get }
}

extension TempCopyTempURLType {
    var tempCopyTempDirectoryURL: URL {
        return temporaryDirectoryURL
            .appendingPathComponent(testCopyTempDirectoryName)
    }
}

protocol PluginsManagerDependenciesType: TempCopyTempURLType, TempUserPluginsDirectoryType {
    var pluginsDirectoryPaths: [String] { get }
    var copyTempDirectoryURL: URL { get }
    var defaults: DefaultsType { get }
    var userPluginsPath: String { get }
    var builtInPluginsPath: String { get }
}

extension PluginsManagerDependenciesType {
    var pluginsDirectoryPaths: [String] {
        return [builtInPluginsPath, 
                PotionTaster.sharedTestResourcesPluginsDirectoryPath, 
                userPluginsPath]
    }
    var builtInPluginsPath: String {
        return PotionTaster.rootPluginsDirectoryPath
    }
    var userPluginsPath: String {
        return temporaryUserPluginsDirectoryPath
    }
    var copyTempDirectoryURL: URL {
        return tempCopyTempDirectoryURL
    }
}

protocol PluginsManagerFactoryType: PluginsManagerDependenciesType {
    var pluginsManagerType: PluginsManager.Type { get set }
    func makePluginsManager() -> PluginsManager
}

extension PluginsManagerFactoryType {
    var pluginsManagerType = PluginsManager.self

    func makePluginsManager() -> PluginsManager {
        return pluginsManagerType(pluginsPaths: pluginsDirectoryPaths,
                                  copyTempDirectoryURL: copyTempDirectoryURL,
                                  defaults: defaults,
                                  userPluginsPath: userPluginsPath,
                                  builtInPluginsPath: builtInPluginsPath)
    }
}
