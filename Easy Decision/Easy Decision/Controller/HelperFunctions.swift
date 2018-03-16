//
//  HelperFunctions.swift
//  Easy Decision
//
//  Created by Danny Navarro on 2/28/18.
//
import UIKit

extension Decisions_VC {
    
    func decisionsAlert() -> Void {
        let alert = UIAlertController(title: "Decisions need to be made!", message: "There are no decisions added", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
//    func updateAddBtnPos() -> Void {
//        let frame = tableView?.rectForRow(at: IndexPath(item: 0, section: 0))
//        self.cell_height = (frame?.size.height)! * CGFloat(self.decision_list.count - 1)
//        UIView.animate(withDuration: 0.3, animations: {   self.addBtn?.transform = CGAffineTransform(translationX: 0, y: self.cell_height!) })
//    }
    func saveDecisionList(decisionlist:inout[Decision], rowsize:Int, tbv:UITableView)
    {
        var indexPath: IndexPath
        var cell: TextInputCell
        
        for index in stride(from: 0, to: rowsize, by: 1)
        {
            indexPath = IndexPath(row:index, section:0)
            cell = tbv.cellForRow(at: indexPath) as! TextInputCell
            if !textfieldIsEmpty(cell.textField) {
                var new_decision = Decision()
                new_decision.setDecision(decision: cell.textField.text!)
                new_decision.setDecisionID(id: index)
                decisionlist.append(new_decision)
            }
        }
        
        if checkForEmptyDecisionList(decisionlist) {
            decisionsAlert()
        }
        else {
            log("\(decisionlist)")
        }
    }
    
    func textfieldIsEmpty(_ textfield:UITextField) -> Bool {
        if textfield.text! == "" {
            return true
        }
        else {
            return false
        }
    }
    
    func checkForEmptyDecisionList(_ decisionlist: [Decision]) -> Bool
    {
        if decisionlist.count <= 0 {
            return true
        }
        else {
            return false
        }
    }

    
//    func resetBtnPosition() -> Void {
//        let frame = tableView?.rectForRow(at: IndexPath(item: 0, section: 0))
//        self.cell_height = (frame?.size.height)! * CGFloat(self.decision_list.count + 1)
//        UIView.animate(withDuration: 0.3, animations: {
//            self.addBtn?.transform = CGAffineTransform(translationX: 0, y:0)
//        })
//    }
    
    func resetTableViewCells(rowsize:Int) -> Void {
        for index in stride(from: 0, through: rowsize, by: 1)
        {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = self.tableView?.cellForRow(at: indexPath) as! TextInputCell
            cell.textField.text = ""
            self.moduleInit()
        }
    }
}
