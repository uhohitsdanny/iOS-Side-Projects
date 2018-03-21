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
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        log("Done editing at indexpath \(indexPath?.row ?? 0)")
    }
    
    func setupView() {
        self.tableView!.tableFooterView = UIView(frame: .zero)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
    }
    
    @IBAction func submitDecisions() -> Void {
        saveDecisionList(decisionlist:&self.decision_list, rowsize:limit, tbv:self.tableView!)
        let decisionPackage = DecisionPackage(dlist: self.decision_list)
        decisionPackage.queryGoogleImages()
    }
    
    @IBAction func clearDecisions() -> Void {
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




