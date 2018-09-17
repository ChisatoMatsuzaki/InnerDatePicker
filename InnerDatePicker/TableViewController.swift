//
//  TableViewController.swift
//  InnerDatePicker
//
//  Created by Chisato Matsuzaki on 2018/09/17.
//  Copyright © 2018年 EnchantedWorks. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var datePickerIndexPath: IndexPath? = nil
    var dataList: [[String]] = [
        ["LabelCell", "label 1"],
        ["DateSelectCell", "日付を選択してください"],
        ["DateSelectCell", "日付を選択してください"],
        ["LabelCell", "label 2"]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // -----------------------------------------------------
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataList[indexPath.row][0] == "DatePickerCell" {
            return 206.0
        } else {
            return 60.0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: dataList[indexPath.row][0], for: indexPath)

        switch dataList[indexPath.row][0] {
        case "DateSelectCell":
            let cell = cell as! DateSelectCell
            cell.label.text = dataList[indexPath.row][1]
        case "DatePickerCell":
            break
        default:
            let cell = cell as! LabelCell
            cell.label.text = dataList[indexPath.row][1]
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        if let datePickerIndexPath = self.datePickerIndexPath {
            // 表示されている
            if cell.reuseIdentifier == "DateSelectCell" && !(datePickerIndexPath.row - 1 == indexPath.row) {
                let index = datePickerIndexPath.row < indexPath.row ? indexPath.row : indexPath.row + 1
                hideDatePicker(indexPath: datePickerIndexPath)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.showDatePicker(indexPath: IndexPath(row: index, section: indexPath.section))
                }
            } else {
                hideDatePicker(indexPath: datePickerIndexPath)
            }
            
        } else {
            // 表示されていない
            if cell.reuseIdentifier == "DateSelectCell" {
                showDatePicker(indexPath: IndexPath(row: indexPath.row + 1, section: indexPath.section))
            }
        }
    }
}

extension TableViewController {
    fileprivate func showDatePicker(indexPath: IndexPath) {
        dataList.insert(["DatePickerCell",""], at: indexPath.row)
        tableView.insertRows(at: [indexPath], with: .fade)
        datePickerIndexPath = indexPath
    }
    
    fileprivate func hideDatePicker(indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? DatePickerCell {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.short
            dateFormatter.timeStyle = DateFormatter.Style.short
            dataList[indexPath.row - 1][1] = dateFormatter.string(from: cell.datePicker.date)
        }
        dataList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        datePickerIndexPath = nil
        tableView.reloadData()
    }
}
