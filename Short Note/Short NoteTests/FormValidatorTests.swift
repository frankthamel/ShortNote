//
//  FormValidatorTests.swift
//  Short Note
//
//  Created by frank thamel on 7/14/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import XCTest
import CoreData
@testable import Short_Note

class FormValidatorTests: XCTestCase {
    
    var coreDataStack : CoreDataStack!
    
    override func setUp() {
        super.setUp()
        
        coreDataStack = TestCoreDataStack()
    }
    
    override func tearDown() {
        super.tearDown()
        
        coreDataStack = nil
    }
    
    func test_isEmptyFields() {
        
        // test nil value
        let expectedResult1 = (status : true ,message : "username can not be blank.")
        let result1 = FormValidator.isEmptyField(nil, withName: "username")
        
        XCTAssertEqual(result1.status, expectedResult1.status)
        XCTAssertEqual(result1.message, expectedResult1.message)
        
        // test empty string value
        let expectedResult2 = (status : true ,message : "username can not be blank.")
        let result2 = FormValidator.isEmptyField("", withName: "username")
        
        XCTAssertEqual(result2.status, expectedResult2.status)
        XCTAssertEqual(result2.message, expectedResult2.message)
        
    }
    
    func test_passwordMismatch() {
        // test password mismatch : false
        let expectedResult1 = (statue : true , message : "Password/Confirm Password mismatch.")
        let result1 = FormValidator.passwordMismatch(password: "Password", confirmPassword: "Pasword")
        
        XCTAssertEqual(result1.status, expectedResult1.statue)
        XCTAssertEqual(result1.message, expectedResult1.message)
        
        // test password mismatch : true
        let expectedResult2 = (statue : false , message : "")
        let result2 = FormValidator.passwordMismatch(password: "Password", confirmPassword: "Password")
        
        XCTAssertEqual(result2.status, expectedResult2.statue)
        XCTAssertEqual(result2.message, expectedResult2.message)
        
    }
    
    func test_usernameTaken() {
        
        let expectedResult = (status : false, message : "")
        let result = FormValidator.usernameTaken(username: "testuser", managedContext: coreDataStack.managedContext)
        
        XCTAssertEqual(result.status, expectedResult.status)
        XCTAssertEqual(result.message, expectedResult.message)
        
    }
}
