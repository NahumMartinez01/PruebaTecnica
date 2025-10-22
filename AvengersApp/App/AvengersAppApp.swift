//
//  AvengersAppApp.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 21/10/25.
//

import SwiftUI

@main
struct AvengersAppApp: App {
    @StateObject var myAppManager = MyAppManager.shared()
    let persistenceController = PersistenceController.shared
    

    var body: some Scene {
        WindowGroup {
                ContentView()
                    .environmentObject(myAppManager)
                    .environment(\.managedObjectContext, persistenceController.context)
        }
    }
}
