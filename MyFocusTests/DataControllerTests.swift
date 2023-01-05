//
//  DataControllerTests.swift
//  MyFocusTests
//
//  Created by Eva Madarasz on 23/12/2022.
//

import XCTest
import CoreData

@testable import MyFocus





class testDataController: CoreDataManager {
    override init() {
        super.init()
        

          
let persistentStoreDescription = NSPersistentStoreDescription()
    persistentStoreDescription.type = NSInMemoryStoreType

        let container = NSPersistentContainer(name: "FocusData")
        container.persistentStoreDescriptions = [persistentStoreDescription]

        container.loadPersistentStores { _, error in
             if let error = error as NSError? {
               fatalError("Unresolved error \(error), \(error.userInfo)")
             }
           }
        
       let storeContainer = container
    }
}

class DataControllerTests: XCTestCase {

    private var container: testDataController!
    
    var sut = CoreDataManager()
    
    override func setUp() {
        super.setUp()
      let container = NSPersistentContainer(name: "FocusData")
      container.loadPersistentStores { description, error in
        XCTAssertNil(error)
      }
    }
      
    override func tearDown() {
      container = nil
      super.tearDown()
    }

    
    func test_createGoalInitialSuccess() {
        
        
        // ARRANGE:
        let firstGoal = Goal(id: UUID(), tasks: [], title: "", completed: false, creationDate: Date(), achievedDate: Date())
      
        // ACT:
        let newGoal = sut.createGoal(goal: firstGoal)
        sut.saveData()
        
        // ASSERT:
        XCTAssertNotNil(firstGoal)
        XCTAssertNotNil(newGoal)
        
}
    
    
    
}
