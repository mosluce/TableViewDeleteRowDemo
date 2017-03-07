//
//  DemoTableViewController.swift
//  TableViewEditDemo
//
//  Created by 默司 on 2017/3/8.
//  Copyright © 2017年 默司. All rights reserved.
//

import UIKit

class DemoTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var items: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    var indexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SimpleCell")
        self.tableView.tableFooterView = UIView()
        //self.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTableView() {
        let item = self.items[indexPath.row + indexPath.section * 4]
        let index = self.items.index(of: item)!
        
        self.items.remove(at: index)
        
        if indexPath.section == 0 { // 移除對象在 section 0
            let s0rows = self.tableView(tableView, numberOfRowsInSection: 0)
            //let s1rows = self.tableView(tableView, numberOfRowsInSection: 1)
            
            if s0rows == 4 { // section 1 還沒被吃完
                self.tableView.deleteRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
                
                var indexPaths: [IndexPath] = []
                
                for i in indexPath.row...3 {
                    indexPaths.append(IndexPath(row: i, section: 0))
                }
                
                self.tableView.reloadRows(at: indexPaths, with: .automatic)
            } else { // section 1 被吃完， section 0 開始吃自己
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        } else { // 移除對象在 section 1
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

}

extension DemoTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return min(4, items.count)
        } else {
            return max(0, items.count - 4)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleCell")!
        
        cell.textLabel?.text = "\(items[indexPath.row + indexPath.section * 4])"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else {
            return
        }
        
        let alert = UIAlertController(title: "Delete?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                self.updateTableView()
            })
        }))
        
        self.indexPath = indexPath
        self.present(alert, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "section \(section + 1)"
        label.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}
