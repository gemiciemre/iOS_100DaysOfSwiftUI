//
//  DataController.swift
//  Day53-Project11-Bookworm
//
//  Created by Emre Gemici on 22.02.2023.
//

import CoreData
import Foundation

class DataController : ObservableObject{
    let container = NSPersistentContainer(name: "Bookworm")
    
    init(){
        container.loadPersistentStores{description, error in
            if let error = error{
                print("Core Data Failed to Load \(error.localizedDescription)")
            }
        }
    }
}
