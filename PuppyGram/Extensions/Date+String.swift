//
//  Date+String.swift
//  PuppyGram
//
//  Created by Kerby Jean on 5/12/21.
//

import Foundation

// Add a format parameter to dateFormatter
extension DateFormatter {
    convenience init (format: String) {
        self.init()
        dateFormat = format
        locale = Locale.current
    }
}

// Convert dateFormatter to String
extension Date {
    func toString (dateFormatter: DateFormatter) -> String? {
        return dateFormatter.string(from: self)
    }
}

// Capitalize first letter in String
// In case it's not
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
