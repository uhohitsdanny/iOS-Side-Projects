//
//  ViewController.swift
//  Easy Decision
//
//  Created by Danny Navarro on 2/14/18.
//

import UIKit

class Decisions_VC: UIViewController {
    
    var decision_list = [String]()
    var decision_count: Int = 1
    var cell_height: CGFloat?
    let limit: Int = 6

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var addBtn: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
    }
}

//
// Setup Functions
//
extension Decisions_VC: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (decision_list.count + 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "decision_cell", for: indexPath) as! TextInputCell
        cell.textField.delegate = self
        cell.textField.placeholder = "Write Decision..."

        return cell
    }
    
    func setupView() {
        self.tableView!.tableFooterView = UIView(frame: .zero)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
    }    
}

//
// Actions
//
extension Decisions_VC {
    @IBAction func addNewDecision() -> Void {
        if decision_count < limit {
            let cell = tableView?.dequeueReusableCell(withIdentifier: "decision_cell", for: IndexPath(row: decision_count, section: 1)) as! TextInputCell
            cell.textField.isUserInteractionEnabled = false;
            
            let text = cell.textField.text
            self.decision_list.append(text!)
            
            tableView!.beginUpdates()
            tableView!.insertRows(at: [IndexPath(row: decision_count, section: 0)], with: .automatic)
            tableView!.endUpdates()
            
            updateAddBtnPos()
            self.decision_count += 1

        } else {
            // Notify the user
            limitAlert()
        }
    }
    
    @IBAction func clearDecisions() -> Void {
        resetBtnPosition()
        resetTableViewCells()
    }
}



