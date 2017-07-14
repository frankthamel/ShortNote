//
//  UserAuthenticationTest.swift
//  Short Note
//
//  Created by frank thamel on 7/14/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import XCTest
import CoreData
@testable import Short_Note

class UserAuthenticationTest : XCTestCase {
    var coreDataStack : CoreDataStack!
    
    override func setUp() {
        super.setUp()
        
        coreDataStack = TestCoreDataStack()
    }
    
    override func tearDown() {
        super.tearDown()
        
        coreDataStack = nil
    }
    
    func test_authenticate() {
        
        let expectedResult1 = (status : false , message : FormValidationMessage.passwordMismatch.rawValue)
        let result1 = UserAuthentication.authenticate(user: "tsetuser", encryptedPassword: "password".md5() , managedContext: coreDataStack.managedContext)
        XCTAssertEqual(result1.status, expectedResult1.status)
        XCTAssertEqual(result1.message, expectedResult1.message)
    }
}
