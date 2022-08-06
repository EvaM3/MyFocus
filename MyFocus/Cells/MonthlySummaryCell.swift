//
//  MonthlySummaryCell.swift
//  MyFocus
//
//  Created by Eva Madarasz on 06/08/2022.
//

import UIKit


let date = Date()
let calendar = Calendar.current


extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
}
let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: date)

func getMonthlySummary() {
    let components = date.get(.day, .month, .year)
    if let day = components.day, let month = components.month, let year = components.year {
        print("day: \(day), month: \(month), year: \(year)")
    }
}

