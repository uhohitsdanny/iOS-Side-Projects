//
//  HelperFunctions.swift
//  Easy Decision
//
//  Created by Danny Navarro on 2/28/18.
//
import UIKit

extension Decisions_VC {
    
    func limitAlert() -> Void {
        let alert = UIAlertController(title: "Limit is 6 decisions", message: "You're too indecisive!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateAddBtnPos() -> Void {
        let frame = tableView?.rectForRow(at: IndexPath(item: 0, section: 0))
        self.cell_height = (frame?.size.height)! * CGFloat(self.decision_list.count)
        UIView.animate(withDuration: 0.3, animations: {   self.addBtn?.transform = CGAffineTransform(translationX: 0, y: self.cell_height!) })
    }
    
    func resetBtnPosition() -> Void {
        let frame = tableView?.rectForRow(at: IndexPath(item: 0, section: 0))
        self.cell_height = (frame?.size.height)! * CGFloat(self.decision_list.count + 1)
        UIView.animate(withDuration: 0.3, animations: {
            self.addBtn?.transform = CGAffineTransform(translationX: 0, y:0)
        })
    }
    
    func resetTableViewCells() -> Void {
        for index in stride(from: self.decision_list.count, to: 0, by: -1){
            self.decision_list.remove(at: index - 1)
            
            let indexPath = IndexPath(row: index, section: 0)
            self.tableView?.beginUpdates()
            self.tableView?.deleteRows(at: [indexPath], with: .automatic)
            self.tableView?.endUpdates()
        }
    }
}
