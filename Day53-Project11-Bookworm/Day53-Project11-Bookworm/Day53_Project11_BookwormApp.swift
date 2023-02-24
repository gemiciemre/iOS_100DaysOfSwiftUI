//
//  Day53_Project11_BookwormApp.swift
//  Day53-Project11-Bookworm
//
//  Created by Emre Gemici on 21.02.2023.
//

import SwiftUI

@main
struct Day53_Project11_BookwormApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
