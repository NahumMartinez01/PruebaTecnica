//
//  ContentView.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 21/10/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var myAppManager: MyAppManager
    @State private var path = [Movie]()
    
    var body: some View {
        ZStack {
            NavigationStack(path: $path) {
                HomeView(path: $path)
            }
          
            if myAppManager.isLoadingView {
                ZStack {
                    Color.clear
                        .background(.ultraThinMaterial)
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(.white)
                }
                .transition(.opacity)
                .zIndex(1)
            }
        }
    }
    
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .environmentObject(MyAppManager())
}
