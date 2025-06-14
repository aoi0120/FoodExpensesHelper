//
//  PickerAlertView.swift
//  FoodExpensesHelper
//
//  Created by AoiKobayashi on 2025/06/08.
//

import SwiftUI

struct PickerAlertView: UIViewControllerRepresentable {
    var title: String
    var values: [Int]
    @Binding var selectedValue: Int
    var onCancel: (() -> Void)? = nil
    var onOK: (() -> Void)? = nil
    
    @Environment(\.dismiss) var dismiss
    
    //ダミーのUIViewを返してUIAler表示用
    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }
    
    //アラート表示処理
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
        guard uiViewController.presentedViewController == nil else { return }
        
        let alert = UIAlertController(title: title, message: "\n\n\n\n\n\n", preferredStyle: .alert)
        
        let picker = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        
        if let idx = values.firstIndex(of: selectedValue) {
            picker.selectRow(idx, inComponent: 0, animated: false)
        }
        
        alert.view.addSubview(picker)
        
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel) { _ in
            self.onCancel?()
        }
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) {
            _ in
            selectedValue = values[picker.selectedRow(inComponent: 0)]
            onOK?()
        })
        
        DispatchQueue.main.async {
            uiViewController.present(alert, animated: true)
        }
        
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(values: values) { selected in
            selectedValue = selected
        }
    }
    
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        var values: [Int]
        var onSelect: (Int) -> Void
        
        init(values: [Int], onSelect: @escaping (Int) -> Void) {
            self.values = values
            self.onSelect = onSelect
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return values.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return "\(values[row])"
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            onSelect(values[row])
        }
    }
}
