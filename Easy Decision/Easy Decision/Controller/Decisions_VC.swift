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
//    @IBOutlet weak var addBtn: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        moduleInit()
        setupView()
    }
}

//
// Setup Functions
//
extension Decisions_VC: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return limit
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "decision_cell", for: indexPath) as! TextInputCell
        cell.textField.delegate = self
        cell.textField.placeholder = "Write Decision..."

        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {

    }
    
    func setupView() {
        self.tableView!.tableFooterView = UIView(frame: .zero)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
    }
    
//    @IBAction func addNewDecision() -> Void {
//        if self.decision_list.count < limit {
//
//            var index = IndexPath(row: self.decision_list.count - 1, section: 0)
//            var cell = self.tableView?.cellForRow(at: index) as! TextInputCell
//            cell.textField.endEditing(true)
//            log("Edited disabled for cell at \(index) in UITableView,")
//
//            updateAddBtnPos()
//
//            index = IndexPath(row: self.decision_list.count - 1, section: 0)
//            cell = self.tableView?.cellForRow(at: index) as! TextInputCell
//            cell.textField.becomeFirstResponder()
//        } else {
//            // Notify the user
//            limitAlert()
//        }
//    }
    @IBAction func submitDecisions() -> Void {
        log("Submitting the decision list containing: \(self.decision_list)")
        saveDecisionList(decisionlist:&self.decision_list, rowsize:limit, tbv:self.tableView!)
    }
    
    @IBAction func clearDecisions() -> Void {
//        resetBtnPosition()
        resetTableViewCells(rowsize: limit)
    }
}

// Protocol Functions
extension Decisions_VC {
    func moduleInit()
    {
        self.decision_list = [Decision]()
    }
}




