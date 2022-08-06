//
//  MonthlySummaryCell.swift
//  MyFocus
//
//  Created by Eva Madarasz on 06/08/2022.
//

import UIKit



class SummaryCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
let historyVC = HistoryListViewController()
    
    func configureCell(item: ListElement) {
        title.textAlignment = .left
        title.text = item.title
    }
}


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
