//
//  ViewController.swift
//  Easy Decision
//
//  Created by Danny Navarro on 2/14/18.
//

import UIKit

class Decisions_VC: UIViewController {
    
    var decisionPackage:DecisionPackage? = nil
    var decision_list = [Decision]()
    var cellText = [String]()
    var cell_height: CGFloat?
    let limit: Int = 6

    @IBOutlet weak var tableView: UITableView?
    var inputActive: UITextField!
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
        cell.textField.adjustsFontSizeToFitWidth = true
        cell.textField.returnKeyType = .done
        cell.textField.autocorrectionType = .no
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        log("Done editing at indexpath \(indexPath?.row ?? 0)")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.inputActive = textField
        return true
    }
    
    func setupView() {
        self.tableView!.tableFooterView = UIView(frame: .zero)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
    }
    
    @IBAction func submitDecisions() -> Void {
        saveDecisionList(decisionlist:&self.decision_list, rowsize:limit, tbv:self.tableView!)
        self.decisionPackage = DecisionPackage(dlist: self.decision_list)
        self.decisionPackage!.queryGoogleImages()
        performSegue(withIdentifier: "imageSegue", sender: self)
    }
    
    @IBAction func clearDecisions() -> Void {
        resetTableViewCells(rowsize: limit)
    }
    
    func registerNotifications()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        var userInfo = notification.userInfo!
        if let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            // Get my height size
            let myheight = tableView?.frame.height
            // Get the top Y point where the keyboard will finish on the view
            let keyboardEndPoint = myheight! - keyboardFrame.height
            // Get the the bottom Y point of the textInput and transform it to the currentView coordinates.
            if let pointInTable = inputActive.superview?.convert(inputActive.frame.origin, to: tableView) {
                let textFieldBottomPoint = pointInTable.y + inputActive.frame.size.height + 20
                // Finally check if the keyboard will cover the textInput
                if keyboardEndPoint <= textFieldBottomPoint {
                    tableView?.contentOffset.y = textFieldBottomPoint - keyboardEndPoint
                } else {
                    tableView?.contentOffset.y = 0
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        tableView?.contentOffset.y = 0
    }
}

// Protocol Functions
extension Decisions_VC {
    func moduleInit()
    {
        self.decision_list = [Decision]()
    }
}

//Segue Functions
extension Decisions_VC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageSegue" {
            if let destinationVC = segue.destination as? DisplayDecision_VC {
                let rndmIndex = Int(arc4random_uniform(UInt32(self.decision_list.count)))
                
                destinationVC.decisionTitle = self.decision_list[rndmIndex].str  
                destinationVC.googleImg = self.decisionPackage!.googleImages[rndmIndex]
            }
        }
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        
    }
}




