//
//  DateHelper.swift
//  MovieFlix
//
//  Created by Karrar Abd Ali on 04/08/2021.
//  Copyright © 2021 Karrar Abd Ali. All rights reserved.
//

import Foundation

struct DateHelper {
    func stringISOStringReleased(dateString: String?) -> String {
        if let dateString = dateString {
            let date = stringToDate(string: dateString)

            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            
            if let date = date {
                let dateStringData = formatter.string(from: date)
                return dateStringData
            }
        }

        return ""
    }
    
    private func stringToDate(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: string)
        return date
    }
}
