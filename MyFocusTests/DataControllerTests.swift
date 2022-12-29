//
//  DataControllerTests.swift
//  MyFocusTests
//
//  Created by Eva Madarasz on 23/12/2022.
//

import XCTest
import CoreData

@testable import MyFocus

var testManager = CoreDataManager()


// let container = CoreDataContainer(name: "FocusData", inMemory: true)

//func destroyPersistentStore() {
//    guard let persistentContainer = NSPersistentContainer()  else {
//        print("Missing container - could not destroy")
//        return
//    }
//
//    do {
//        try NSPersistentContainer.destroyPersistentStore(name: "FocusData")
//    } catch  {
//        print("Unable to destroy persistent store: \(error) - \(error.localizedDescription)")
//   }
//}



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

    

    
    
   

}