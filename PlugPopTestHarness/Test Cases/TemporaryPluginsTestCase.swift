//
//  TemporaryPluginsTestCase.swift
//  PluginEditorPrototype
//
//  Created by Roben Kleene on 11/8/14.
//  Copyright (c) 2014 Roben Kleene. All rights reserved.
//

import Foundation
import XCTest

@testable import PlugPop
import XCTestTemp
import PotionTaster

public class TemporaryPluginsTestCase: TemporaryDirectoryTestCase {
    var tempPluginsDirectoryURL: URL!
    var tempPluginsDirectoryPath: String! {
        get {
            return tempPluginsDirectoryURL.path
        }
    }
    var tempPluginURL: URL!
    var tempPluginPath: String! {
        get {
            return tempPluginURL.path
        }
    }
    
    override public func setUp() {
        super.setUp()
        
        // Create the plugins directory
        tempPluginsDirectoryURL = temporaryDirectoryURL
            .appendingPathComponent(testPluginsDirectoryPathComponent)

        do {
            try FileManager.default
                .createDirectory(at: tempPluginsDirectoryURL,
                    withIntermediateDirectories: false,
                    attributes: nil)
        } catch let error as NSError {
            XCTAssertTrue(false, "Creating the directory should succeed \(error)")
        }
       
        // Copy the bundle resources plugin to the plugins directory
        let bundleResourcesPluginURL = PotionTaster.urlForPlugin(withName: testPluginName)!
        let filename = testPluginName.appendingPathExtension(testPluginExtension)!
        
        tempPluginURL = tempPluginsDirectoryURL.appendingPathComponent(filename)
        do {
            try FileManager.default.copyItem(at: bundleResourcesPluginURL,
                                             to: tempPluginURL)
        } catch let error as NSError {
            XCTAssertTrue(false, "Moving the directory should succeed \(error)")
        }
    }
    
    override public func tearDown() {
        tempPluginsDirectoryURL = nil
        tempPluginURL = nil
        
        // Remove the plugins directory (containing the plugin)
        do {
            try removeTemporaryItem(withPathComponent: testPluginsDirectoryPathComponent)
        } catch let error as NSError {
            XCTAssertTrue(false, "Removing the plugins directory should have succeeded \(error)")
        }
        
        super.tearDown()
    }
    
}
