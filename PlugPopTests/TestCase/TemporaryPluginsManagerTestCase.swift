//
//  TemporaryPluginsManagerTestCase.swift
//  .
//
//  Created by Roben Kleene on 6/18/17.
//  Copyright (c) 2017 Roben Kleene. All rights reserved.
//

@testable import PlugPop
import XCTest

class TemporaryPluginsManagerTestCase: TemporaryPluginsManagerDependenciesTestCase, PluginsManagerOwnerType {

    var tempPluginsManager: PluginsManager!
    var pluginsManager: PluginsManager {
        return tempPluginsManager
    }

    override func setUp() {
        super.setUp()
        tempPluginsManager = makePluginsManager()
    }
}
