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
    var cg_dc: CGFloat = 1
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
    
    @IBAction func addNewDecision() -> Void {
        if decision_count < limit {
            let cell = tableView?.dequeueReusableCell(withIdentifier: "decision_cell", for: IndexPath(row: decision_count, section: 1)) as! TextInputCell
            cell.textField.isUserInteractionEnabled = false;
            
            let text = cell.textField.text
            decision_list.append(text!)
            decision_count += 1
            
            
            tableView!.beginUpdates()
            tableView!.insertRows(at: [IndexPath(row: decision_count-1, section: 0)], with: .automatic)
            tableView!.endUpdates()
            
            updateAddBtnPos()
        } else {
            // Notify the user
            limitAlert()
        }
    }
}

extension Decisions_VC {
    
    func limitAlert() -> Void {
        let alert = UIAlertController(title: "Limit is 5 decisions", message: "You're too indecisive!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateAddBtnPos() -> Void {
        let frame = tableView?.rectForRow(at: IndexPath(item: 0, section: 0))
        self.cell_height = (frame?.size.height)! * cg_dc
        UIView.animate(withDuration: 0.3, animations: {   self.addBtn?.transform = CGAffineTransform(translationX: 0, y: self.cell_height!) })
        cg_dc += 1
    }
}


