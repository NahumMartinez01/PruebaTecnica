//
//  AppUtils.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 21/10/25.
//

import Foundation

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
