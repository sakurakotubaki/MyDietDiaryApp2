//
//  GraphDateTitleFormatter.swift
//  MyDietDiaryApp2
//
//  Created by 橋本純一 on 2021/12/10.
//

import Foundation
import Charts

class GraphDateTitleFormatter: IAxisValueFormatter {
    var dateList: [Date] = []
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        guard dateList.count > index else { return "" }
        let targetDate = dateList[index]
        let formatter = DateFormatter()
        let dateFormatString = "M/d"
        formatter.dateFormat = dateFormatString
        return formatter.string(from: targetDate)
    }
}
