//
//  EditorViewController.swift
//  MyDietDiaryApp2
//
//  Created by 橋本純一 on 2021/12/02.
//

import UIKit

class EditorViewController: UIViewController {
    @IBOutlet weak var inputWeightTextField: UITextField!
    @IBOutlet weak var inputDateTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var datePicker: UIDatePicker {
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.timeZone = .current
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ja-JP")
        datePicker.date = Date()
        datePicker.addTarget(self, action: #selector(didChangeDate), for: .valueChanged)
        return datePicker
    }
    
    var toolBar: UIToolbar {
        let toolBarRect = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35)
        let toolBar = UIToolbar(frame: toolBarRect)
        let doneItem = UIBarButtonItem(barButtonSystemItem:.done, target: self, action: #selector(didTapDone))
        toolBar.setItems([doneItem], animated: true)
        return toolBar
    }
    
    var dateFormatter: DateFormatter {
        let dateFormatt = DateFormatter()
        dateFormatt.dateStyle = .long
        dateFormatt.timeZone = .current
        dateFormatt.locale = Locale(identifier: "ja-JP")
        return dateFormatt
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWeightTextField()
        configureDateTextField()
        configureSaveButton()
    }
    
    @objc func didTapDone() {
        view.endEditing(true)
    }
    
    func configureWeightTextField() {
        inputWeightTextField.inputAccessoryView = toolBar
    }
    
    func configureDateTextField() {
        inputDateTextField.inputView = datePicker
        inputDateTextField.inputAccessoryView = toolBar
        inputDateTextField.text = dateFormatter.string(from: Date())
    }
    
    @objc func didChangeDate(picker: UIDatePicker) {
        inputDateTextField.text = dateFormatter.string(from: picker.date)
    }
    
    func configureSaveButton() {
        saveButton.layer.cornerRadius = 5
    }
}
