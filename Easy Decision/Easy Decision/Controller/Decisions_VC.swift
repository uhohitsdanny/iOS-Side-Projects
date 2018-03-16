//
//  ViewController.swift
//  Easy Decision
//
//  Created by Danny Navarro on 2/14/18.
//

import UIKit

class Decisions_VC: UIViewController {
    
    var decision_list = [Decision]()
    var cellText = [String]()
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.isUserInteractionEnabled = false;
        var new_decision: Decision = Decision()
        let text = textField.text
        new_decision.setDecision(decision: text!)
        
        self.decision_list.append(new_decision)
        self.tableView!.beginUpdates()
        self.tableView!.insertRows(at: [IndexPath(row: self.decision_list.count , section: 0)], with: .automatic)
        self.tableView!.endUpdates()    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "decision_cell", for: indexPath!) as! TextInputCell
        let index = indexPath?.row
        var new_decision: Decision = self.decision_list[index!]
        new_decision.setDecision(decision: cell.textField.text!)
    }
    
    func setupView() {
        self.tableView!.tableFooterView = UIView(frame: .zero)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
    }
    
    @IBAction func addNewDecision() -> Void {
        if self.decision_list.count + 1 < limit {
            
            var index = IndexPath(row: self.decision_list.count, section: 0)
            var cell = self.tableView?.cellForRow(at: index) as! TextInputCell
            cell.textField.endEditing(true)
            log("Edited disabled for cell at row \(index), section 0 ")
            
            updateAddBtnPos()
            
            index = IndexPath(row: self.decision_list.count, section: 0)
            cell = self.tableView?.cellForRow(at: index) as! TextInputCell
            cell.textField.becomeFirstResponder()
        } else {
            // Notify the user
            limitAlert()
        }
    }
    @IBAction func submitDecisions() -> Void {
        print("\(self.decision_list)")
    }
    
    @IBAction func clearDecisions() -> Void {
        resetBtnPosition()
        resetTableViewCells()
    }
}




