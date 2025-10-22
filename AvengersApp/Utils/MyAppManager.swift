//
//  MyAppManager.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 21/10/25.
//

import Foundation

class MyAppManager: ObservableObject {
    @Published var isLoadingView: Bool = true 
    
    private static let myAppManager: MyAppManager = {
        return MyAppManager()
    }()
    
    static func shared() -> MyAppManager {
        return self.myAppManager
    }
    
}
