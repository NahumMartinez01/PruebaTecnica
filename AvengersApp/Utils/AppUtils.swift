//
//  AppUtils.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 21/10/25.
//

import Foundation
import SwiftUI
class AppUtils {
    
   static func formattedDate(from dateString: String, languageCode: String) -> String {
        let formatterGet = DateFormatter()
        formatterGet.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatterGet.date(from: dateString) else {
            return dateString
        }
        
        let formatterPrint = DateFormatter()
        formatterPrint.locale = Locale(identifier: languageCode)
        formatterPrint.dateFormat = "dd MMMM yyyy"
        
        return formatterPrint.string(from: date)
    }
}

struct NavigationBarConfigurator {
    static func setColor(backgroundColor: Color, titleColor: Color = .white) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(backgroundColor)
        appearance.titleTextAttributes = [.foregroundColor: UIColor(titleColor)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(titleColor)]
        appearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
}
