//
//  HideTabBar.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 22/10/25.
//

import Foundation
import SwiftUI

struct HideTabBar<Content: View>: UIViewControllerRepresentable {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    func makeUIViewController(context: Context) -> UIHostingController<Content> {
        let controller = UIHostingController(rootView: content)
        controller.hidesBottomBarWhenPushed = true
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIHostingController<Content>, context: Context) {
        uiViewController.rootView = content
        uiViewController.hidesBottomBarWhenPushed = true
    }
}
