//
//  PluginManagerTestCase_new.swift
//  PluginEditorPrototype
//
//  Created by Roben Kleene on 1/18/15.
//  Copyright (c) 2015 Roben Kleene. All rights reserved.
//

import Cocoa
import XCTest

@testable import PlugPop
import PotionTaster
import XCTestTemp

class PluginsManagerTestCase: TemporaryDirectoryTestCase, PluginsManagerFactoryType {
    var pluginsManager: PluginsManager!
    lazy var defaults: DefaultsType = {
        UserDefaults(suiteName: testMockUserDefaultsSuiteName)!
    }()

    override func setUp() {
        super.setUp()
        pluginsManager = makePluginsManager()
    }

    override func tearDown() {
        pluginsManager = nil
        super.tearDown()
    }

    func newPluginWithConfirmation() -> Plugin {
        var createdPlugin: Plugin!
        let createdPluginExpectation = expectation(description: "Create new plugin")
        pluginsManager.newPlugin { (newPlugin, error) -> Void in
            XCTAssertNil(error, "The error should be nil")
            createdPlugin = newPlugin
            createdPluginExpectation.fulfill()
        }
        waitForExpectations(timeout: defaultTimeout, handler: nil)
        return createdPlugin
    }
 
    func duplicateWithConfirmation(_ plugin: Plugin) -> Plugin {
        var createdPlugin: Plugin!
        let createdPluginExpectation = expectation(description: "Create new plugin")
        pluginsManager.duplicate(plugin) { (newPlugin, error) -> Void in
            XCTAssertNil(error, "The error should be nil")
            createdPlugin = newPlugin
            createdPluginExpectation.fulfill()
        }
        waitForExpectations(timeout: defaultTimeout, handler: nil)
        return createdPlugin
    }
    
    func moveToTrashAndCleanUpWithConfirmation(_ plugin: Plugin) {
        // Confirm that a matching directory does not exist in the trash
        let trashedPluginDirectoryName = plugin.bundle.bundlePath.lastPathComponent
        let trashedPluginPath = testTrashDirectoryPath.appendingPathComponent(trashedPluginDirectoryName)
        let beforeExists = FileManager.default.fileExists(atPath: trashedPluginPath)
        XCTAssertTrue(!beforeExists, "The item should exist")
        
        // Trash the plugin
        pluginsManager.moveToTrash(plugin)
        
        // Confirm that the directory does exist in the trash now
        var isDir: ObjCBool = false
        let afterExists = FileManager.default.fileExists(atPath: trashedPluginPath, isDirectory: &isDir)
        XCTAssertTrue(afterExists, "The item should exist")
        XCTAssertTrue(isDir.boolValue, "The item should be a directory")
        
        // Clean up trash
        do {
            try FileManager.default.removeItem(atPath: trashedPluginPath)
        } catch {
            XCTAssertTrue(false, "The remove should succeed")
        }
    }
}
