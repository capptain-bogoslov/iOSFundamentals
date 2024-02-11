//
//  DateHandler.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 10/2/24.
//

import Foundation


class DateHandler {
    
    static let shared: DateHandler = DateHandler()
    
   
    //return date in correct format
    func getDate(input: String?) -> String? {
        guard let input else { return nil }
        let dateFormatter = DateFormatter()
        //pass the date form from the API
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //transform it to date
        guard let date = dateFormatter.date(from: input) else { return nil }
        //format to desired date format
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
}
