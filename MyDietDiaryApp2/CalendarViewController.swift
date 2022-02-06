//
//  CalendarViewController.swift
//  MyDietDiaryApp2
//
//  Created by 橋本純一 on 2021/12/01.
//

import UIKit
import FSCalendar
import RealmSwift

class CalenderViewController: UIViewController {
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var addButton: UIButton!
    @IBAction func addButton(_ sender: UIButton) {
        transitionToEditorView()
    }
    
    var recordList: [WeightRecord] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCalendar()
        configureButton()
        // FSCalendarDateSourceを有効化
        calendarView.dataSource = self
        // FSCalendarDelegateを有効化
        calendarView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRecord()
        calendarView.reloadData()
    }
    
    func configureCalendar() {
        // ヘッダーの日付フォーマットを変更
        calendarView.appearance.headerDateFormat = "yyyy年MM月dd日"
        // 曜日と今日の色を指定
        calendarView.appearance.todayColor = .orange
        calendarView.appearance.headerTitleColor = .orange
        calendarView.appearance.weekdayTextColor = .black
        // 曜日表示内容を変更
        calendarView.calendarWeekdayView.weekdayLabels[0].text = "日"
        calendarView.calendarWeekdayView.weekdayLabels[1].text = "月"
        calendarView.calendarWeekdayView.weekdayLabels[2].text = "火"
        calendarView.calendarWeekdayView.weekdayLabels[3].text = "水"
        calendarView.calendarWeekdayView.weekdayLabels[4].text = "木"
        calendarView.calendarWeekdayView.weekdayLabels[5].text = "金"
        calendarView.calendarWeekdayView.weekdayLabels[6].text = "土"
        // 土日の色を変更
        calendarView.calendarWeekdayView.weekdayLabels[0].textColor = .red
        calendarView.calendarWeekdayView.weekdayLabels[6].textColor = .blue
    }
    
    func configureButton() {
        addButton.layer.cornerRadius = addButton.bounds.width / 2
    }
    
    func transitionToEditorView(with record: WeightRecord? = nil) {
        let storyboad = UIStoryboard(name: "EditorViewController", bundle: nil)
        guard let editorViewController =
                storyboad.instantiateInitialViewController()
                as? EditorViewController else { return }
        if let record = record {
            editorViewController.record = record
        }
        editorViewController.delegate = self
        present(editorViewController, animated: true)
    }
    
    func getRecord() {
        let realm = try! Realm()
        recordList = Array(realm.objects(WeightRecord.self))
    }
}

extension CalenderViewController: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateList = recordList.map({ $0.date.zeroclock })
        // 比較対象のDate型の年月日が一致していた場合にtrueになる
        let isEqualDate = dateList.contains(date.zeroclock)
        return isEqualDate ? 1 : 0
    }
}

extension CalenderViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        calendar.deselect(date)
        guard let record = recordList.first(where: { $0.date.zeroclock == date.zeroclock }) else { return }
        transitionToEditorView(with: record)
    }
}

extension CalenderViewController: EditorViewControllerDelegate {
    func recordUpdate() {
        getRecord()
        calendarView.reloadData()
    }
}
