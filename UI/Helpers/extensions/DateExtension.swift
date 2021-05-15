//
//  UIDateExtension.swift
//  UI
//
//  Created by Anderson Chagas on 15/05/21.
//

import Foundation

extension Date {
    
    func dateFormatter_weekDay_day_moth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.dateFormat = "EEEE, d MMMM"
        dateFormatter.locale = Locale(identifier: "pt_BR")
        return dateFormatter.string(from: self)
    }
}
